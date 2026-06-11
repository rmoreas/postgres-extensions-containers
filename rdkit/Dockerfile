# SPDX-FileCopyrightText: Copyright © contributors to CloudNativePG, established as CloudNativePG a Series of LF Projects, LLC.
# SPDX-License-Identifier: Apache-2.0


ARG BASE=ghcr.io/cloudnative-pg/postgresql:18-minimal-trixie
FROM $BASE AS builder

ARG PG_MAJOR
ARG EXT_VERSION

USER 0

# TODO: Remove this comment block after customizing the Dockerfile
# Instructions:
# 1. Remove all TODO comment blocks after completing the customization.
# 2. Uncomment and customize the COPY/RUN commands below.
# 3. If your extension requires additional system libraries, ensure they are
#    copied to /lib.

# Install extension via `apt-get`
RUN set -eux && \
    # Initial system libraries
    ldconfig -p | awk '{print $NF}' | grep '^/' | sort | uniq > /tmp/base-image-libs.out && \
    # Install RDKit
    apt-get update && \
    apt-get install -y --no-install-recommends \
            "postgresql-${PG_MAJOR}-rdkit=${EXT_VERSION}"

# Gather RDKit system libraries and their licenses
RUN mkdir -p /system /licenses && \
    # Get libraries
    ldd /usr/lib/postgresql/${PG_MAJOR}/lib/rdkit*.so \
        | awk '{print $3}' | grep '^/' | sort | uniq > /tmp/all-deps.out && \
    # Extract all the libs that aren't already part of the base image
    comm -13 /tmp/base-image-libs.out /tmp/all-deps.out > /tmp/libraries.out && \
    while read -r lib; do \
        resolved=$(readlink -f "$lib"); \
        dir=$(dirname "$lib"); \
        base=$(basename "$lib"); \
        # Copy the real file
        cp -a "$resolved" /system/; \
        # Reconstruct all its symlinks
        for file in "$dir"/"${base%.so*}.so"*; do \
            [ -e "$file" ] || continue; \
            # If it's a symlink and it resolves to the same real file, we reconstruct it
            if [ -L "$file" ] && [ "$(readlink -f "$file")" = "$resolved" ]; then \
                ln -sf "$(basename "$resolved")" "/system/$(basename "$file")"; \
            fi; \
        done; \
    done < /tmp/libraries.out && \
    # Get licenses
    for lib in $(find /system -maxdepth 1 -type f -name '*.so*'); do \
        # Get the name of the pkg that installed the library
        pkg=$(dpkg -S "$(basename "$lib")" | grep -v "diversion by" | awk -F: '/:/{print $1; exit}'); \
        [ -z "$pkg" ] && continue; \
        mkdir -p "/licenses/$pkg" && cp -a "/usr/share/doc/$pkg/copyright" "/licenses/$pkg/copyright"; \
    done

FROM scratch
ARG PG_MAJOR

# Licenses
COPY --from=builder /licenses /licenses/
COPY --from=builder /usr/share/doc/postgresql-${PG_MAJOR}-rdkit/copyright /licenses/postgresql-${PG_MAJOR}-rdkit/

# Libraries
COPY --from=builder \
    /usr/lib/postgresql/${PG_MAJOR}/lib/rdkit* \
    /lib/
COPY --from=builder /system /system/

# Share
COPY --from=builder \
    /usr/share/postgresql/${PG_MAJOR}/extension/rdkit* \
    /share/extension/

USER 65532:65532
