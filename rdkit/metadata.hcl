# SPDX-FileCopyrightText: Copyright © contributors to CloudNativePG, established as CloudNativePG a Series of LF Projects, LLC.
# SPDX-License-Identifier: Apache-2.0

variable "distributions" {
  default = [
    "trixie"
  ]
}

metadata = {
  name                     = "rdkit"
  sql_name                 = "rdkit"
  image_name               = "rdkit"
  shared_preload_libraries = []
  extension_control_path   = []
  dynamic_library_path     = []
  ld_library_path          = ["/system"]
  auto_update_os_libs      = false
  required_extensions      = []

  versions = {
    trixie = {
        // renovate: suite=trixie-pgdg depName=postgresql-18-rdkit
        "18" = "202503.1-5.pgdg13+1"
    }
  }
}
