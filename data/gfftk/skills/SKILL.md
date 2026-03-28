---
name: gfftk
description: gfftk is a specialized suite for normalizing, converting, and filtering genomic annotation files. Use when user asks to convert GFF3 files to other formats, extract FASTA sequences from annotations, filter gene models, or generate consensus gene predictions.
homepage: https://github.com/nextgenusfs/gfftk
---


# gfftk

## Overview
The `gfftk` (GFF toolkit) is a specialized suite designed for bioinformaticians to handle the complexities of genomic annotation files. It excels at normalizing GFF3 data, performing format conversions, and extracting biological sequences based on coordinate data. It is particularly useful for preparing annotations for NCBI submission (via TBL format) or merging disparate gene models into a single consensus set.

## Common CLI Patterns

### Format Conversion
Convert between common genomic formats while maintaining structural integrity:
- **GFF3 to GTF**: `gfftk convert --input genes.gff3 --format gtf --output genes.gtf`
- **GFF3 to BED**: `gfftk convert --input genes.gff3 --format bed --output genes.bed`
- **GFF3 to TBL (NCBI)**: `gfftk convert --input genes.gff3 --format tbl --output genes.tbl`

### Sequence Extraction
Extract FASTA sequences using a GFF3 file and the corresponding reference genome:
- **Proteins**: `gfftk convert --input genes.gff3 --fasta genome.fasta --format proteins --output proteins.fasta`
- **Transcripts**: `gfftk convert --input genes.gff3 --fasta genome.fasta --format transcripts --output transcripts.fasta`
- **CDS**: `gfftk convert --input genes.gff3 --fasta genome.fasta --format cds --output cds.fasta`

### Filtering Annotations
Use the filtering engine to subset GFF3 files based on specific attributes:
- **By Product**: `gfftk filter --input genes.gff3 --filter "product=kinase" --output kinases.gff3`
- **By Source**: `gfftk filter --input genes.gff3 --filter "source=Augustus" --output augustus_only.gff3`
- **Regex Matching**: `gfftk filter --input genes.gff3 --filter "ID=~^gene_001" --output subset.gff3`

### Consensus Gene Models
Merge multiple GFF3 files into a single consensus set, often used when combining different ab-initio predictors:
- `gfftk consensus --input model1.gff3 model2.gff3 --weights 1 2 --output consensus.gff3`

## Expert Tips & Best Practices
- **Validation**: Always run `gfftk` on raw GFF3 files before downstream analysis to ensure the parent-child relationships (Gene -> mRNA -> Exon/CDS) are correctly formatted.
- **Combined Files**: `gfftk` can handle "combined" files where the FASTA sequence is appended to the end of the GFF3 file after the `##FASTA` directive. Use `gfftk.gff.is_combined_gff_fasta()` in the Python API to check for this.
- **NCBI Submission**: When converting to TBL for NCBI, ensure your GFF3 has valid `product` and `locus_tag` attributes, as these are required for a successful conversion.
- **Memory Efficiency**: For very large genomes, use the CLI tools rather than loading the entire GFF into a Python dictionary unless necessary, as the internal dictionary structure can be memory-intensive.



## Subcommands

| Command | Description |
|---------|-------------|
| gfftk_compare | compare two GFF3 annotations of a genome. |
| gfftk_consensus | EvidenceModeler-like tool to generate consensus gene predictions. All gene models are loaded and sorted into loci based on genomic location, in each locus the gene models are scored based on: 1) overlap with protein/transcript evidence 2) AED score in relation to all models at that locus 3) user supplied source weights 4) de novo source weights estimated from evidence overlaps 5) for each locus the gene model with highest score is retained. |
| gfftk_convert | convert GFF3/tbl format into another format [output gff3, gtf, tbl, gbff, fasta, combined] |
| gfftk_rename | rename gene models in GFF3 annotation file. Script will sort genes by contig and location and then rename using --locus-tag, ie PREFIX_000001. |
| gfftk_sanitize | sanitize GFF3 file, load GFF3 and output cleaned up GFF3 output. |
| gfftk_stats | parse annotation GFF3/tbl and output summary statistics. |

## Reference documentation
- [GFFtk Usage Guide](./references/gfftk_readthedocs_io_en_latest_usage.html.md)
- [GFFtk Tutorial](./references/gfftk_readthedocs_io_en_latest_tutorial.html.md)
- [Filtering Annotations](./references/gfftk_readthedocs_io_en_latest_filtering.html.md)
- [API Reference - Convert](./references/gfftk_readthedocs_io_en_latest_API_convert.html.md)