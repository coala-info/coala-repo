# scorpio CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| scorpio_classify | PASS |  |
| scorpio_define | PASS |  |
| scorpio_haplotype | PASS |  |
| scorpio_list | PASS |  |

## scorpio_classify

### Tool Description
Classify sequences by lineage-defining constellations with rules

### Metadata
- **Docker Image**: quay.io/biocontainers/scorpio:0.3.19--pyhdfd78af_0
- **Homepage**: https://github.com/cov-lineages/scorpio
- **Package**: https://anaconda.org/channels/bioconda/packages/scorpio/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scorpio classify [-h] [-o OUTPUT] [-p PREFIX] [--log-file <filename>]
                        [-c CONSTELLATIONS [CONSTELLATIONS ...]]
                        [-n NAMES [NAMES ...]] [-l LABEL] [--pangolin]
                        [--mutations MUTATIONS [MUTATIONS ...]]
                        [--reference-json REFERENCE_JSON] [--verbose]
                        [--dry-run] [-t THREADS] -i INPUT [--output-counts]
                        [--call-all] [--long] [--list-incompatible]

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Primary input file - an aligned FASTA
  --output-counts       Save a file per constellation with columns for the
                        ref, alt, ambig and other counts as well as a
                        True/False call for each sample
  --call-all            Allow multiple classifications and output these as a
                        pipe separated list in the summary file
  --long                Write out summary file in long format, including the
                        counts for the winning constellation
  --list-incompatible   Adds column to the summary file listing incompatible
                        lineages for the winning constellation as listed in
                        the constellation JSON

Input/output options:
  -o OUTPUT, --output OUTPUT
                        Output file or path
  -p PREFIX, --prefix PREFIX
                        Output prefix. Default: scorpio
  --log-file <filename>
                        Log file to use (otherwise uses stdout)

Constellation options:
  -c CONSTELLATIONS [CONSTELLATIONS ...], --constellations CONSTELLATIONS [CONSTELLATIONS ...]
                        One or more JSON (or CSV) files specifying variants
  -n NAMES [NAMES ...], --names NAMES [NAMES ...]
                        Names of constellations to include
  -l LABEL, --label LABEL
                        Use alternative label specified in JSON where possible
  --pangolin            Uses `mrca_lineage` as label and excludes
                        constellations/data directory for robustness
  --mutations MUTATIONS [MUTATIONS ...]
                        Extra mutations to type

Reference options:
  --reference-json REFERENCE_JSON
                        JSON file containing keys "genome" with reference
                        sequence and "proteins", "features" or "genes" with
                        features of interest and their coordinates

Misc options:
  --verbose             Print lots of stuff to screen
  --dry-run             Quit after checking constellations and variants are
                        AOK
  -t THREADS, --threads THREADS
                        Number of threads
```

## scorpio_haplotype

### Tool Description
Write haplotypes (barcode strings or per-site columns) for a set of constellations

### Metadata
- **Docker Image**: quay.io/biocontainers/scorpio:0.3.19--pyhdfd78af_0
- **Homepage**: https://github.com/cov-lineages/scorpio
- **Package**: https://anaconda.org/channels/bioconda/packages/scorpio/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scorpio haplotype [-h] [-o OUTPUT] [-p PREFIX] [--log-file <filename>]
                         [-c CONSTELLATIONS [CONSTELLATIONS ...]]
                         [-n NAMES [NAMES ...]] [-l LABEL] [--pangolin]
                         [--mutations MUTATIONS [MUTATIONS ...]]
                         [--reference-json REFERENCE_JSON] [--verbose]
                         [--dry-run] [-t THREADS] -i INPUT
                         [--ref-char REF_CHAR] [--output-counts]
                         [--append-genotypes] [--combination]
                         [--interspersion]

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Primary input file - an aligned FASTA
  --ref-char REF_CHAR   Symbol to use to represent reference allele in barcode
                        strings
  --output-counts       Save a file per constellation with columns for the
                        ref, alt, ambig and other counts as well as a
                        True/False call for each sample
  --append-genotypes    Output a column per variant site instead of a barcode
                        string. If only a single constellation is being typed,
                        this will be placed in the summary file, otherwise in
                        a file per constellation
  --combination         Combines the mutations for the specified
                        constellations, and outputs a string across them all,
                        with counts per found constellation
  --interspersion       Evaluates an interspersion score (dev feature)

Input/output options:
  -o OUTPUT, --output OUTPUT
                        Output file or path
  -p PREFIX, --prefix PREFIX
                        Output prefix. Default: scorpio
  --log-file <filename>
                        Log file to use (otherwise uses stdout)

Constellation options:
  -c CONSTELLATIONS [CONSTELLATIONS ...], --constellations CONSTELLATIONS [CONSTELLATIONS ...]
                        One or more JSON (or CSV) files specifying variants
  -n NAMES [NAMES ...], --names NAMES [NAMES ...]
                        Names of constellations to include
  -l LABEL, --label LABEL
                        Use alternative label specified in JSON where possible
  --pangolin            Uses `mrca_lineage` as label and excludes
                        constellations/data directory for robustness
  --mutations MUTATIONS [MUTATIONS ...]
                        Extra mutations to type

Reference options:
  --reference-json REFERENCE_JSON
                        JSON file containing keys "genome" with reference
                        sequence and "proteins", "features" or "genes" with
                        features of interest and their coordinates

Misc options:
  --verbose             Print lots of stuff to screen
  --dry-run             Quit after checking constellations and variants are
                        AOK
  -t THREADS, --threads THREADS
                        Number of threads
```

## scorpio_define

### Tool Description
Extract group-defining mutations from per-sample mutations and a group column

### Metadata
- **Docker Image**: quay.io/biocontainers/scorpio:0.3.19--pyhdfd78af_0
- **Homepage**: https://github.com/cov-lineages/scorpio
- **Package**: https://anaconda.org/channels/bioconda/packages/scorpio/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scorpio define [-h] [-o OUTPUT] [-p PREFIX] [--log-file <filename>]
                      [-c CONSTELLATIONS [CONSTELLATIONS ...]]
                      [-n NAMES [NAMES ...]] [-l LABEL] [--pangolin]
                      [--mutations MUTATIONS [MUTATIONS ...]]
                      [--reference-json REFERENCE_JSON] [--verbose]
                      [--dry-run] [-t THREADS] -i INPUT
                      [--in-groups IN_GROUPS] [--group-column GROUP_COLUMN]
                      [--index-column INDEX_COLUMN]
                      [--subset SUBSET [SUBSET ...]]
                      [--threshold-common THRESHOLD_COMMON]
                      [--threshold-intermediate THRESHOLD_INTERMEDIATE]
                      [--outgroups OUTGROUPS] [--outgroup-json OUTGROUP_JSON]
                      [--protein] [--nucleotide]

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Primary input file - a CSV
  --in-groups IN_GROUPS
                        CSV of containing sequence_name and a column defining
                        groups
  --group-column GROUP_COLUMN
                        Column name defining the groups
  --index-column INDEX_COLUMN
                        Taxon column name
  --subset SUBSET [SUBSET ...]
                        Names of a subset of groups to define
  --threshold-common THRESHOLD_COMMON
                        Frequency of a variant within group to be considered
                        common
  --threshold-intermediate THRESHOLD_INTERMEDIATE
                        Frequency of a variant within group to be reported as
                        intermediate
  --outgroups OUTGROUPS
                        Two column CSV with group, and pipe separated list of
                        outgroup sequence_names for that list. Assumes
                        outgroups will be in main input CSV
  --outgroup-json OUTGROUP_JSON
                        A single JSON constellation file defining an outgroup
                        for all sequences
  --protein             Translates definition coordinates to proteins where
                        possible
  --nucleotide          Do not translate to amino acid coordinates

Input/output options:
  -o OUTPUT, --output OUTPUT
                        Output file or path
  -p PREFIX, --prefix PREFIX
                        Output prefix. Default: scorpio
  --log-file <filename>
                        Log file to use (otherwise uses stdout)

Constellation options:
  -c CONSTELLATIONS [CONSTELLATIONS ...], --constellations CONSTELLATIONS [CONSTELLATIONS ...]
                        One or more JSON (or CSV) files specifying variants
  -n NAMES [NAMES ...], --names NAMES [NAMES ...]
                        Names of constellations to include
  -l LABEL, --label LABEL
                        Use alternative label specified in JSON where possible
  --pangolin            Uses `mrca_lineage` as label and excludes
                        constellations/data directory for robustness
  --mutations MUTATIONS [MUTATIONS ...]
                        Extra mutations to type

Reference options:
  --reference-json REFERENCE_JSON
                        JSON file containing keys "genome" with reference
                        sequence and "proteins", "features" or "genes" with
                        features of interest and their coordinates

Misc options:
  --verbose             Print lots of stuff to screen
  --dry-run             Quit after checking constellations and variants are
                        AOK
  -t THREADS, --threads THREADS
                        Number of threads
```

## scorpio_list

### Tool Description
List the constellations installed that would be typed with the given options

### Metadata
- **Docker Image**: quay.io/biocontainers/scorpio:0.3.19--pyhdfd78af_0
- **Homepage**: https://github.com/cov-lineages/scorpio
- **Package**: https://anaconda.org/channels/bioconda/packages/scorpio/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scorpio list [-h] [-o OUTPUT] [-p PREFIX] [--log-file <filename>]
                    [-c CONSTELLATIONS [CONSTELLATIONS ...]]
                    [-n NAMES [NAMES ...]] [-l LABEL] [--pangolin]
                    [--mutations MUTATIONS [MUTATIONS ...]]
                    [--reference-json REFERENCE_JSON] [--verbose] [--dry-run]
                    [-t THREADS]

options:
  -h, --help            show this help message and exit

Input/output options:
  -o OUTPUT, --output OUTPUT
                        Output file or path
  -p PREFIX, --prefix PREFIX
                        Output prefix. Default: scorpio
  --log-file <filename>
                        Log file to use (otherwise uses stdout)

Constellation options:
  -c CONSTELLATIONS [CONSTELLATIONS ...], --constellations CONSTELLATIONS [CONSTELLATIONS ...]
                        One or more JSON (or CSV) files specifying variants
  -n NAMES [NAMES ...], --names NAMES [NAMES ...]
                        Names of constellations to include
  -l LABEL, --label LABEL
                        Use alternative label specified in JSON where possible
  --pangolin            Uses `mrca_lineage` as label and excludes
                        constellations/data directory for robustness
  --mutations MUTATIONS [MUTATIONS ...]
                        Extra mutations to type

Reference options:
  --reference-json REFERENCE_JSON
                        JSON file containing keys "genome" with reference
                        sequence and "proteins", "features" or "genes" with
                        features of interest and their coordinates

Misc options:
  --verbose             Print lots of stuff to screen
  --dry-run             Quit after checking constellations and variants are
                        AOK
  -t THREADS, --threads THREADS
                        Number of threads
```

