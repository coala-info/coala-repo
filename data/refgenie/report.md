# refgenie CWL Generation Report

## refgenie_init

### Tool Description
Initialize a genome configuration.

### Metadata
- **Docker Image**: quay.io/biocontainers/refgenie:0.12.1--pyhdfd78af_0
- **Homepage**: http://refgenie.databio.org
- **Package**: https://anaconda.org/channels/bioconda/packages/refgenie/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/refgenie/overview
- **Total Downloads**: 63.8K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: refgenie init [-h] -c C [--skip-read-lock] [-s GENOME_SERVER [GENOME_SERVER ...]]
                     [-f GENOME_FOLDER] [-a GENOME_ARCHIVE_FOLDER]
                     [-b GENOME_ARCHIVE_CONFIG] [-u REMOTE_URL_BASE] [-j SETTINGS_JSON]

Initialize a genome configuration.

optional arguments:
  -h, --help                            show this help message and exit
  -c C, --genome-config C               Path to local genome configuration file. Optional
                                        if REFGENIE environment variable is set.
  --skip-read-lock                      Whether the config file should not be locked for
                                        reading
  -s GENOME_SERVER [GENOME_SERVER ...], --genome-server GENOME_SERVER [GENOME_SERVER ...]
                                        URL(s) to use for the genome_servers attribute in
                                        config file. Default:
                                        http://refgenomes.databio.org.
  -f GENOME_FOLDER, --genome-folder GENOME_FOLDER
                                        Absolute path to parent folder refgenie-managed
                                        assets.
  -a GENOME_ARCHIVE_FOLDER, --genome-archive-folder GENOME_ARCHIVE_FOLDER
                                        Absolute path to parent archive folder refgenie-
                                        managed assets; used by refgenieserver.
  -b GENOME_ARCHIVE_CONFIG, --genome-archive-config GENOME_ARCHIVE_CONFIG
                                        Absolute path to desired archive config file; used
                                        by refgenieserver.
  -u REMOTE_URL_BASE, --remote-url-base REMOTE_URL_BASE
                                        URL to use as an alternative, remote archive
                                        location; used by refgenieserver.
  -j SETTINGS_JSON, --settings-json SETTINGS_JSON
                                        Absolute path to a JSON file with the key value
                                        pairs to inialize the configuration file with.
                                        Overwritten by itemized specifications.
```


## refgenie_list

### Tool Description
List available local assets.

### Metadata
- **Docker Image**: quay.io/biocontainers/refgenie:0.12.1--pyhdfd78af_0
- **Homepage**: http://refgenie.databio.org
- **Package**: https://anaconda.org/channels/bioconda/packages/refgenie/overview
- **Validation**: PASS

### Original Help Text
```text
usage: refgenie list [-h] [-c C] [--skip-read-lock] [-g [G ...]] [-r]

List available local assets.

optional arguments:
  -h, --help                    show this help message and exit
  -c C, --genome-config C       Path to local genome configuration file. Optional if
                                REFGENIE environment variable is set.
  --skip-read-lock              Whether the config file should not be locked for reading
  -g [G ...], --genome [G ...]  Reference assembly ID, e.g. mm10.
  -r, --recipes                 List available recipes.
```


## refgenie_listr

### Tool Description
Remote refgenie assets

### Metadata
- **Docker Image**: quay.io/biocontainers/refgenie:0.12.1--pyhdfd78af_0
- **Homepage**: http://refgenie.databio.org
- **Package**: https://anaconda.org/channels/bioconda/packages/refgenie/overview
- **Validation**: PASS

### Original Help Text
```text
Remote refgenie assets                             
                   Server URL: http://refgenomes.databio.org                    
┏━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃ genome           ┃ assets                                                    ┃
┡━━━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┩
│ rCRSd            │ fasta, bowtie2_index, bwa_index, star_index,              │
│                  │ hisat2_index, bismark_bt2_index                           │
│ hg38             │ fasta, gencode_gtf, refgene_anno, dbsnp, ensembl_gtf,     │
│                  │ ensembl_rb, suffixerator_index, bwa_index, bowtie2_index, │
│                  │ dbnsfp, star_index, fasta_txome, hisat2_index,            │
│                  │ cellranger_reference, bismark_bt2_index,                  │
│                  │ salmon_partial_sa_index, tgMap, salmon_sa_index           │
│ human_repeats    │ fasta, suffixerator_index, bowtie2_index, bwa_index,      │
│                  │ star_index, hisat2_index, bismark_bt2_index               │
│ mouse_chrM2x     │ fasta, suffixerator_index, bowtie2_index, bwa_index,      │
│                  │ star_index, hisat2_index, bismark_bt2_index               │
│ hg18_cdna        │ fasta, kallisto_index                                     │
│ hs38d1           │ fasta, suffixerator_index, bowtie2_index, bwa_index,      │
│                  │ star_index, hisat2_index, bismark_bt2_index               │
│ hg38_cdna        │ fasta, salmon_index, kallisto_index                       │
│ rn6_cdna         │ fasta, salmon_index, kallisto_index                       │
│ mm10_cdna        │ fasta, salmon_index, kallisto_index                       │
│ hg19_cdna        │ fasta, salmon_index, kallisto_index                       │
│ hg38_chr22       │ fasta, suffixerator_index, bowtie2_index, bwa_index,      │
│                  │ star_index, hisat2_index, bismark_bt2_index               │
│ hg19             │ fasta, gencode_gtf, refgene_anno, dbsnp, ensembl_gtf,     │
│                  │ ensembl_rb, suffixerator_index, bowtie2_index, bwa_index, │
│                  │ hisat2_index, fasta_txome, star_index,                    │
│                  │ cellranger_reference, bismark_bt2_index,                  │
│                  │ salmon_partial_sa_index, tgMap, salmon_sa_index           │
│ hg18             │ fasta, gencode_gtf, bowtie2_index, suffixerator_index,    │
│                  │ bwa_index, hisat2_index, fasta_txome, star_index,         │
│                  │ cellranger_reference, bismark_bt2_index                   │
│ human_alu        │ fasta, suffixerator_index, bowtie2_index, bwa_index,      │
│                  │ hisat2_index, bismark_bt2_index                           │
│ human_rDNA       │ fasta, suffixerator_index, bowtie2_index, bwa_index,      │
│                  │ star_index, hisat2_index, bismark_bt2_index               │
│ human_alphasat   │ fasta, suffixerator_index, bowtie2_index, bwa_index,      │
│                  │ star_index, hisat2_index, bismark_bt2_index               │
│ mm10             │ fasta, gencode_gtf, refgene_anno, ensembl_gtf,            │
│                  │ ensembl_rb, suffixerator_index, bwa_index, bowtie2_index, │
│                  │ hisat2_index, star_index, fasta_txome,                    │
│                  │ cellranger_reference, bismark_bt2_index,                  │
│                  │ salmon_partial_sa_index, tgMap, salmon_sa_index           │
│ rn6              │ fasta, refgene_anno, ensembl_gtf, suffixerator_index,     │
│                  │ bwa_index, bowtie2_index, hisat2_index, star_index,       │
│                  │ fasta_txome, bismark_bt2_index, salmon_partial_sa_index,  │
│                  │ tgMap, salmon_sa_index                                    │
│ t7               │ fasta, bowtie2_index                                      │
│ dm6              │ fasta, gencode_gtf, refgene_anno, ensembl_gtf,            │
│                  │ bowtie2_index                                             │
│ hg38_noalt_decoy │ fasta, suffixerator_index, bwa_index, bowtie2_index,      │
│                  │ star_index, hisat2_index, bismark_bt2_index               │
│ mm10_primary     │ fasta, bowtie2_index, bwa_index                           │
│ hg38_primary     │ fasta, bwa_index, bowtie2_index                           │
│ hg38_mm10        │ fasta, bwa_index                                          │
└──────────────────┴───────────────────────────────────────────────────────────┘
             use refgenie listr -g <genome> for more detailed view
```


## refgenie_pull

### Tool Description
Download assets.

### Metadata
- **Docker Image**: quay.io/biocontainers/refgenie:0.12.1--pyhdfd78af_0
- **Homepage**: http://refgenie.databio.org
- **Package**: https://anaconda.org/channels/bioconda/packages/refgenie/overview
- **Validation**: PASS

### Original Help Text
```text
usage: refgenie pull [-h] [-c C] [--skip-read-lock] [-g G]
                     [--no-overwrite | --force-overwrite] [--no-large | --pull-large]
                     [--size-cutoff S] [-b]
                     asset-registry-paths [asset-registry-paths ...]

Download assets.

positional arguments:
  asset-registry-paths     One or more registry path strings that identify assets (e.g.
                           hg38/fasta or hg38/fasta:tag).

optional arguments:
  -h, --help               show this help message and exit
  -c C, --genome-config C  Path to local genome configuration file. Optional if REFGENIE
                           environment variable is set.
  --skip-read-lock         Whether the config file should not be locked for reading
  -g G, --genome G         Reference assembly ID, e.g. mm10.

Prompt handling:
  These flags configure the pull prompt responses.

  --no-overwrite           Do not overwrite if asset exists.
  --force-overwrite        Overwrite if asset exists.
  --no-large               Do not pull archives over 5GB.
  --pull-large             Pull any archive, regardless of its size.
  --size-cutoff S          Maximum archive file size to download with no confirmation
                           required (in GB, default: 10)
  -b, --batch              Use batch mode: pull large archives, do no overwrite
```


## refgenie_build

### Tool Description
Build genome assets.

### Metadata
- **Docker Image**: quay.io/biocontainers/refgenie:0.12.1--pyhdfd78af_0
- **Homepage**: http://refgenie.databio.org
- **Package**: https://anaconda.org/channels/bioconda/packages/refgenie/overview
- **Validation**: PASS

### Original Help Text
```text
usage: refgenie build [-h] [-c C] [--skip-read-lock] [-R] [-C CONFIG_FILE] [-N]
                      [--tag-description TAG_DESCRIPTION]
                      [--genome-description GENOME_DESCRIPTION] [-d] [--map]
                      [--pull-parents] [--preserve-map-configs] [--reduce]
                      [--assets ASSETS [ASSETS ...]] [--files FILES [FILES ...]]
                      [--params PARAMS [PARAMS ...]] [-v VOLUMES [VOLUMES ...]] [-q]
                      [-r RECIPE] [-g G]
                      [asset-registry-paths ...]

Build genome assets.

positional arguments:
  asset-registry-paths                  One or more registry path strings that identify
                                        assets (e.g. hg38/fasta or hg38/fasta:tag).

optional arguments:
  -h, --help                            show this help message and exit
  -c C, --genome-config C               Path to local genome configuration file. Optional
                                        if REFGENIE environment variable is set.
  --skip-read-lock                      Whether the config file should not be locked for
                                        reading
  -R, --recover                         Overwrite locks to recover from previous failed
                                        run
  -C CONFIG_FILE, --config CONFIG_FILE  Pipeline configuration file (YAML). Relative paths
                                        are with respect to the pipeline script.
  -N, --new-start                       Overwrite all results to start a fresh run
  --tag-description TAG_DESCRIPTION     Add tag level description (e.g. built with version
                                        0.3.2).
  --genome-description GENOME_DESCRIPTION
                                        Add genome level description (e.g. The mouse
                                        mitochondrial genome, released in Dec 2013).
  -d, --docker                          Run all commands in the refgenie docker container.
  --map                                 Run the map procedure: build assets and store the
                                        metadata in separate configs.
  --pull-parents                        Automatically pull the default parent asset if
                                        required but not provided
  --preserve-map-configs                Do not remove the genome configuration files
                                        produced in the potential map step of building
  --reduce                              Run the reduce procedure: gather the metadata
                                        produced with `refgenie build --map`.
  --assets ASSETS [ASSETS ...]          Override the default genome, asset and tag of the
                                        parents (e.g. fasta=hg38/fasta:default
                                        gtf=mm10/gencode_gtf:default).
  --files FILES [FILES ...]             Provide paths to the required files (e.g.
                                        fasta=/path/to/file.fa.gz).
  --params PARAMS [PARAMS ...]          Provide required parameter values (e.g.
                                        param1=value1).
  -v VOLUMES [VOLUMES ...], --volumes VOLUMES [VOLUMES ...]
                                        If using docker, also mount these folders as
                                        volumes.
  -q, --requirements                    Show the build requirements for the specified
                                        asset and exit.
  -r RECIPE, --recipe RECIPE            Provide a recipe to use.
  -g G, --genome G                      Reference assembly ID, e.g. mm10.
```


## refgenie_seek

### Tool Description
Get the path to a local asset.

### Metadata
- **Docker Image**: quay.io/biocontainers/refgenie:0.12.1--pyhdfd78af_0
- **Homepage**: http://refgenie.databio.org
- **Package**: https://anaconda.org/channels/bioconda/packages/refgenie/overview
- **Validation**: PASS

### Original Help Text
```text
usage: refgenie seek [-h] [-c C] [--skip-read-lock] [-g G] [-e]
                     asset-registry-paths [asset-registry-paths ...]

Get the path to a local asset.

positional arguments:
  asset-registry-paths     One or more registry path strings that identify assets (e.g.
                           hg38/fasta or hg38/fasta:tag or hg38/fasta.fai:tag).

optional arguments:
  -h, --help               show this help message and exit
  -c C, --genome-config C  Path to local genome configuration file. Optional if REFGENIE
                           environment variable is set.
  --skip-read-lock         Whether the config file should not be locked for reading
  -g G, --genome G         Reference assembly ID, e.g. mm10.
  -e, --check-exists       Whether the returned asset path should be checked for existence
                           on disk.
```


## refgenie_seekr

### Tool Description
Get the path to a remote asset.

### Metadata
- **Docker Image**: quay.io/biocontainers/refgenie:0.12.1--pyhdfd78af_0
- **Homepage**: http://refgenie.databio.org
- **Package**: https://anaconda.org/channels/bioconda/packages/refgenie/overview
- **Validation**: PASS

### Original Help Text
```text
usage: refgenie seekr [-h] [-c C] [--skip-read-lock] [-g G] [-s S [S ...]] [-p]
                      [--remote-class RC]
                      asset-registry-paths [asset-registry-paths ...]

Get the path to a remote asset.

positional arguments:
  asset-registry-paths                  One or more registry path strings that identify
                                        assets (e.g. hg38/fasta or hg38/fasta:tag or
                                        hg38/fasta.fai:tag).

optional arguments:
  -h, --help                            show this help message and exit
  -c C, --genome-config C               Path to local genome configuration file. Optional
                                        if REFGENIE environment variable is set.
  --skip-read-lock                      Whether the config file should not be locked for
                                        reading
  -g G, --genome G                      Reference assembly ID, e.g. mm10.
  -s S [S ...], --genome-server S [S ...]
                                        One or more URLs to use. This information will not
                                        persist in the genome config file.
  -p, --append-server                   Whether the provided servers should be appended to
                                        the list.
  --remote-class RC                     Remote data provider class, e.g. 'http' or 's3'
```


## refgenie_add

### Tool Description
Add local asset to the config file.

### Metadata
- **Docker Image**: quay.io/biocontainers/refgenie:0.12.1--pyhdfd78af_0
- **Homepage**: http://refgenie.databio.org
- **Package**: https://anaconda.org/channels/bioconda/packages/refgenie/overview
- **Validation**: PASS

### Original Help Text
```text
usage: refgenie add [-h] [-c C] [--skip-read-lock] [-g G] [-f] -p P [-s S]
                    asset-registry-paths [asset-registry-paths ...]

Add local asset to the config file.

positional arguments:
  asset-registry-paths     One or more registry path strings that identify assets (e.g.
                           hg38/fasta or hg38/fasta:tag).

optional arguments:
  -h, --help               show this help message and exit
  -c C, --genome-config C  Path to local genome configuration file. Optional if REFGENIE
                           environment variable is set.
  --skip-read-lock         Whether the config file should not be locked for reading
  -g G, --genome G         Reference assembly ID, e.g. mm10.
  -f, --force              Do not prompt before action, approve upfront.
  -p P, --path P           Relative local path to asset.
  -s S, --seek-keys S      String representation of a JSON object with seek_keys, e.g.
                           '{"seek_key1": "file.txt"}'
```


## refgenie_remove

### Tool Description
Remove a local asset.

### Metadata
- **Docker Image**: quay.io/biocontainers/refgenie:0.12.1--pyhdfd78af_0
- **Homepage**: http://refgenie.databio.org
- **Package**: https://anaconda.org/channels/bioconda/packages/refgenie/overview
- **Validation**: PASS

### Original Help Text
```text
usage: refgenie remove [-h] [-c C] [--skip-read-lock] [-g G] [-f] [-a]
                       asset-registry-paths [asset-registry-paths ...]

Remove a local asset.

positional arguments:
  asset-registry-paths     One or more registry path strings that identify assets (e.g.
                           hg38/fasta or hg38/fasta:tag).

optional arguments:
  -h, --help               show this help message and exit
  -c C, --genome-config C  Path to local genome configuration file. Optional if REFGENIE
                           environment variable is set.
  --skip-read-lock         Whether the config file should not be locked for reading
  -g G, --genome G         Reference assembly ID, e.g. mm10.
  -f, --force              Do not prompt before action, approve upfront.
  -a, --aliases            Remove the genome alias if last asset for that genome is
                           removed.
```


## refgenie_getseq

### Tool Description
Get sequences from a genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/refgenie:0.12.1--pyhdfd78af_0
- **Homepage**: http://refgenie.databio.org
- **Package**: https://anaconda.org/channels/bioconda/packages/refgenie/overview
- **Validation**: PASS

### Original Help Text
```text
usage: refgenie getseq [-h] [-c C] [--skip-read-lock] -g G -l LOCUS

Get sequences from a genome.

optional arguments:
  -h, --help               show this help message and exit
  -c C, --genome-config C  Path to local genome configuration file. Optional if REFGENIE
                           environment variable is set.
  --skip-read-lock         Whether the config file should not be locked for reading
  -g G, --genome G         Reference assembly ID, e.g. mm10.
  -l LOCUS, --locus LOCUS  Coordinates of desired sequence; e.g. 'chr1:50000-50200'.
```


## refgenie_tag

### Tool Description
Tag an asset.

### Metadata
- **Docker Image**: quay.io/biocontainers/refgenie:0.12.1--pyhdfd78af_0
- **Homepage**: http://refgenie.databio.org
- **Package**: https://anaconda.org/channels/bioconda/packages/refgenie/overview
- **Validation**: PASS

### Original Help Text
```text
usage: refgenie tag [-h] [-c C] [--skip-read-lock] [-g G] [-f] (-t TAG | -d)
                    asset-registry-paths [asset-registry-paths ...]

Tag an asset.

positional arguments:
  asset-registry-paths     One or more registry path strings that identify assets (e.g.
                           hg38/fasta or hg38/fasta:tag).

optional arguments:
  -h, --help               show this help message and exit
  -c C, --genome-config C  Path to local genome configuration file. Optional if REFGENIE
                           environment variable is set.
  --skip-read-lock         Whether the config file should not be locked for reading
  -g G, --genome G         Reference assembly ID, e.g. mm10.
  -f, --force              Do not prompt before action, approve upfront.
  -t TAG, --tag TAG        Tag to assign to an asset.
  -d, --default            Set the selected asset tag as the default one.
```


## refgenie_id

### Tool Description
Return the asset digest.

### Metadata
- **Docker Image**: quay.io/biocontainers/refgenie:0.12.1--pyhdfd78af_0
- **Homepage**: http://refgenie.databio.org
- **Package**: https://anaconda.org/channels/bioconda/packages/refgenie/overview
- **Validation**: PASS

### Original Help Text
```text
usage: refgenie id [-h] [-c C] [--skip-read-lock] [-g G]
                   asset-registry-paths [asset-registry-paths ...]

Return the asset digest.

positional arguments:
  asset-registry-paths     One or more registry path strings that identify assets (e.g.
                           hg38/fasta or hg38/fasta:tag).

optional arguments:
  -h, --help               show this help message and exit
  -c C, --genome-config C  Path to local genome configuration file. Optional if REFGENIE
                           environment variable is set.
  --skip-read-lock         Whether the config file should not be locked for reading
  -g G, --genome G         Reference assembly ID, e.g. mm10.
```


## refgenie_subscribe

### Tool Description
Add a refgenieserver URL to the config.

### Metadata
- **Docker Image**: quay.io/biocontainers/refgenie:0.12.1--pyhdfd78af_0
- **Homepage**: http://refgenie.databio.org
- **Package**: https://anaconda.org/channels/bioconda/packages/refgenie/overview
- **Validation**: PASS

### Original Help Text
```text
usage: refgenie subscribe [-h] [-c C] [--skip-read-lock] [-r] -s S [S ...]

Add a refgenieserver URL to the config.

optional arguments:
  -h, --help                            show this help message and exit
  -c C, --genome-config C               Path to local genome configuration file. Optional
                                        if REFGENIE environment variable is set.
  --skip-read-lock                      Whether the config file should not be locked for
                                        reading
  -r, --reset                           Overwrite the current list of server URLs.
  -s S [S ...], --genome-server S [S ...]
                                        One or more URLs to add to the genome_servers
                                        attribute in config file.
```


## refgenie_unsubscribe

### Tool Description
Remove a refgenieserver URL from the config.

### Metadata
- **Docker Image**: quay.io/biocontainers/refgenie:0.12.1--pyhdfd78af_0
- **Homepage**: http://refgenie.databio.org
- **Package**: https://anaconda.org/channels/bioconda/packages/refgenie/overview
- **Validation**: PASS

### Original Help Text
```text
usage: refgenie unsubscribe [-h] [-c C] [--skip-read-lock] -s S [S ...]

Remove a refgenieserver URL from the config.

optional arguments:
  -h, --help                            show this help message and exit
  -c C, --genome-config C               Path to local genome configuration file. Optional
                                        if REFGENIE environment variable is set.
  --skip-read-lock                      Whether the config file should not be locked for
                                        reading
  -s S [S ...], --genome-server S [S ...]
                                        One or more URLs to remove from the genome_servers
                                        attribute in config file.
```


## refgenie_alias

### Tool Description
refgenie - reference genome asset manager

### Metadata
- **Docker Image**: quay.io/biocontainers/refgenie:0.12.1--pyhdfd78af_0
- **Homepage**: http://refgenie.databio.org
- **Package**: https://anaconda.org/channels/bioconda/packages/refgenie/overview
- **Validation**: PASS

### Original Help Text
```text
version: 0.12.1 | refgenconf 0.12.0
usage: refgenie [-h] [--version] [--silent] [--verbosity V] [--logdev]
                {init,list,listr,pull,build,seek,seekr,add,remove,getseq,tag,id,subscribe,unsubscribe,alias,compare,upgrade,populate,populater}
                ...

refgenie - reference genome asset manager

positional arguments:
  {init,list,listr,pull,build,seek,seekr,add,remove,getseq,tag,id,subscribe,unsubscribe,alias,compare,upgrade,populate,populater}
    init                Initialize a genome configuration.
    list                List available local assets.
    listr               List available remote assets.
    pull                Download assets.
    build               Build genome assets.
    seek                Get the path to a local asset.
    seekr               Get the path to a remote asset.
    add                 Add local asset to the config file.
    remove              Remove a local asset.
    getseq              Get sequences from a genome.
    tag                 Tag an asset.
    id                  Return the asset digest.
    subscribe           Add a refgenieserver URL to the config.
    unsubscribe         Remove a refgenieserver URL from the config.
    alias               Interact with aliases.
    compare             Compare two genomes.
    upgrade             Upgrade config. This will alter the files on disk.
    populate            Populate registry paths with local paths.
    populater           Populate registry paths with remote paths.

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --silent              Silence logging. Overrides verbosity.
  --verbosity V         Set logging level (1-5 or logging module level name)
  --logdev              Expand content of logging message format.

https://refgenie.databio.org
```


## refgenie_compare

### Tool Description
Compare two genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/refgenie:0.12.1--pyhdfd78af_0
- **Homepage**: http://refgenie.databio.org
- **Package**: https://anaconda.org/channels/bioconda/packages/refgenie/overview
- **Validation**: PASS

### Original Help Text
```text
usage: refgenie compare [-h] [-c C] [--skip-read-lock] [-e] [-f] GENOME1 GENOME2

Compare two genomes.

positional arguments:
  GENOME1                  First genome for compatibility check.
  GENOME2                  Second genome for compatibility check.

optional arguments:
  -h, --help               show this help message and exit
  -c C, --genome-config C  Path to local genome configuration file. Optional if REFGENIE
                           environment variable is set.
  --skip-read-lock         Whether the config file should not be locked for reading
  -e, --no-explanation     Do not print compatibility code explanation.
  -f, --flag-meanings      Display compatibility flag meanings.
```


## refgenie_upgrade

### Tool Description
Upgrade config. This will alter the files on disk.

### Metadata
- **Docker Image**: quay.io/biocontainers/refgenie:0.12.1--pyhdfd78af_0
- **Homepage**: http://refgenie.databio.org
- **Package**: https://anaconda.org/channels/bioconda/packages/refgenie/overview
- **Validation**: PASS

### Original Help Text
```text
usage: refgenie upgrade [-h] [-c C] [--skip-read-lock] -v V [-f]

Upgrade config. This will alter the files on disk.

optional arguments:
  -h, --help                show this help message and exit
  -c C, --genome-config C   Path to local genome configuration file. Optional if REFGENIE
                            environment variable is set.
  --skip-read-lock          Whether the config file should not be locked for reading
  -v V, --target-version V  Target config version for the upgrade.
  -f, --force               Do not prompt before action, approve upfront.
```


## refgenie_populate

### Tool Description
Populate registry paths with local paths.

### Metadata
- **Docker Image**: quay.io/biocontainers/refgenie:0.12.1--pyhdfd78af_0
- **Homepage**: http://refgenie.databio.org
- **Package**: https://anaconda.org/channels/bioconda/packages/refgenie/overview
- **Validation**: PASS

### Original Help Text
```text
usage: refgenie populate [-h] [-c C] [--skip-read-lock] [-f F]

Populate registry paths with local paths.

optional arguments:
  -h, --help               show this help message and exit
  -c C, --genome-config C  Path to local genome configuration file. Optional if REFGENIE
                           environment variable is set.
  --skip-read-lock         Whether the config file should not be locked for reading
  -f F, --file F           File with registry paths to populate
```


## refgenie_populater

### Tool Description
Populate registry paths with remote paths.

### Metadata
- **Docker Image**: quay.io/biocontainers/refgenie:0.12.1--pyhdfd78af_0
- **Homepage**: http://refgenie.databio.org
- **Package**: https://anaconda.org/channels/bioconda/packages/refgenie/overview
- **Validation**: PASS

### Original Help Text
```text
usage: refgenie populater [-h] [-c C] [--skip-read-lock] [-s S [S ...]] [-p]
                          [--remote-class RC] [-f F]

Populate registry paths with remote paths.

optional arguments:
  -h, --help                            show this help message and exit
  -c C, --genome-config C               Path to local genome configuration file. Optional
                                        if REFGENIE environment variable is set.
  --skip-read-lock                      Whether the config file should not be locked for
                                        reading
  -s S [S ...], --genome-server S [S ...]
                                        One or more URLs to use. This information will not
                                        persist in the genome config file.
  -p, --append-server                   Whether the provided servers should be appended to
                                        the list.
  --remote-class RC                     Remote data provider class, e.g. 'http' or 's3'
  -f F, --file F                        File with registry paths to populate
```


## Metadata
- **Skill**: generated
