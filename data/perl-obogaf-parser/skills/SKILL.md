---
name: perl-obogaf-parser
description: This tool parses OBO ontology files and GAF annotation files to enable object-oriented traversal of ontology graphs and gene mapping in Perl. Use when user asks to parse OBO or GAF files, navigate ontology hierarchies, retrieve term metadata, or extract gene-term associations.
homepage: http://metacpan.org/pod/obogaf::parser
metadata:
  docker_image: "quay.io/biocontainers/perl-obogaf-parser:1.373--pl5321hdfd78af_2"
---

# perl-obogaf-parser

## Overview
The `perl-obogaf-parser` skill provides a programmatic interface for handling complex hierarchical ontology data and its associated gene annotations. While many tools treat OBO and GAF files as simple flat files, this module allows for object-oriented traversal of the ontology graph (parents, children, ancestors) and direct mapping of annotations to specific terms. It is the preferred tool when you need to perform custom filtering, enrichment preparation, or structural analysis of ontologies within a Perl environment.

## Usage Instructions

### Basic Script Template
To use the parser, you must initialize the `obogaf::parser` object and load the OBO file before processing the GAF file.

```perl
use obogaf::parser;

# Initialize the parser
my $parser = obogaf::parser->new();

# 1. Load the Ontology (OBO)
$parser->parse_obo("path/to/ontology.obo");

# 2. Load the Annotations (GAF)
$parser->parse_gaf("path/to/annotations.gaf");
```

### Common Data Extraction Patterns

**Retrieve Term Metadata:**
Access details about a specific ID (e.g., GO:0008150).
```perl
my $term = $parser->get_term("GO:0008150");
print $term->name();
print $term->namespace();
```

**Navigate the Hierarchy:**
Find related terms to traverse the ontology graph.
```perl
my @parents = $parser->get_parents("GO:0008150");
my @children = $parser->get_children("GO:0008150");
my @ancestors = $parser->get_ancestors("GO:0008150");
```

**Access Gene Annotations:**
Retrieve genes associated with a specific term or terms associated with a gene.
```perl
# Get all gene symbols associated with a term
my @genes = $parser->get_genes_by_term("GO:0008150");

# Get all terms associated with a specific gene
my @terms = $parser->get_terms_by_gene("BRCA1");
```

### Expert Tips
- **Memory Management:** OBO files can be large. Ensure your environment has sufficient RAM when parsing full GO or HPO sets, as the module builds an in-memory graph representation.
- **File Compatibility:** Ensure your GAF files are tab-separated. While the parser is robust, it expects the standard 17-column GAF 2.x format or the HPO-specific annotation format.
- **Filtering:** Use the `get_ancestors` method to implement "propagate up" logic, where a gene associated with a child term is automatically considered associated with all parent terms.

## Reference documentation
- [perl-obogaf-parser Overview](./references/anaconda_org_channels_bioconda_packages_perl-obogaf-parser_overview.md)
- [obogaf::parser Documentation](./references/metacpan_org_pod_obogaf__parser.md)