# vcf2tsvpy CWL Generation Report

## vcf2tsvpy

### Tool Description
Convert a VCF (Variant Call Format) file with genomic variants to a file with tab-separated values (TSV). One entry (TSV line) per sample genotype.

### Metadata
- **Docker Image**: quay.io/biocontainers/vcf2tsvpy:0.6.1--pyhda70652_0
- **Homepage**: https://github.com/sigven/vcf2tsvpy
- **Package**: https://anaconda.org/channels/bioconda/packages/vcf2tsvpy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/vcf2tsvpy/overview
- **Total Downloads**: 5.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sigven/vcf2tsvpy
- **Stars**: N/A
### Original Help Text
```text
usage: 
	vcf2tsvpy 
	--input_vcf <INPUT_VCF>
	--out_tsv <OUTPUT_TSV>
	-h [options] 

vcf2tsvpy: Convert a VCF (Variant Call Format) file with genomic variants to a file with tab-separated values (TSV). One entry (TSV line) per sample genotype.

Required arguments:
  --input_vcf INPUT_VCF
                        Bgzipped input VCF file with input variants (SNVs/InDels)
  --out_tsv OUT_TSV     Output TSV file with one line per non-rejected sample genotype (variant, genotype and annotation data as tab-separated values)

Optional arguments:
  --skip_info_data      Skip output of data in INFO column
  --skip_genotype_data  Skip output of genotype_data (FORMAT columns)
  --keep_rejected_calls
                        Output data also for rejected (non-PASS) calls
  --print_data_type_header
                        Output a header line with data types of VCF annotations
  --compress            Compress output TSV file with gzip
  --version             show program's version number and exit
```

