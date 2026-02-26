# cthreepo CWL Generation Report

## cthreepo

### Tool Description
This script parses input file and converts the seq-id name from one kind to the other

### Metadata
- **Docker Image**: quay.io/biocontainers/cthreepo:0.1.3--pyh7cba7a3_0
- **Homepage**: https://github.com/vkkodali/cthreepo
- **Package**: https://anaconda.org/channels/bioconda/packages/cthreepo/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cthreepo/overview
- **Total Downloads**: 10.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/vkkodali/cthreepo
- **Stars**: N/A
### Original Help Text
```text
usage: cthreepo [-h] [-i INFILE] [-o OUTFILE] (-m MAPFILE | -a ACCN)
                [-if {any,uc,rs,gb,ens}] [-it {uc,rs,gb,ens}] [-ku] [-p]
                [-f {gff3,gtf,bedgraph,bed,sam,vcf,wig,tsv}] [-c COLUMN]

This script parses input file and converts the seq-id name from one kind to
the other

options:
  -h, --help            show this help message and exit
  -i INFILE, --infile INFILE
                        input file
  -o OUTFILE, --outfile OUTFILE
                        output file
  -m MAPFILE, --mapfile MAPFILE
                        NCBI style assembly_report file for mapping
  -a ACCN, --accn ACCN  NCBI Assembly Accession with version
  -if {any,uc,rs,gb,ens}, --id_from {any,uc,rs,gb,ens}
                        seq-id format in the input file; can be `any`, `ens`,
                        `uc`, `gb`, or `rs`; default is `any`
  -it {uc,rs,gb,ens}, --id_to {uc,rs,gb,ens}
                        seq-id format in the output file; can be `ens`, `uc`,
                        `gb`, or `rs`; default is `rs`
  -ku, --keep_unmapped  keep lines that don't have seq-id matches
  -p, --primary         restrict to primary assembly only
  -f {gff3,gtf,bedgraph,bed,sam,vcf,wig,tsv}, --format {gff3,gtf,bedgraph,bed,sam,vcf,wig,tsv}
                        input file format; can be `gff3`, `gtf`, `bedgraph`,
                        `bed`, `sam`, `vcf`, `wig` or `tsv`; default is `gff3`
  -c COLUMN, --column COLUMN
                        column where the seq-id is located; required for `tsv`
                        format
```

