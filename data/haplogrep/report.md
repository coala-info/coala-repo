# haplogrep CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| haplogrep_classify | PASS | --write-fasta-msa crashes with a Java exception and leaves an empty file; classify works on vcf, fasta and hsd input |
| haplogrep_distance | PASS | synthetic data: a small planted list of real haplogroup pairs; the distances are plausible |

## haplogrep_classify

### Tool Description
mtDNA haplogroup classification of VCF, FASTA or HSD input.

### Metadata
- **Docker Image**: quay.io/biocontainers/haplogrep:2.4.0--hdfd78af_0
- **Homepage**: https://github.com/seppinho/haplogrep-cmd
- **Package**: https://anaconda.org/channels/bioconda/packages/haplogrep/overview
- **Validation**: PASS

### Original Help Text
```text
mtDNA Haplogroup Classifiction v2.4.0
https://github.com/seppinho/haplogrep-cmd
(c) Sebastian Schönherr, Hansi Weissensteiner, Lukas Forer, Dominic Pacher
sebastian.schoenherr@i-med.ac.at

[classify]
Missing required options: '--input=<in>', '--output=<out>', '--format=<format>'
Usage: haplogrep classify [--chip] [--extend-report] [--rsrs]
                          [--skip-alignment-rules] [--write-fasta]
                          [--write-fasta-msa] --format=<format>
                          [--hetLevel=<hetLevel>] [--hits=<hits>] --in=<in>
                          [--lineage=<lineage>] [--metric=<metric>] --out=<out>
                          [--phylotree=<tree>]
      --chip                VCF data from a genotype chip
                              Default: false
      --extend-report       Add flag for a extended final output
                              Default: false
      --format=<format>     Specify input file format: vcf, fasta or hsd
      --hetLevel=<hetLevel> Add heteroplasmies with a level > X from the VCF
                              file to the profile (default: 0.9)
      --hits=<hits>         Calculate best n hits
      --in, --input=<in>    Input VCF, fasta or hsd file
      --lineage=<lineage>   Export lineage information as dot file, \n0=no
                              tree, 1=with SNPs, 2=only structure, no SNPs
      --metric=<metric>     Specifiy other metrics (hamming or jaccard) than
                              default (kulczynski)
      --out, --output=<out> Output file location
      --phylotree=<tree>    Specify phylotree version
      --rsrs                Use RSRS Version
                              Default: false
      --skip-alignment-rules
                            Skip mtDNA nomenclature fixes based on rules for
                              FASTA import
                              Default: false
      --write-fasta         Write results in fasta format
                              Default: false
      --write-fasta-msa     Write multiple sequence alignment (_MSA.fasta)
                              Default: false
```

## haplogrep_distance

### Tool Description
Calculate the distance between mtDNA haplogroups.

### Metadata
- **Docker Image**: quay.io/biocontainers/haplogrep:2.4.0--hdfd78af_0
- **Homepage**: https://github.com/seppinho/haplogrep-cmd
- **Package**: https://anaconda.org/channels/bioconda/packages/haplogrep/overview
- **Validation**: PASS

### Original Help Text
```text
mtDNA Haplogroup Classifiction v2.4.0
https://github.com/seppinho/haplogrep-cmd
(c) Sebastian Schönherr, Hansi Weissensteiner, Lukas Forer, Dominic Pacher
sebastian.schoenherr@i-med.ac.at

[distance]
Missing required options: '--input=<in>', '--output=<out>'
Usage: haplogrep distance --in=<in> --out=<out>
      --in, --input=<in>   input haplogroups
      --out, --output=<out>
                           output haplogroups including distance
```

