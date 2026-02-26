---
name: perl-bio-asn1-entrezgene
description: This tool parses NCBI Entrez Gene ASN.1 records into Perl data structures using a high-performance regular expression-based approach. Use when user asks to parse Entrez Gene data, extract gene symbols or genomic locations from ASN.1 files, or convert Entrez Gene records into other formats.
homepage: http://search.cpan.org/dist/Bio-ASN1-EntrezGene
---


# perl-bio-asn1-entrezgene

## Overview
This skill provides guidance on using the `Bio::ASN1::EntrezGene` parser to process NCBI Entrez Gene data. While NCBI provides data in ASN.1 format, this specific tool uses a high-performance regular expression-based approach to parse these records into Perl data structures. It is particularly useful for bioinformatics pipelines that need to convert Entrez Gene records into other formats or extract specific fields like gene symbols, descriptions, and genomic locations without the overhead of a full ASN.1 compiler.

## Usage Patterns

### Basic Parsing Script
To use the parser within a Perl script, initialize the `Bio::ASN1::EntrezGene` object and provide a filehandle to the Entrez Gene data.

```perl
use Bio::ASN1::EntrezGene;

my $parser = Bio::ASN1::EntrezGene->new();
open(my $fh, "<", "gene_result.asn") or die "Cannot open file: $!";

# Iterate through records
while (my $result = $parser->next_record($fh)) {
    # $result is a hash reference containing the parsed data
    print "Gene ID: " . $result->{'geneid'} . "\n";
    print "Symbol: " . $result->{'gene'}{'locus'} . "\n";
}
close($fh);
```

### Handling Data Structures
The parser returns a nested hash/array structure. Common keys to access include:
- `geneid`: The unique NCBI Entrez Gene identifier.
- `gene`: Contains `locus` (symbol) and `desc` (description).
- `prot`: Protein product information.
- `rna`: Transcript information.
- `summary`: The descriptive summary text for the gene.
- `location`: Genomic coordinates and assembly information.

### Performance Optimization
- **Streaming**: Always use `next_record` to process files one record at a time. Entrez Gene files (like `All_Data.gene.info.gz` or full ASN dumps) are extremely large and should not be loaded entirely into memory.
- **Regex Speed**: This module is significantly faster than generic ASN.1 parsers because it targets the specific structure of Entrez Gene records using optimized regular expressions.

## Installation
The tool is available via Bioconda for easy environment management:
```bash
conda install -c bioconda perl-bio-asn1-entrezgene
```

## Reference documentation
- [Bio-ASN1-EntrezGene MetaCPAN](./references/metacpan_org_release_Bio-ASN1-EntrezGene.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-bio-asn1-entrezgene_overview.md)