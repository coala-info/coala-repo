---
name: libcifpp
description: libcifpp is a C++ library that treats mmCIF and PDB files as relational databases for reading, writing, and validating macromolecular structures. Use when user asks to parse structural biology files, perform relational queries on CIF data, validate files against dictionaries, or handle 3D coordinate transformations.
homepage: https://github.com/PDB-REDO/libcifpp
metadata:
  docker_image: "quay.io/biocontainers/libcifpp:9.0.6--hddb1751_1"
---

# libcifpp

## Overview

libcifpp is a specialized C++17 library designed to treat mmCIF files as relational databases. It provides a high-level API to read, write, and validate macromolecular structures against CIF dictionaries. Unlike simple parsers, libcifpp ensures that data is syntactically correct and semantically valid according to specified schemas. It also includes a transparent abstraction layer for PDB files, allowing them to be processed using the same logic as mmCIF files, and supports advanced features like 3D coordinate transformations and Chemical Component Dictionary (CCD) integration.

## C++ Integration Patterns

### Basic File I/O
The library handles PDB, mmCIF, and Gzip-compressed versions of both automatically.

```cpp
#include <cif++.hpp>

// Read a file (detects format automatically)
cif::file f = cif::pdb::read("protein.pdb.gz");

if (f.empty()) {
    throw std::runtime_error("Failed to load file");
}

// Access the first datablock
auto &db = f.front();
```

### Relational Queries
Categories are treated like tables. Use `cif::key` to build filters.

```cpp
auto &atom_site = db["atom_site"];

// Count specific atoms
auto count = atom_site.count(cif::key("label_atom_id") == "CA");

// Find and extract specific columns using structured bindings
for (const auto &[asym_id, seq_id, x, y, z] : 
     atom_site.find<std::string, int, float, float, float>(
        cif::key("label_atom_id") == "CA", 
        "label_asym_id", "label_seq_id", "Cartn_x", "Cartn_y", "Cartn_z")) 
{
    // Process alpha carbon coordinates
}
```

### Dictionary Validation
To ensure data integrity, libcifpp can validate content against a CIF dictionary (e.g., mmcif_pdbx).

- **Automatic Cascades**: If a dictionary is loaded, removing a parent record (like an entity) can trigger a cascaded removal of child records (like atoms) to maintain referential integrity.
- **Type Checking**: Inserted data is automatically checked against the data types defined in the dictionary.

## Expert Tips and Best Practices

- **Memory Efficiency**: When working with large structures, prefer `find<...>` with specific columns rather than iterating over entire rows to minimize memory overhead.
- **PDB Compatibility**: Use `cif::pdb::read()` even for mmCIF files if you want the library to provide the unified interface that treats both formats identically.
- **Symmetry Operations**: Leverage the built-in symmetry calculation features for generating symmetry-related atoms or calculating crystal packing, rather than implementing rotation matrices manually.
- **CCD Integration**: If your workflow involves ligand analysis, ensure the Chemical Component Dictionary (CCD) is available to libcifpp to allow for proper bond and atom validation in non-polymer entities.
- **Data Updates**: On Linux/FreeBSD systems, use the provided update script (if installed) to keep the local `mmcif_pdbx` and `CCD` dictionaries current, as these are updated weekly by the PDB.

## Installation via Conda

For quick environment setup without manual compilation:
```bash
conda install bioconda::libcifpp
```

## Reference documentation
- [libcifpp GitHub Repository](./references/github_com_PDB-REDO_libcifpp.md)
- [libcifpp Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_libcifpp_overview.md)