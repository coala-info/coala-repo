# corsid CWL Generation Report

## corsid

### Tool Description
Identify and classify ORFs in a FASTA genome file.

### Metadata
- **Docker Image**: quay.io/biocontainers/corsid:0.1.3--pyh5e36f6f_0
- **Homepage**: http://github.com/elkebir-group/CORSID
- **Package**: https://anaconda.org/channels/bioconda/packages/corsid/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/corsid/overview
- **Total Downloads**: 7.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/elkebir-group/CORSID
- **Stars**: N/A
### Original Help Text
```text
usage: corsid [-h] -f FASTA [-g GFF] [-n NAME] [-o OUTPUT] [-r OUTPUT_ORF]
              [-3 OUTPUT_GFF3] [-w WINDOW] [-x MISMATCH] [-t TAU_MIN]
              [-T TAU_MAX] [--shrink SHRINK] [--no-missing-classifier]

optional arguments:
  -h, --help            show this help message and exit
  -g GFF, --gff GFF     GFF annotation file
  -n NAME, --name NAME  sample name
  -o OUTPUT, --output OUTPUT
                        output json file name
  -r OUTPUT_ORF, --output-orf OUTPUT_ORF
                        output identified ORFs (FASTA), only contains the
                        first solution
  -3 OUTPUT_GFF3, --output-gff3 OUTPUT_GFF3
                        output identified ORFs (FASTA), only contains the
                        first solution
  -w WINDOW, --window WINDOW
                        length of sliding window [7]
  -x MISMATCH, --mismatch MISMATCH
                        mismatch score [-2]
  -t TAU_MIN, --tau_min TAU_MIN
                        minimum matching score threshold [2]
  -T TAU_MAX, --tau_max TAU_MAX
                        maximum matching score threshold [7]
  --shrink SHRINK       fraction of positions that may overlap between
                        consecutive genes [0.05]
  --no-missing-classifier
                        set flag to disable missing TRS-L classifier

required arguments:
  -f FASTA, --fasta FASTA
                        FASTA genome file
```

