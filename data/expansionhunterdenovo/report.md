# expansionhunterdenovo CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| expansionhunterdenovo_annotate_ehdn | Not completed | needs a licensed ANNOVAR installation and its refGene humandb |
| expansionhunterdenovo_casecontrol_locus | Failed | image problem: the python script stops with ModuleNotFoundError: numpy (not in the image) |
| expansionhunterdenovo_casecontrol_motif | Failed | image problem: the python script stops with ModuleNotFoundError: numpy (not in the image) |
| expansionhunterdenovo_make_bamlet | Failed | image problem: the python script stops with ModuleNotFoundError: pysam (not in the image) |
| expansionhunterdenovo_merge | PASS |  |
| expansionhunterdenovo_outlier_locus | Failed | image problem: the python script stops with ModuleNotFoundError: numpy (not in the image) |
| expansionhunterdenovo_outlier_motif | Failed | image problem: the python script stops with ModuleNotFoundError: numpy (not in the image) |
| expansionhunterdenovo_profile | PASS |  |


## expansionhunterdenovo_profile

### Tool Description
Compute genome-wide STR profile

### Metadata
- **Docker Image**: quay.io/biocontainers/expansionhunterdenovo:0.9.0--h6ac36c1_11
- **Homepage**: https://github.com/Illumina/ExpansionHunterDenovo
- **Package**: https://anaconda.org/channels/bioconda/packages/expansionhunterdenovo/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ExpansionHunterDenovo profile [options]

Available options:
  --help                      Print help message
  --reads arg                 BAM or CRAM file with aligned reads
  --reference arg             FASTA file with reference assembly
  --output-prefix arg         Prefix for the output files
  --min-unit-len arg (=2)     Shortest repeat unit to consider
  --max-unit-len arg (=20)    Longest repeat unit to consider
  --min-anchor-mapq arg (=50) Minimum MAPQ of an anchor read
  --max-irr-mapq arg (=40)    Maximum MAPQ of an in-repeat read
  --log-reads                 Log informative reads
```


## expansionhunterdenovo_merge

### Tool Description
Generate multisample STR profile from single-sample profiles

### Metadata
- **Docker Image**: quay.io/biocontainers/expansionhunterdenovo:0.9.0--h6ac36c1_11
- **Homepage**: https://github.com/Illumina/ExpansionHunterDenovo
- **Package**: https://anaconda.org/channels/bioconda/packages/expansionhunterdenovo/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ExpansionHunterDenovo merge [options]

Available options:
  --help                   Print help message
  --reference arg          FASTA file with reference assembly
  --manifest arg           TSV with sample names and absolute paths
  --output-prefix arg      Prefix for the output files
  --min-unit-len arg (=2)  Shortest repeat unit to consider
  --max-unit-len arg (=20) Longest repeat unit to consider
```


## expansionhunterdenovo_annotate_ehdn

### Tool Description
Annotate ExpansionHunter Denovo locus results with ANNOVAR

### Metadata
- **Docker Image**: quay.io/biocontainers/expansionhunterdenovo:0.9.0--h6ac36c1_11
- **Homepage**: https://github.com/Illumina/ExpansionHunterDenovo
- **Package**: https://anaconda.org/channels/bioconda/packages/expansionhunterdenovo/overview
- **Validation**: PASS

### Original Help Text
```text
annotate_ehdn.sh [options]

Available options:
  -h | --help                   Print help message
  --ehdn-results                ExpansionHunterDenovo secondary locus analysis tsv
  --ehdn-annotated-results      ExpansionHunterDenovo annotated output filename
  --annovar-annotate-variation  ANNOVAR annotate_variation.pl script path
  --annovar-humandb             ANNOVAR humandb directory
  --annovar-buildver            ANNOVAR buildver option (hg19, hg38, ...)

Annotation script requires ANNOVAR installation.
```


## expansionhunterdenovo_casecontrol_locus

### Tool Description
Perform locus-based case-control analysis

### Metadata
- **Docker Image**: quay.io/biocontainers/expansionhunterdenovo:0.9.0--h6ac36c1_11
- **Homepage**: https://github.com/Illumina/ExpansionHunterDenovo
- **Package**: https://anaconda.org/channels/bioconda/packages/expansionhunterdenovo/overview
- **Validation**: PASS

### Original Help Text
```text
casecontrol.py locus --manifest M --multisample-profile P --output O [--min-inrepeat-reads N] [--target-regions BED] [--test-params normal]
(taken from scripts/casecontrol.py; the image cannot print help because numpy is missing)
```


## expansionhunterdenovo_casecontrol_motif

### Tool Description
Perform motif-based case-control analysis

### Metadata
- **Docker Image**: quay.io/biocontainers/expansionhunterdenovo:0.9.0--h6ac36c1_11
- **Homepage**: https://github.com/Illumina/ExpansionHunterDenovo
- **Package**: https://anaconda.org/channels/bioconda/packages/expansionhunterdenovo/overview
- **Validation**: PASS

### Original Help Text
```text
casecontrol.py motif --manifest M --multisample-profile P --output O [--min-inrepeat-read-pairs N] [--test-params normal]
(taken from scripts/casecontrol.py)
```


## expansionhunterdenovo_outlier_locus

### Tool Description
Perform locus-based outlier analysis

### Metadata
- **Docker Image**: quay.io/biocontainers/expansionhunterdenovo:0.9.0--h6ac36c1_11
- **Homepage**: https://github.com/Illumina/ExpansionHunterDenovo
- **Package**: https://anaconda.org/channels/bioconda/packages/expansionhunterdenovo/overview
- **Validation**: PASS

### Original Help Text
```text
outlier.py locus --manifest M --multisample-profile P --output O [--target-regions BED]
(taken from scripts/outlier.py)
```


## expansionhunterdenovo_outlier_motif

### Tool Description
Perform motif-based outlier analysis

### Metadata
- **Docker Image**: quay.io/biocontainers/expansionhunterdenovo:0.9.0--h6ac36c1_11
- **Homepage**: https://github.com/Illumina/ExpansionHunterDenovo
- **Package**: https://anaconda.org/channels/bioconda/packages/expansionhunterdenovo/overview
- **Validation**: PASS

### Original Help Text
```text
outlier.py motif --manifest M --multisample-profile P --output O
(taken from scripts/outlier.py)
```


## expansionhunterdenovo_make_bamlet

### Tool Description
A script to generate BAMlets

### Metadata
- **Docker Image**: quay.io/biocontainers/expansionhunterdenovo:0.9.0--h6ac36c1_11
- **Homepage**: https://github.com/Illumina/ExpansionHunterDenovo
- **Package**: https://anaconda.org/channels/bioconda/packages/expansionhunterdenovo/overview
- **Validation**: PASS

### Original Help Text
```text
make-bamlet.py --bam BAM --region chr:start-end --bamlet OUT.bam
(taken from scripts/make-bamlet.py; the image cannot print help because pysam is missing)
```


