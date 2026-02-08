# Rdkit
<!--
SPDX-FileCopyrightText: Copyright © contributors to CloudNativePG, established as CloudNativePG a Series of LF Projects, LLC.
SPDX-License-Identifier: Apache-2.0
-->

The rdkit extension provides Cheminformatics functionality for PostgreSQL. For more information,
see the [official documentation](https://www.rdkit.org/docs/Cartridge.html).

## Usage

<!--
Usage: add instructions on how to use the extension with CloudNativePG.
Include code snippets for Cluster and Database resources as needed.
-->

### 1. Add the rdkit extension image to your Cluster

Define the `rdkit` extension under the `postgresql.extensions` section of
your `Cluster` resource. For example:

```yaml
apiVersion: postgresql.cnpg.io/v1
kind: Cluster
metadata:
  name: cluster-rdkit
spec:
  imageName: ghcr.io/cloudnative-pg/postgresql:18-minimal-trixie
  instances: 1

  storage:
    size: 1Gi

  postgresql:
    extensions:
    - name: rdkit
      image:
        # renovate: suite=trixie-pgdg depName=postgresql-18-rdkit
        reference: ghcr.io/cloudnative-pg/rdkit:202503.1-18-trixie
```

### 2. Enable the extension in a database

You can install `rdkit` in a specific database by creating or updating a
`Database` resource. For example, to enable it in the `app` database:

```yaml
apiVersion: postgresql.cnpg.io/v1
kind: Database
metadata:
  name: cluster-rdkit-app
spec:
  name: app
  owner: app
  cluster:
    name: cluster-rdkit
  extensions:
  - name: rdkit
```

### 3. Verify installation

Once the database is ready, connect to it with `psql` and run:

```sql
\dx
```

You should see `rdkit` listed among the installed extensions.

## Contributors

This extension is maintained by:

- Ronny Moreas (@rmoreas)

The maintainers are responsible for:

- Monitoring upstream releases and security vulnerabilities.
- Ensuring compatibility with supported PostgreSQL versions.
- Reviewing and merging contributions specific to this extension's container
  image and lifecycle.

---

## Licenses and Copyright

This container image contains software that may be licensed under various
open-source licenses.

All relevant license and copyright information for the `rdkit` extension
and its dependencies are bundled within the image at:

```text
/licenses/
```

By using this image, you agree to comply with the terms of the licenses
contained therein.
