# varcode CWL Generation Report

## varcode

### Tool Description
Annotate variants with overlapping gene names and predicted coding effects

### Metadata
- **Docker Image**: quay.io/biocontainers/varcode:1.2.1--pyh7e72e81_0
- **Homepage**: https://github.com/openvax/varcode
- **Package**: https://anaconda.org/channels/bioconda/packages/varcode/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/varcode/overview
- **Total Downloads**: 3.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/openvax/varcode
- **Stars**: N/A
### Original Help Text
```text
Varcode
  Version: 1.2.1
  Path: /usr/local/lib/python3.12/site-packages/varcode
usage: varcode [-h] [--vcf VCF] [--maf MAF] [--variant CHR POS REF ALT]
               [--genome GENOME] [--download-reference-genome-data]
               [--json-variants JSON_VARIANTS] [--output-csv OUTPUT_CSV]
               [--one-per-variant] [--only-coding]

Annotate variants with overlapping gene names and predicted coding effects

options:
  -h, --help            show this help message and exit
  --output-csv OUTPUT_CSV
                        Output path to CSV
  --one-per-variant     Only return highest priority effect overlapping a
                        variant, otherwise all overlapping transcripts are
                        returned.
  --only-coding         Filter silent and non-coding effects

Variants:
  Genomic variant files

  --vcf VCF             Genomic variants in VCF format
  --maf MAF             Genomic variants in TCGA's MAF format
  --variant CHR POS REF ALT
                        Individual variant as 4 arguments giving chromsome,
                        position, ref, and alt. Example: chr1 3848 C G. Use
                        '.' to indicate empty alleles for insertions or
                        deletions.
  --genome GENOME       What reference assembly your variant coordinates are
                        using. Examples: 'hg19', 'GRCh38', or 'mm9'. This
                        argument is ignored for MAF files, since each row
                        includes the reference. For VCF files, this is used if
                        specified, and otherwise is guessed from the header.
                        For variants specfied on the commandline with
                        --variant, this option is required.
  --download-reference-genome-data
                        Automatically download genome reference data required
                        for annotation using PyEnsembl. Otherwise you must
                        first run 'pyensembl install' for the release/species
                        corresponding to the genome used in your VCF.
  --json-variants JSON_VARIANTS
                        Path to Varcode.VariantCollection object serialized as
                        a JSON file.
```

