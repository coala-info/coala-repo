# tracknado CWL Generation Report

## tracknado_create

### Tool Description
Create a UCSC track hub from a set of files.

### Metadata
- **Docker Image**: quay.io/biocontainers/tracknado:0.3.1--pyhdfd78af_0
- **Homepage**: https://pypi.org/project/tracknado/
- **Package**: https://anaconda.org/channels/bioconda/packages/tracknado/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tracknado/overview
- **Total Downloads**: 2.6K
- **Last updated**: 2026-01-16
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage: tracknado create [OPTIONS]                                              
                                                                                
 Create a UCSC track hub from a set of files.                                   
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --input-files    -i      PATH  A list of local track files (bigWig, bigBed,  │
│                                BAM, etc.) to include in the hub.             │
│ --output         -o      PATH  The directory where the staged hub and        │
│                                tracknado_config.json will be created.        │
│ --metadata       -m      PATH  Path to a CSV/TSV containing track metadata.  │
│                                Must include a 'fn' column with file paths.   │
│ --seqnado                      Automatically extract sample metadata using   │
│                                the seqnado directory structure convention.   │
│ --hub-name               TEXT  The short identifier for the hub (used in     │
│                                UCSC URL).                                    │
│                                [default: HUB]                                │
│ --hub-email              TEXT  Contact email displayed on the hub's          │
│                                description page.                             │
│                                [default: alastair.smith@ndcls.ox.ac.uk]      │
│ --genome-name            TEXT  The genome assembly ID (e.g., hg38, mm10).    │
│                                For custom genomes, use this as the assembly  │
│                                name.                                         │
│                                [default: hg38]                               │
│ --color-by               TEXT  The metadata column name to use for           │
│                                determining track colors.                     │
│ --supergroup-by          TEXT  One or more metadata columns to use for       │
│                                top-level track grouping (SuperTracks).       │
│ --subgroup-by            TEXT  Metadata columns to define multi-dimensional  │
│                                CompositeTracks (matrix display).             │
│ --overlay-by             TEXT  Metadata columns to define OverlayTracks      │
│                                (e.g., multi-signal plots).                   │
│ --url-prefix             TEXT  Base URL where the hub will be hosted (used   │
│                                for final URL reporting).                     │
│                                [default: https://userweb.molbiol.ox.ac.uk]   │
│ --convert                      Enable automatic conversion of formats like   │
│                                BED -> bigBed or GTF -> bigGenePred.          │
│ --chrom-sizes            PATH  Required for --convert. Path to a chrom.sizes │
│                                file for the target genome.                   │
│ --custom-genome                Flag to indicate an Assembly Hub (custom      │
│                                genome) rather than a built-in UCSC genome.   │
│ --twobit                 PATH  Required for custom genomes. Path to the      │
│                                .2bit file containing the genome sequence.    │
│ --organism               TEXT  Required for custom genomes. Common name of   │
│                                the organism (e.g., 'Human', 'Mouse').        │
│ --default-pos            TEXT  Set the initial viewing coordinates for the   │
│                                hub.                                          │
│                                [default: chr1:10000-20000]                   │
│ --description            PATH  Path to an HTML file to display as the hub's  │
│                                landing page/documentation.                   │
│ --template       -t      PATH  Create a template metadata file at the        │
│                                specified path and exit.                      │
│ --help                         Show this message and exit.                   │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## tracknado_merge

### Tool Description
Merge tracknado configurations or data

### Metadata
- **Docker Image**: quay.io/biocontainers/tracknado:0.3.1--pyhdfd78af_0
- **Homepage**: https://pypi.org/project/tracknado/
- **Package**: https://anaconda.org/channels/bioconda/packages/tracknado/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: tracknado merge [OPTIONS] INPUT_CONFIGS...
Try 'tracknado merge --help' for help.
╭─ Error ──────────────────────────────────────────────────────────────────────╮
│ No such option: -h                                                           │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## tracknado_validate

### Tool Description
Validate a local hub directory or hub.txt file. Performs structural checks and uses the UCSC 'hubCheck' tool if available to ensure the hub is correctly formatted and accessible.

### Metadata
- **Docker Image**: quay.io/biocontainers/tracknado:0.3.1--pyhdfd78af_0
- **Homepage**: https://pypi.org/project/tracknado/
- **Package**: https://anaconda.org/channels/bioconda/packages/tracknado/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: tracknado validate [OPTIONS] HUB_PATH                                   
                                                                                
 Validate a local hub directory or hub.txt file.                                
                                                                                
 Performs structural checks and uses the UCSC 'hubCheck' tool if available      
 to ensure the hub is correctly formatted and accessible.                       
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│ *    hub_path      PATH  Path to a hub directory or a 'hub.txt' file to      │
│                          check for errors.                                   │
│                          [required]                                          │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --strict          If set, treats all warnings as errors during validation.   │
│ --help            Show this message and exit.                                │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## Metadata
- **Skill**: generated
