---
name: perl-ole-storage_lite
description: This Perl module provides an interface for reading and creating OLE storage structures and containers. Use when user asks to extract data from OLE files, create new OLE storage structures, or perform low-level forensic analysis on Office documents.
homepage: http://metacpan.org/pod/OLE-Storage_Lite
metadata:
  docker_image: "quay.io/biocontainers/perl:5.32"
---

# perl-ole-storage_lite

## Overview
This skill provides the procedural knowledge required to interface with the `OLE::Storage_Lite` Perl module. It enables the extraction of data from OLE containers and the creation of new OLE storage structures. It is particularly useful for low-level document forensic analysis, data recovery from corrupted Office files, or generating Excel-compatible files when used in conjunction with modules like `Excel::Writer::XLSX`.

## Core Usage Patterns

### Reading an OLE File
To inspect or extract data from an existing OLE file, use the `OLE::Storage_Lite` object to get the directory tree.

```perl
use OLE::Storage_Lite;

# Initialize and read the file
my $ole = OLE::Storage_Lite->new("example.xls");
my $root = $ole->getPpsTree();

# Traverse the PPS (Property Storage) tree
# $root is an OLE::Storage_Lite::PPS object
print "Root Name: " . $root->{Name} . "\n";
```

### Creating an OLE File
Creating a file involves defining a hierarchy of PPS objects (Files/Data as 'Leaf' and Directories as 'Dir').

```perl
use OLE::Storage_Lite;

# 1. Create a Leaf (Data)
my $data = "Hello World";
my $pps_leaf = OLE::Storage_Lite::PPS::Leaf->new(
    OLE::Storage_Lite::Asc2Ucs("DataStream"), # Name in Unicode
    $data                                     # Content
);

# 2. Create a Root directory containing the leaf
my $pps_root = OLE::Storage_Lite::PPS::Root->new(
    OLE::Storage_Lite::Asc2Ucs("Root Entry"),
    undef,          # Time (optional)
    undef,          # Time (optional)
    [$pps_leaf]     # Children
);

# 3. Save to file
$pps_root->save("output.ole");
```

## Expert Tips
- **Unicode Names**: OLE storage requires names in UTF-16 (Little Endian). Always use `OLE::Storage_Lite::Asc2Ucs()` for literal string names to ensure compatibility.
- **Memory Management**: For very large OLE files, be aware that `getPpsTree()` loads the structure into memory. If processing massive streams, consider using the `save()` method's ability to handle file handles rather than scalar strings.
- **Date Handling**: OLE timestamps are 64-bit values representing the number of 100-nanosecond intervals since January 1, 1601. Use the `LocalDate2OLE()` utility function if you need to set specific creation/modification times.

## Reference documentation
- [OLE::Storage_Lite Documentation](./references/metacpan_org_pod_OLE-Storage_Lite.md)