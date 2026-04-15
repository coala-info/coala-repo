---
name: perl-bio-phylo
description: Bio::Phylo is a Perl framework for representing and analyzing phylogenetic data, including trees, taxa, and character matrices. Use when user asks to represent phylogenetic relationships, configure global logging for bioinformatic pipelines, or assign unique identifiers to biological data objects.
homepage: https://metacpan.org/pod/Bio::Phylo
metadata:
  docker_image: "quay.io/biocontainers/perl-bio-phylo:2.0.2--pl5321hdfd78af_0"
---

# perl-bio-phylo

## Overview
Bio::Phylo is a robust, object-oriented Perl framework designed for the representation and analysis of phylogenetic data. It provides a structured way to handle complex relationships between trees, taxa, and character matrices. This skill focuses on the core architectural patterns of the library, such as its unique constructor logic and global configuration systems, which are essential for building stable bioinformatic pipelines.

## Core Usage Patterns

### Constructor Argument Mapping
Bio::Phylo uses a standardized convention for object instantiation. Any method starting with `set_` can be called via the constructor by using a dash `-` prefix.
- **Pattern**: `Bio::Phylo::Subclass->new( -parameter => $value )`
- **Example**: To set a name (which uses `set_name` internally), use:
  ```perl
  my $obj = Bio::Phylo::Forest::Tree->new( -name => 'MyTree' );
  ```

### Global Logging and Verbosity
To debug complex parsing issues or silence warnings during large-scale processing, use the global `VERBOSE` method. This can be applied globally or restricted to specific classes.
- **Global Error Only**:
  ```perl
  Bio::Phylo->VERBOSE( -level => Bio::Phylo::Util::Logger::ERROR );
  ```
- **Class-Specific Debugging**:
  ```perl
  Bio::Phylo->VERBOSE( 
      -level => Bio::Phylo::Util::Logger::DEBUG, 
      -class => 'Bio::Phylo::Forest' 
  );
  ```

### Object Identification (GUIDs)
When integrating Bio::Phylo into databases or larger workflows, use the `set_guid` method to assign unambiguous identifiers (like LSIDs or GenBank accessions) to any object inheriting from the base class.
```perl
$obj->set_guid('urn:lsid:ncbi.nlm.nih.gov:genbank:12345');
```

## Best Practices
- **Avoid Direct Base Class Usage**: `Bio::Phylo` is a base class. Always instantiate specific subclasses (e.g., `Bio::Phylo::Forest::Tree`, `Bio::Phylo::Matrices::Matrix`) for functional tasks.
- **Exception Handling**: Use `Bio::Phylo::Util::Exceptions` to catch toolkit-specific errors rather than relying on standard Perl `die` statements for better error granularity in pipelines.
- **Memory Management**: When processing very large trees or matrices, ensure you are aware of the object-oriented overhead; explicitly undefine large objects when they are no longer needed in long-running scripts.

## Reference documentation
- [Bio::Phylo - Phylogenetic analysis using perl](./references/metacpan_org_pod_Bio__Phylo.md)
- [Bio::Phylo::Util::Logger](./references/metacpan_org_pod_Bio__Phylo__Util__Logger.md)
- [Bio::Phylo::Util::Exceptions](./references/metacpan_org_pod_Bio__Phylo__Util__Exceptions.md)