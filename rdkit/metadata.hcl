# SPDX-FileCopyrightText: Copyright © contributors to CloudNativePG, established as CloudNativePG a Series of LF Projects, LLC.
# SPDX-License-Identifier: Apache-2.0
metadata = {
  name                     = "rdkit"
  sql_name                 = "rdkit"

  image_name               = "rdkit"

  licenses                 = ["BSD-3-clause"]

  shared_preload_libraries = []

  # TODO: Remove this comment block after customizing the file.
  # `postgresql_parameters`: custom PostgreSQL configuration parameters to be set
  # for this extension. This is a map of key-value pairs.
  # This option should be reserved for parameters that are strictly necessary
  # for the extension to function properly. Avoid setting parameters that just
  # customize the behavior of the extension.
  # Usually empty.
  # Used in tests.
  # Example: { "pgaudit.log_client" = "on" }.
  postgresql_parameters    = {}

  # TODO: Remove this comment block after customizing the file.
  # `extension_control_path`: if EMPTY (`[]`), the operator follows the CNPG
  # convention and will add the image's `share` directory to
  # `extension_control_path`. Usually empty.
  # Used in tests and to generate image catalogs.
  # See: https://cloudnative-pg.io/docs/current/imagevolume_extensions#image-specifications
  extension_control_path   = []

  # TODO: Remove this comment block after customizing the file.
  # `dynamic_library_path`: if EMPTY (`[]`) the operator will add the image's
  # `lib` directory to `dynamic_library_path`. Usually empty.
  # Used in tests and to generate image catalogs.
  dynamic_library_path     = []

  # TODO: Remove this comment block after customizing the file.
  # `ld_library_path`: this SHOULD be defined when your extension needs
  # additional (usually system) libraries loaded into Postgres before startup.
  # If left EMPTY (`[]`) the operator will NOT alter `ld_library_path`. See the
  # `postgis` extension metadata for an example usage. Usually empty.
  # Used in tests and to generate image catalogs.
  ld_library_path          = ["/system"]

  # TODO: Remove this comment block after customizing the file.
  # `bin_path`: this SHOULD be defined when your extension needs executables
  # to be present in the PATH of the PostgreSQL process to function properly.
  # For most extensions, the default empty list (`[]`) is correct and the
  # operator will NOT alter `PATH`.
  # Each path provided is appended to the `PATH` environment variable for the
  # Postgres process. Used in tests and to generate image catalogs.
  bin_path                 = []

  # TODO: Remove this comment block after customizing the file.
  # `env`: Optional map of environment variables to be injected into the
  # PostgreSQL process for this extension.
  #
  # NOTE: Both HCL and the CNPG operator use `${...}` for placeholder
  # expansion. In both systems, `$${...}` is the escape that produces a
  # literal `${...}` in the output (`$$` without a following `{` is kept
  # as-is).
  #
  # 1. CNPG Placeholders: Use `$${...}` to pass a placeholder through HCL
  #    to the operator, which then expands it.
  #    Example: { "LIB_PATH" = "$${image_root}/lib" }
  #    HCL output: ${image_root}/lib -> Operator expands to the mount path
  #
  # 2. Literal `${...}`: Use `$$${...}` so that HCL produces `$${...}`,
  #    which the operator then treats as a literal `${...}`.
  #    Example: { "TOKEN_FORMAT" = "$$${value}" }
  #    HCL output: $${value} -> Operator produces literal: ${value}
  #
  # 3. Static Values: No special escaping needed.
  #    Example: { "DEBUG" = "true" }
  env = {}

  # TODO: Remove this comment block after customizing the file.
  # `auto_update_os_libs`: set to true to allow the maintenance tooling
  # to update OS libraries automatically; look at the `postgis` example.
  auto_update_os_libs      = false

  # TODO: Remove this comment block after customizing the file.
  # `required_extensions`: must contain the name(s) of the sibling
  # folders in this repository that contain a required extension.
  required_extensions      = []

  # TODO: Remove this comment block after customizing the file.
  # `create_extension`: if set to `true` (default), the test suite will
  # automatically run `CREATE EXTENSION` for this project during E2E tests.
  # Set to `false` if the image only provides libraries or tools without
  # a formal Postgres extension object.
  create_extension         = true

  versions = {
    trixie = {
        "18" = {
          // renovate: suite=trixie-pgdg depName=postgresql-18-rdkit
          package = "202503.1-5.pgdg13+1"
          // Examples: \d+\.\d+ for major.minor (e.g., "18.0"), \d+\.\d+\.\d+ for major.minor.patch (e.g., "0.8.2")
          // renovate: suite=trixie-pgdg depName=postgresql-18-rdkit extractVersion=^(?<version>\d+\.\d+\.\d+)
          sql = "4.7.0"
        }
    }
  }
}

variable "distributions" {
  default = [
    "trixie"
  ]
}
