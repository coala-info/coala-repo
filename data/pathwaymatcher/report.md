# pathwaymatcher CWL Generation Report

## pathwaymatcher_match-proteoforms

### Tool Description
Match a list of proteoforms to reactions and pathways

### Metadata
- **Docker Image**: quay.io/biocontainers/pathwaymatcher:1.9.1--1
- **Homepage**: https://github.com/LuisFranciscoHS/PathwayMatcher
- **Package**: https://anaconda.org/channels/bioconda/packages/pathwaymatcher/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pathwaymatcher/overview
- **Total Downloads**: 16.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/LuisFranciscoHS/PathwayMatcher
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
Missing required option '--input=<input_path>'
Usage: java -jar PathwayMatcher.jar match-proteoforms [-gT] [-gg] [-gp] [-gu]
                                                      [--mapping=<mapping_path>]
                                                       -i=<input_path>
                                                      [-m=<matchType>]
                                                      [-o=<output_prefix>]
                                                      [-r=<range>]
Match a list of proteoforms to reactions and pathways
      --mapping=<mapping_path>
                             Path to directory with the static mapping files. By
                               default uses the mapping files integrated in the jar
                               file.
  -g, --graph                Create default connection graph according to input type.
      -gg, --graphGene       Create gene connection graph
      -gp, --graphProteoform Create proteoform connection graph
      -gu, --graphUniprot    Create protein connection graph
  -i, --input=<input_path>   Input file with path
  -m, --matchType=<matchType>
                             Proteoform match criteria.
                             Valid values: STRICT, SUPERSET, SUPERSET_NO_TYPES,
                               SUBSET, SUBSET_NO_TYPES, ONE, ONE_NO_TYPES.
                             Default: SUBSET
  -o, --output=<output_prefix>
                             Path and prefix for the output files: search.tsv (list
                               of reactions and pathways containing the input),
                               analysis.tsv (over-representation analysis) and
                               networks files.
  -r, --range=<range>        Integer range of error for PTM sites.
                             Default: 0
  -T, --topLevelPathways     Show Top Level Pathways in the search result.
```


## pathwaymatcher_match-genes

### Tool Description
Match a list of gene names and perform over-representation analysis

### Metadata
- **Docker Image**: quay.io/biocontainers/pathwaymatcher:1.9.1--1
- **Homepage**: https://github.com/LuisFranciscoHS/PathwayMatcher
- **Package**: https://anaconda.org/channels/bioconda/packages/pathwaymatcher/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
Missing required option '--input=<input_path>'
Usage: java -jar PathwayMatcher.jar match-genes [-gT] [-gg] [-gp] [-gu]
                                                [--mapping=<mapping_path>]
                                                -i=<input_path>
                                                [-o=<output_prefix>]
Match a list of gene names
      --mapping=<mapping_path>
                             Path to directory with the static mapping files. By
                               default uses the mapping files integrated in the jar
                               file.
  -g, --graph                Create default connection graph according to input type.
      -gg, --graphGene       Create gene connection graph
      -gp, --graphProteoform Create proteoform connection graph
      -gu, --graphUniprot    Create protein connection graph
  -i, --input=<input_path>   Input file with path
  -o, --output=<output_prefix>
                             Path and prefix for the output files: search.tsv (list
                               of reactions and pathways containing the input),
                               analysis.tsv (over-representation analysis) and
                               networks files.
  -T, --topLevelPathways     Show Top Level Pathways in the search result.
```


## pathwaymatcher_match-uniprot

### Tool Description
Match a list of UniProt protein accessions to reactions and pathways, and perform over-representation analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/pathwaymatcher:1.9.1--1
- **Homepage**: https://github.com/LuisFranciscoHS/PathwayMatcher
- **Package**: https://anaconda.org/channels/bioconda/packages/pathwaymatcher/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
Missing required option '--input=<input_path>'
Usage: java -jar PathwayMatcher.jar match-uniprot [-gT] [-gg] [-gp] [-gu]
                                                  [--mapping=<mapping_path>]
                                                  -i=<input_path>
                                                  [-o=<output_prefix>]
Match a list of UniProt protein accessions
      --mapping=<mapping_path>
                             Path to directory with the static mapping files. By
                               default uses the mapping files integrated in the jar
                               file.
  -g, --graph                Create default connection graph according to input type.
      -gg, --graphGene       Create gene connection graph
      -gp, --graphProteoform Create proteoform connection graph
      -gu, --graphUniprot    Create protein connection graph
  -i, --input=<input_path>   Input file with path
  -o, --output=<output_prefix>
                             Path and prefix for the output files: search.tsv (list
                               of reactions and pathways containing the input),
                               analysis.tsv (over-representation analysis) and
                               networks files.
  -T, --topLevelPathways     Show Top Level Pathways in the search result.
```


## pathwaymatcher_match-ensembl

### Tool Description
Match a list of Ensembl protein identifiers

### Metadata
- **Docker Image**: quay.io/biocontainers/pathwaymatcher:1.9.1--1
- **Homepage**: https://github.com/LuisFranciscoHS/PathwayMatcher
- **Package**: https://anaconda.org/channels/bioconda/packages/pathwaymatcher/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
Missing required option '--input=<input_path>'
Usage: java -jar PathwayMatcher.jar match-ensembl [-gT] [-gg] [-gp] [-gu]
                                                  [--mapping=<mapping_path>]
                                                  -i=<input_path>
                                                  [-o=<output_prefix>]
Match a list of Ensembl protein identifiers
      --mapping=<mapping_path>
                             Path to directory with the static mapping files. By
                               default uses the mapping files integrated in the jar
                               file.
  -g, --graph                Create default connection graph according to input type.
      -gg, --graphGene       Create gene connection graph
      -gp, --graphProteoform Create proteoform connection graph
      -gu, --graphUniprot    Create protein connection graph
  -i, --input=<input_path>   Input file with path
  -o, --output=<output_prefix>
                             Path and prefix for the output files: search.tsv (list
                               of reactions and pathways containing the input),
                               analysis.tsv (over-representation analysis) and
                               networks files.
  -T, --topLevelPathways     Show Top Level Pathways in the search result.
```


## pathwaymatcher_match-vcf

### Tool Description
Match a list of genetic variants in VCF format

### Metadata
- **Docker Image**: quay.io/biocontainers/pathwaymatcher:1.9.1--1
- **Homepage**: https://github.com/LuisFranciscoHS/PathwayMatcher
- **Package**: https://anaconda.org/channels/bioconda/packages/pathwaymatcher/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
Missing required option '--input=<input_path>'
Usage: java -jar PathwayMatcher.jar match-vcf [-gT] [-gg] [-gp] [-gu]
                                              [--mapping=<mapping_path>]
                                              -i=<input_path>
                                              [-o=<output_prefix>]
Match a list of genetic variants in VCF format
      --mapping=<mapping_path>
                             Path to directory with the static mapping files. By
                               default uses the mapping files integrated in the jar
                               file.
  -g, --graph                Create default connection graph according to input type.
      -gg, --graphGene       Create gene connection graph
      -gp, --graphProteoform Create proteoform connection graph
      -gu, --graphUniprot    Create protein connection graph
  -i, --input=<input_path>   Input file with path
  -o, --output=<output_prefix>
                             Path and prefix for the output files: search.tsv (list
                               of reactions and pathways containing the input),
                               analysis.tsv (over-representation analysis) and
                               networks files.
  -T, --topLevelPathways     Show Top Level Pathways in the search result.
```


## pathwaymatcher_match-chrbp

### Tool Description
Match a list of genetic variants as chromosome and base pairs

### Metadata
- **Docker Image**: quay.io/biocontainers/pathwaymatcher:1.9.1--1
- **Homepage**: https://github.com/LuisFranciscoHS/PathwayMatcher
- **Package**: https://anaconda.org/channels/bioconda/packages/pathwaymatcher/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
Missing required option '--input=<input_path>'
Usage: java -jar PathwayMatcher.jar match-chrbp [-gT] [-gg] [-gp] [-gu]
                                                [--mapping=<mapping_path>]
                                                -i=<input_path>
                                                [-o=<output_prefix>]
Match a list of genetic variants as chromosome and base pairs
      --mapping=<mapping_path>
                             Path to directory with the static mapping files. By
                               default uses the mapping files integrated in the jar
                               file.
  -g, --graph                Create default connection graph according to input type.
      -gg, --graphGene       Create gene connection graph
      -gp, --graphProteoform Create proteoform connection graph
      -gu, --graphUniprot    Create protein connection graph
  -i, --input=<input_path>   Input file with path
  -o, --output=<output_prefix>
                             Path and prefix for the output files: search.tsv (list
                               of reactions and pathways containing the input),
                               analysis.tsv (over-representation analysis) and
                               networks files.
  -T, --topLevelPathways     Show Top Level Pathways in the search result.
```


## pathwaymatcher_base

### Tool Description
PathwayMatcher is a tool for mapping biological entities (genes, proteins, variants, etc.) to pathways. (Note: The provided text indicates an execution error or unrecognized subcommand).

### Metadata
- **Docker Image**: quay.io/biocontainers/pathwaymatcher:1.9.1--1
- **Homepage**: https://github.com/LuisFranciscoHS/PathwayMatcher
- **Package**: https://anaconda.org/channels/bioconda/packages/pathwaymatcher/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
Unmatched arguments: base, -elp (while processing option: '-help')
Did you mean: match-ensembl?
```


## pathwaymatcher_match-rsids

### Tool Description
Match a list of genetic variants as RsIds

### Metadata
- **Docker Image**: quay.io/biocontainers/pathwaymatcher:1.9.1--1
- **Homepage**: https://github.com/LuisFranciscoHS/PathwayMatcher
- **Package**: https://anaconda.org/channels/bioconda/packages/pathwaymatcher/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
Missing required option '--input=<input_path>'
Usage: java -jar PathwayMatcher.jar match-rsids [-gT] [-gg] [-gp] [-gu]
                                                [--mapping=<mapping_path>]
                                                -i=<input_path>
                                                [-o=<output_prefix>]
Match a list of genetic variants as RsIds
      --mapping=<mapping_path>
                             Path to directory with the static mapping files. By
                               default uses the mapping files integrated in the jar
                               file.
  -g, --graph                Create default connection graph according to input type.
      -gg, --graphGene       Create gene connection graph
      -gp, --graphProteoform Create proteoform connection graph
      -gu, --graphUniprot    Create protein connection graph
  -i, --input=<input_path>   Input file with path
  -o, --output=<output_prefix>
                             Path and prefix for the output files: search.tsv (list
                               of reactions and pathways containing the input),
                               analysis.tsv (over-representation analysis) and
                               networks files.
  -T, --topLevelPathways     Show Top Level Pathways in the search result.
```


## pathwaymatcher_match-peptides

### Tool Description
Match a list of peptides to proteins and identify associated reactions and pathways.

### Metadata
- **Docker Image**: quay.io/biocontainers/pathwaymatcher:1.9.1--1
- **Homepage**: https://github.com/LuisFranciscoHS/PathwayMatcher
- **Package**: https://anaconda.org/channels/bioconda/packages/pathwaymatcher/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
Missing required options [--input=<input_path>, --fasta=<fasta_path>]
Usage: java -jar PathwayMatcher.jar match-peptides [-gT] [-gg] [-gp] [-gu]
                                                   [--mapping=<mapping_path>]
                                                   -f=<fasta_path>
                                                   -i=<input_path>
                                                   [-o=<output_prefix>]
Match a list of peptides
      --mapping=<mapping_path>
                             Path to directory with the static mapping files. By
                               default uses the mapping files integrated in the jar
                               file.
  -f, --fasta=<fasta_path>   Path and name of the fasta file containing the Proteins
                               where to find the peptides.
  -g, --graph                Create default connection graph according to input type.
      -gg, --graphGene       Create gene connection graph
      -gp, --graphProteoform Create proteoform connection graph
      -gu, --graphUniprot    Create protein connection graph
  -i, --input=<input_path>   Input file with path
  -o, --output=<output_prefix>
                             Path and prefix for the output files: search.tsv (list
                               of reactions and pathways containing the input),
                               analysis.tsv (over-representation analysis) and
                               networks files.
  -T, --topLevelPathways     Show Top Level Pathways in the search result.
```


## pathwaymatcher_match-modified-peptides

### Tool Description
Match a list of peptides with post translational modifications

### Metadata
- **Docker Image**: quay.io/biocontainers/pathwaymatcher:1.9.1--1
- **Homepage**: https://github.com/LuisFranciscoHS/PathwayMatcher
- **Package**: https://anaconda.org/channels/bioconda/packages/pathwaymatcher/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
Missing required options [--input=<input_path>, --fasta=<fasta_path>]
Usage: java -jar PathwayMatcher.jar match-modified-peptides [-gT] [-gg] [-gp]
                                                            [-gu]
                                                            [--mapping=<mapping_
                                                            path>]
                                                            -f=<fasta_path>
                                                            -i=<input_path>
                                                            [-m=<matchType>]
                                                            [-o=<output_prefix>]
                                                             [-r=<range>]
Match a list of peptides with post translational modifications
      --mapping=<mapping_path>
                             Path to directory with the static mapping files. By
                               default uses the mapping files integrated in the jar
                               file.
  -f, --fasta=<fasta_path>   Path and name of the fasta file containing the Proteins
                               where to find the peptides.
  -g, --graph                Create default connection graph according to input type.
      -gg, --graphGene       Create gene connection graph
      -gp, --graphProteoform Create proteoform connection graph
      -gu, --graphUniprot    Create protein connection graph
  -i, --input=<input_path>   Input file with path
  -m, --matchType=<matchType>
                             Proteoform match criteria.
                             Valid values: STRICT, SUPERSET, SUPERSET_NO_TYPES,
                               SUBSET, SUBSET_NO_TYPES, ONE, ONE_NO_TYPES.
                             Default: SUBSET
  -o, --output=<output_prefix>
                             Path and prefix for the output files: search.tsv (list
                               of reactions and pathways containing the input),
                               analysis.tsv (over-representation analysis) and
                               networks files.
  -r, --range=<range>        Integer range of error for PTM sites.
                             Default: 0
  -T, --topLevelPathways     Show Top Level Pathways in the search result.
```


## pathwaymatcher_modifications

### Tool Description
A tool for matching biological entities (likely modified peptides) to pathways. Note: The provided help text indicates an error or invalid subcommand.

### Metadata
- **Docker Image**: quay.io/biocontainers/pathwaymatcher:1.9.1--1
- **Homepage**: https://github.com/LuisFranciscoHS/PathwayMatcher
- **Package**: https://anaconda.org/channels/bioconda/packages/pathwaymatcher/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
Unmatched arguments: modifications, -elp (while processing option: '-help')
Did you mean: match-modified-peptides or match-ensembl or match-peptides?
```


## Metadata
- **Skill**: generated
