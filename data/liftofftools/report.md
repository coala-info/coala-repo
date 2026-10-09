# liftofftools CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| liftofftools_all | PASS | same synthetic yeast pair; clusters, variants and synteny results all written |
| liftofftools_clusters | PASS | same synthetic yeast pair; all genes fall in 1:1 clusters; dangling mmseqs links removed so the output folder collects |
| liftofftools_synteny | PASS | same synthetic yeast pair; gene order table with edit distance 0 and a PDF plot |
| liftofftools_variants | PASS | synthetic data: yeast chrI 100 kb lifted by Liftoff to a copy with a 2 kb deletion; GPB2 reported as inframe_deletion (0.28), 44 genes identical |

## liftofftools_clusters

### Tool Description
Compare gene clusters between the reference and target annotations (uses mmseqs).

### Metadata
- **Docker Image**: quay.io/biocontainers/liftofftools:0.4.4--pyhdfd78af_0
- **Homepage**: https://github.com/agshumate/LiftoffTools
- **Package**: https://anaconda.org/channels/bioconda/packages/liftofftools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: liftofftools [-h] -r R -t T -rg GFF/GTF or DB -tg GFF/GTF or DB [-c]
                    [-f F] [-infer-genes] [-dir DIR] [-force]
                    [-mmseqs_path MMSEQS_PATH] [-mmseqs_params =STR]
                    [-edit-distance] [-r-sort R_SORT] [-t-sort T_SORT] [-V]
                    {clusters,variants,synteny,all}

Compare gene annotations across genome assemblies

Subcommands:
  {clusters,variants,synteny,all}

options:
  -h, --help            show this help message and exit
  -r R                  reference fasta
  -t T                  target fasta
  -rg GFF/GTF or DB     reference annotation file to lift over in GFF or GTF
                        format or gffutils database created in previous
                        liftoff or liftofftools run
  -tg GFF/GTF or DB     target annotation file to lift over in GFF or GTF
                        format or gffutils databased created in previous
                        liftoff or liftofftools run
  -c                    analyze protein coding gene clusters only
  -f F                  text file with additional feature types besides genes
                        to analyze
  -infer-genes
  -dir DIR              output directory
  -force                force overwrite of output/intermediate files in -dir
  -V, --version         show program version

clusters arguments:
  -mmseqs_path MMSEQS_PATH
                        mmseqs path if not in working directory or PATH
  -mmseqs_params =STR   space delimited list of additional mmseqs parameters.
                        Default="--min-seq-id 0.9 -c 0.9"

synteny arguments:
  -edit-distance        calculate edit distance between reference gene order
                        and target gene order
  -r-sort R_SORT        txt file with the order of the reference chromosomes
                        to be plotted on the x-axis
  -t-sort T_SORT        txt file with the order of the target chromosomes to
                        be plotted on the y-axis
```

## liftofftools_variants

### Tool Description
Find variants in the lifted genes between the reference and target annotations.

### Metadata
- **Docker Image**: quay.io/biocontainers/liftofftools:0.4.4--pyhdfd78af_0
- **Homepage**: https://github.com/agshumate/LiftoffTools
- **Package**: https://anaconda.org/channels/bioconda/packages/liftofftools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: liftofftools [-h] -r R -t T -rg GFF/GTF or DB -tg GFF/GTF or DB [-c]
                    [-f F] [-infer-genes] [-dir DIR] [-force]
                    [-mmseqs_path MMSEQS_PATH] [-mmseqs_params =STR]
                    [-edit-distance] [-r-sort R_SORT] [-t-sort T_SORT] [-V]
                    {clusters,variants,synteny,all}

Compare gene annotations across genome assemblies

Subcommands:
  {clusters,variants,synteny,all}

options:
  -h, --help            show this help message and exit
  -r R                  reference fasta
  -t T                  target fasta
  -rg GFF/GTF or DB     reference annotation file to lift over in GFF or GTF
                        format or gffutils database created in previous
                        liftoff or liftofftools run
  -tg GFF/GTF or DB     target annotation file to lift over in GFF or GTF
                        format or gffutils databased created in previous
                        liftoff or liftofftools run
  -c                    analyze protein coding gene clusters only
  -f F                  text file with additional feature types besides genes
                        to analyze
  -infer-genes
  -dir DIR              output directory
  -force                force overwrite of output/intermediate files in -dir
  -V, --version         show program version

clusters arguments:
  -mmseqs_path MMSEQS_PATH
                        mmseqs path if not in working directory or PATH
  -mmseqs_params =STR   space delimited list of additional mmseqs parameters.
                        Default="--min-seq-id 0.9 -c 0.9"

synteny arguments:
  -edit-distance        calculate edit distance between reference gene order
                        and target gene order
  -r-sort R_SORT        txt file with the order of the reference chromosomes
                        to be plotted on the x-axis
  -t-sort T_SORT        txt file with the order of the target chromosomes to
                        be plotted on the y-axis
```

## liftofftools_synteny

### Tool Description
Compare the gene order (synteny) between the reference and target annotations.

### Metadata
- **Docker Image**: quay.io/biocontainers/liftofftools:0.4.4--pyhdfd78af_0
- **Homepage**: https://github.com/agshumate/LiftoffTools
- **Package**: https://anaconda.org/channels/bioconda/packages/liftofftools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: liftofftools [-h] -r R -t T -rg GFF/GTF or DB -tg GFF/GTF or DB [-c]
                    [-f F] [-infer-genes] [-dir DIR] [-force]
                    [-mmseqs_path MMSEQS_PATH] [-mmseqs_params =STR]
                    [-edit-distance] [-r-sort R_SORT] [-t-sort T_SORT] [-V]
                    {clusters,variants,synteny,all}

Compare gene annotations across genome assemblies

Subcommands:
  {clusters,variants,synteny,all}

options:
  -h, --help            show this help message and exit
  -r R                  reference fasta
  -t T                  target fasta
  -rg GFF/GTF or DB     reference annotation file to lift over in GFF or GTF
                        format or gffutils database created in previous
                        liftoff or liftofftools run
  -tg GFF/GTF or DB     target annotation file to lift over in GFF or GTF
                        format or gffutils databased created in previous
                        liftoff or liftofftools run
  -c                    analyze protein coding gene clusters only
  -f F                  text file with additional feature types besides genes
                        to analyze
  -infer-genes
  -dir DIR              output directory
  -force                force overwrite of output/intermediate files in -dir
  -V, --version         show program version

clusters arguments:
  -mmseqs_path MMSEQS_PATH
                        mmseqs path if not in working directory or PATH
  -mmseqs_params =STR   space delimited list of additional mmseqs parameters.
                        Default="--min-seq-id 0.9 -c 0.9"

synteny arguments:
  -edit-distance        calculate edit distance between reference gene order
                        and target gene order
  -r-sort R_SORT        txt file with the order of the reference chromosomes
                        to be plotted on the x-axis
  -t-sort T_SORT        txt file with the order of the target chromosomes to
                        be plotted on the y-axis
```

## liftofftools_all

### Tool Description
Run the clusters, variants and synteny comparisons.

### Metadata
- **Docker Image**: quay.io/biocontainers/liftofftools:0.4.4--pyhdfd78af_0
- **Homepage**: https://github.com/agshumate/LiftoffTools
- **Package**: https://anaconda.org/channels/bioconda/packages/liftofftools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: liftofftools [-h] -r R -t T -rg GFF/GTF or DB -tg GFF/GTF or DB [-c]
                    [-f F] [-infer-genes] [-dir DIR] [-force]
                    [-mmseqs_path MMSEQS_PATH] [-mmseqs_params =STR]
                    [-edit-distance] [-r-sort R_SORT] [-t-sort T_SORT] [-V]
                    {clusters,variants,synteny,all}

Compare gene annotations across genome assemblies

Subcommands:
  {clusters,variants,synteny,all}

options:
  -h, --help            show this help message and exit
  -r R                  reference fasta
  -t T                  target fasta
  -rg GFF/GTF or DB     reference annotation file to lift over in GFF or GTF
                        format or gffutils database created in previous
                        liftoff or liftofftools run
  -tg GFF/GTF or DB     target annotation file to lift over in GFF or GTF
                        format or gffutils databased created in previous
                        liftoff or liftofftools run
  -c                    analyze protein coding gene clusters only
  -f F                  text file with additional feature types besides genes
                        to analyze
  -infer-genes
  -dir DIR              output directory
  -force                force overwrite of output/intermediate files in -dir
  -V, --version         show program version

clusters arguments:
  -mmseqs_path MMSEQS_PATH
                        mmseqs path if not in working directory or PATH
  -mmseqs_params =STR   space delimited list of additional mmseqs parameters.
                        Default="--min-seq-id 0.9 -c 0.9"

synteny arguments:
  -edit-distance        calculate edit distance between reference gene order
                        and target gene order
  -r-sort R_SORT        txt file with the order of the reference chromosomes
                        to be plotted on the x-axis
  -t-sort T_SORT        txt file with the order of the target chromosomes to
                        be plotted on the y-axis
```

## Metadata
- **Skill**: generated
