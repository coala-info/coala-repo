# mtsv CWL Generation Report

## mtsv_COMMAND

### Tool Description
mtsv: error: argument COMMAND: invalid choice: 'COMMAND' (choose from 'init', 'analyze', 'binning', 'readprep', 'summary', 'extract', 'pipeline')

### Metadata
- **Docker Image**: quay.io/biocontainers/mtsv:1.0.6--py36hf1ae8f4_2
- **Homepage**: https://github.com/FofanovLab/MTSv
- **Package**: https://anaconda.org/channels/bioconda/packages/mtsv/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mtsv/overview
- **Total Downloads**: 23.3K
- **Last updated**: 2025-09-18
- **GitHub**: https://github.com/FofanovLab/MTSv
- **Stars**: N/A
### Original Help Text
```text
usage: mtsv [-h] COMMAND ...
mtsv: error: argument COMMAND: invalid choice: 'COMMAND' (choose from 'init', 'analyze', 'binning', 'readprep', 'summary', 'extract', 'pipeline')
```


## mtsv_init

### Tool Description
Initialize mtsv project

### Metadata
- **Docker Image**: quay.io/biocontainers/mtsv:1.0.6--py36hf1ae8f4_2
- **Homepage**: https://github.com/FofanovLab/MTSv
- **Package**: https://anaconda.org/channels/bioconda/packages/mtsv/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mtsv init [-h] [-c CONFIG] [-wd WORKING_DIR]

optional arguments:
  -h, --help            show this help message and exit
  -c CONFIG, --config CONFIG
                        Specify path to write config file, not required if
                        using default config (Default: ./mtsv.cfg)
  -wd WORKING_DIR, --working_dir WORKING_DIR
                        Specify working directory to place output. (default:
                        /)
```


## mtsv_analyze

### Tool Description
Additional Snakemake commands may also be provided

### Metadata
- **Docker Image**: quay.io/biocontainers/mtsv:1.0.6--py36hf1ae8f4_2
- **Homepage**: https://github.com/FofanovLab/MTSv
- **Package**: https://anaconda.org/channels/bioconda/packages/mtsv/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mtsv analyze [-h] [--analysis_file ANALYSIS_FILE]
                    [--summary_file SUMMARY_FILE] [--n_kmers N_KMERS]
                    [--signature_cutoff SIGNATURE_CUTOFF]
                    [--can_taxa_list CAN_TAXA_LIST]
                    [--use_database USE_DATABASE] [--wd WD] [-c CONFIG]
                    [-lf LOG_FILE] [-t THREADS]

Additional Snakemake commands may also be provided

optional arguments:
  -h, --help            show this help message and exit
  --analysis_file ANALYSIS_FILE
                        File to write output. (default:
                        ./Analysis/analysis.csv)
  --summary_file SUMMARY_FILE
                        Path to summary output (default:
                        ./Summary/summary.csv)
  --n_kmers N_KMERS     Up to N_KMERS random kmers will be generated for each
                        of the candidate taxa. These will be used to estimate
                        expected values. (default: 100000)
  --signature_cutoff SIGNATURE_CUTOFF
                        Run analysis only for taxa with unique signature hits
                        that are greater than SIGNATURE_CUTOFF. (default: 20)
  --can_taxa_list CAN_TAXA_LIST
                        Provide a custom list of candidate taxa instead of
                        calculating candidates based SIGNATURE_CUTOFF of
                        unique signature hits. Should be a file with taxids
                        listed in a single column.
  --use_database USE_DATABASE
                        If (T)rue, use previously calculated expected values
                        where available. If (F)alse, all expected values will
                        be recalculated and used to update the database.
                        (default: T)
  --wd WD, -wd WD, --working_dir WD
                        Specify working directory to place output. (default:
                        /)
  -c CONFIG, --config CONFIG
                        Specify path to config file path, relative to working
                        directory, not required if using default config.
  -lf LOG_FILE, --log_file LOG_FILE
                        Set log file path, absolute or relative to working
                        dir. (default: ./Logs/mtsv_{COMMAND}_{TIMESTAMP}.log)
  -t THREADS, --threads THREADS
                        Number of worker threads to spawn. (default: 4)
```


## mtsv_binning

### Tool Description
Additional Snakemake commands may also be provided

### Metadata
- **Docker Image**: quay.io/biocontainers/mtsv:1.0.6--py36hf1ae8f4_2
- **Homepage**: https://github.com/FofanovLab/MTSv
- **Package**: https://anaconda.org/channels/bioconda/packages/mtsv/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mtsv binning [-h] [--binning_mode {fast,efficient,sensitive}]
                    [--fasta FASTA] [--database_config DATABASE_CONFIG]
                    [--binning_outpath BINNING_OUTPATH]
                    [--merge_file MERGE_FILE] [--edits EDITS]
                    [--seed_size SEED_SIZE] [--min_seeds MIN_SEEDS]
                    [--seed_gap SEED_GAP] [--wd WD] [-c CONFIG] [-lf LOG_FILE]
                    [-t THREADS]

Additional Snakemake commands may also be provided

optional arguments:
  -h, --help            show this help message and exit
  --binning_mode {fast,efficient,sensitive}
                        Set recommended parameters for SEED_SIZE, MIN_SEEDS,
                        SEED_GAP for fast (more misses, fast runtime),
                        efficient (med misses, med runtime) or sensitive (few
                        misses, slow) runs. fast=17,5,2, efficient=14,4,2,
                        sensitive=11,3,1. Passing values for the SEED_SIZE,
                        MIN_SEEDS or SEED_GAP parameters will override these
                        settings. Choices are ['fast', 'efficient',
                        'sensitive'] (default: efficient)
  --fasta FASTA         Path to FASTA query file produced by readprep.
                        (default: ./QueryFastas/queries.fasta)
  --database_config DATABASE_CONFIG
                        Path to sequence database configuration json.
  --binning_outpath BINNING_OUTPATH
                        Path to write binning files to. (default: ./Binning/)
  --merge_file MERGE_FILE
                        Merged binning output file. (WARNING avoid moving
                        output files from their original directory, downstream
                        processes rely on meta data (.params file) in
                        directory) (default: ./Binning/merged.clp)
  --edits EDITS         Edit distance to tolerate in matched reference sites
                        (default: 3)
  --seed_size SEED_SIZE
                        Exact match query size. Overrides binning mode
                        setting.
  --min_seeds MIN_SEEDS
                        Minimum number of seeds to perform alignment of a
                        candidate site. Overrides binning mode setting.
  --seed_gap SEED_GAP   Gap between seeds used for initial exact match.
                        Overrides binning mode setting.
  --wd WD, -wd WD, --working_dir WD
                        Specify working directory to place output. (default:
                        /)
  -c CONFIG, --config CONFIG
                        Specify path to config file path, relative to working
                        directory, not required if using default config.
  -lf LOG_FILE, --log_file LOG_FILE
                        Set log file path, absolute or relative to working
                        dir. (default: ./Logs/mtsv_{COMMAND}_{TIMESTAMP}.log)
  -t THREADS, --threads THREADS
                        Number of worker threads to spawn. (default: 4)
```


## mtsv_readprep

### Tool Description
Additional Snakemake commands may also be provided

### Metadata
- **Docker Image**: quay.io/biocontainers/mtsv:1.0.6--py36hf1ae8f4_2
- **Homepage**: https://github.com/FofanovLab/MTSv
- **Package**: https://anaconda.org/channels/bioconda/packages/mtsv/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mtsv readprep [-h] --fastq FASTQ [FASTQ ...] [--fasta FASTA]
                     [--trim_mode {lcd,segment}] [--kmer KMER] [--wd WD]
                     [-c CONFIG] [-lf LOG_FILE] [-t THREADS]

Additional Snakemake commands may also be provided

optional arguments:
  -h, --help            show this help message and exit
  --fastq FASTQ [FASTQ ...]
                        Path(s) to FASTQ files to deduplicate, absolute path
                        or relative to working dir. [REQUIRED]
  --fasta FASTA         Path to FASTA query file produced by readprep. Avoid
                        moving or renaming this file after it is made,
                        required metadata is stored with this file. (default:
                        ./QueryFastas/queries.fasta)
  --trim_mode {lcd,segment}
                        --lcd takes first N bases of each read, where N =
                        shortest read length in FASTQ --segment takes
                        subsequent N length sequences of each read (set N with
                        --kmer) Choices are ['lcd', 'segment'] (default:
                        segment)
  --kmer KMER           Set size of each read segment for segment trim mode.
                        (default: 50)
  --wd WD, -wd WD, --working_dir WD
                        Specify working directory to place output. (default:
                        /)
  -c CONFIG, --config CONFIG
                        Specify path to config file path, relative to working
                        directory, not required if using default config.
  -lf LOG_FILE, --log_file LOG_FILE
                        Set log file path, absolute or relative to working
                        dir. (default: ./Logs/mtsv_{COMMAND}_{TIMESTAMP}.log)
  -t THREADS, --threads THREADS
                        Number of worker threads to spawn. (default: 4)
```


## mtsv_coming

### Tool Description
mtsv: error: argument COMMAND: invalid choice: 'coming' (choose from 'init', 'analyze', 'binning', 'readprep', 'summary', 'extract', 'pipeline')

### Metadata
- **Docker Image**: quay.io/biocontainers/mtsv:1.0.6--py36hf1ae8f4_2
- **Homepage**: https://github.com/FofanovLab/MTSv
- **Package**: https://anaconda.org/channels/bioconda/packages/mtsv/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mtsv [-h] COMMAND ...
mtsv: error: argument COMMAND: invalid choice: 'coming' (choose from 'init', 'analyze', 'binning', 'readprep', 'summary', 'extract', 'pipeline')
```


## mtsv_summary

### Tool Description
Additional Snakemake commands may also be provided

### Metadata
- **Docker Image**: quay.io/biocontainers/mtsv:1.0.6--py36hf1ae8f4_2
- **Homepage**: https://github.com/FofanovLab/MTSv
- **Package**: https://anaconda.org/channels/bioconda/packages/mtsv/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mtsv summary [-h] [--merge_file MERGE_FILE]
                    [--signature_file SIGNATURE_FILE]
                    [--summary_file SUMMARY_FILE]
                    [--tax_level {family,genus,species}] [--wd WD] [-c CONFIG]
                    [-lf LOG_FILE] [-t THREADS]

Additional Snakemake commands may also be provided

optional arguments:
  -h, --help            show this help message and exit
  --merge_file MERGE_FILE
                        Merged binning output file. (default:
                        ./Binning/merged.clp)
  --signature_file SIGNATURE_FILE
                        File to place signature hits output. (default:
                        ./Summary/signature.txt)
  --summary_file SUMMARY_FILE
                        File to place summary table. WARNING avoid moving
                        output files from original directory, downstream
                        processes rely on metadata (.params file) stored in
                        directory. (default: ./Summary/summary.csv)
  --tax_level {family,genus,species}
                        Roll up read hits to a common genus or family level
                        when searching for signature hits. (Takes priority
                        over LCA search when family or genus exist for a
                        taxonomic ID.) More roll up options comming soon.
                        Choices are ['family', 'genus', 'species'] (default:
                        species)
  --wd WD, -wd WD, --working_dir WD
                        Specify working directory to place output. (default:
                        /)
  -c CONFIG, --config CONFIG
                        Specify path to config file path, relative to working
                        directory, not required if using default config.
  -lf LOG_FILE, --log_file LOG_FILE
                        Set log file path, absolute or relative to working
                        dir. (default: ./Logs/mtsv_{COMMAND}_{TIMESTAMP}.log)
  -t THREADS, --threads THREADS
                        Number of worker threads to spawn. (default: 4)
```


## mtsv_extract

### Tool Description
Extracts reads based on taxonomic IDs and other criteria.

### Metadata
- **Docker Image**: quay.io/biocontainers/mtsv:1.0.6--py36hf1ae8f4_2
- **Homepage**: https://github.com/FofanovLab/MTSv
- **Package**: https://anaconda.org/channels/bioconda/packages/mtsv/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mtsv extract [-h] [--extract_path EXTRACT_PATH] --taxids TAXIDS
                    [TAXIDS ...] [--input_hits INPUT_HITS]
                    [--by_sample BY_SAMPLE] [--descendants DESCENDANTS]
                    [--wd WD] [-c CONFIG] [-lf LOG_FILE] [-t THREADS]

Additional Snakemake commands may also be provided

optional arguments:
  -h, --help            show this help message and exit
  --extract_path EXTRACT_PATH
                        Directory to place extracted reads. (default:
                        ./Extracted_Reads/)
  --taxids TAXIDS [TAXIDS ...]
                        List of species to extract. (Space separated).
                        [REQUIRED]
  --input_hits INPUT_HITS
                        Path to either merged binning output or signature hits
                        file. The merged file should be passed if all query
                        hits should be extracted and the signature hits file
                        should be passed if only signature queries are
                        desired.
  --by_sample BY_SAMPLE
                        Breakdown extracted queries by sample. (default: T)
  --descendants DESCENDANTS
                        Include all descendant taxa in extracted queries.
                        Queries may be extracted before roll up, so by
                        default, descendant taxa will be included in search if
                        a higher level taxid is provided. If False (F), only
                        exact matches to taxid will be returned. (default: T)
  --wd WD, -wd WD, --working_dir WD
                        Specify working directory to place output. (default:
                        /)
  -c CONFIG, --config CONFIG
                        Specify path to config file path, relative to working
                        directory, not required if using default config.
  -lf LOG_FILE, --log_file LOG_FILE
                        Set log file path, absolute or relative to working
                        dir. (default: ./Logs/mtsv_{COMMAND}_{TIMESTAMP}.log)
  -t THREADS, --threads THREADS
                        Number of worker threads to spawn. (default: 4)
```


## mtsv_pipeline

### Tool Description
Additional Snakemake commands may also be provided

### Metadata
- **Docker Image**: quay.io/biocontainers/mtsv:1.0.6--py36hf1ae8f4_2
- **Homepage**: https://github.com/FofanovLab/MTSv
- **Package**: https://anaconda.org/channels/bioconda/packages/mtsv/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mtsv pipeline [-h] --fastq FASTQ [FASTQ ...] [--fasta FASTA]
                     [--trim_mode {lcd,segment}] [--kmer KMER]
                     [--binning_mode {fast,efficient,sensitive}]
                     [--database_config DATABASE_CONFIG]
                     [--binning_outpath BINNING_OUTPATH]
                     [--merge_file MERGE_FILE] [--edits EDITS]
                     [--seed_size SEED_SIZE] [--min_seeds MIN_SEEDS]
                     [--seed_gap SEED_GAP] [--signature_file SIGNATURE_FILE]
                     [--summary_file SUMMARY_FILE]
                     [--tax_level {family,genus,species}] [--wd WD]
                     [-c CONFIG] [-lf LOG_FILE] [-t THREADS]

Additional Snakemake commands may also be provided

optional arguments:
  -h, --help            show this help message and exit
  --fastq FASTQ [FASTQ ...]
                        Path(s) to FASTQ files to deduplicate, absolute path
                        or relative to working dir. [REQUIRED]
  --fasta FASTA         Path to FASTA query file produced by readprep. Avoid
                        moving or renaming this file after it is made,
                        required metadata is stored with this file. (default:
                        ./QueryFastas/queries.fasta)
  --trim_mode {lcd,segment}
                        --lcd takes first N bases of each read, where N =
                        shortest read length in FASTQ --segment takes
                        subsequent N length sequences of each read (set N with
                        --kmer) Choices are ['lcd', 'segment'] (default:
                        segment)
  --kmer KMER           Set size of each read segment for segment trim mode.
                        (default: 50)
  --binning_mode {fast,efficient,sensitive}
                        Set recommended parameters for SEED_SIZE, MIN_SEEDS,
                        SEED_GAP for fast (more misses, fast runtime),
                        efficient (med misses, med runtime) or sensitive (few
                        misses, slow) runs. fast=17,5,2, efficient=14,4,2,
                        sensitive=11,3,1. Passing values for the SEED_SIZE,
                        MIN_SEEDS or SEED_GAP parameters will override these
                        settings. Choices are ['fast', 'efficient',
                        'sensitive'] (default: efficient)
  --database_config DATABASE_CONFIG
                        Path to sequence database configuration json.
  --binning_outpath BINNING_OUTPATH
                        Path to write binning files to. (default: ./Binning/)
  --merge_file MERGE_FILE
                        Merged binning output file. (WARNING avoid moving
                        output files from their original directory, downstream
                        processes rely on meta data (.params file) in
                        directory) (default: ./Binning/merged.clp)
  --edits EDITS         Edit distance to tolerate in matched reference sites
                        (default: 3)
  --seed_size SEED_SIZE
                        Exact match query size. Overrides binning mode
                        setting.
  --min_seeds MIN_SEEDS
                        Minimum number of seeds to perform alignment of a
                        candidate site. Overrides binning mode setting.
  --seed_gap SEED_GAP   Gap between seeds used for initial exact match.
                        Overrides binning mode setting.
  --signature_file SIGNATURE_FILE
                        File to place signature hits output. (default:
                        ./Summary/signature.txt)
  --summary_file SUMMARY_FILE
                        File to place summary table. WARNING avoid moving
                        output files from original directory, downstream
                        processes rely on metadata (.params file) stored in
                        directory. (default: ./Summary/summary.csv)
  --tax_level {family,genus,species}
                        Roll up read hits to a common genus or family level
                        when searching for signature hits. (Takes priority
                        over LCA search when family or genus exist for a
                        taxonomic ID.) More roll up options comming soon.
                        Choices are ['family', 'genus', 'species'] (default:
                        species)
  --wd WD, -wd WD, --working_dir WD
                        Specify working directory to place output. (default:
                        /)
  -c CONFIG, --config CONFIG
                        Specify path to config file path, relative to working
                        directory, not required if using default config.
  -lf LOG_FILE, --log_file LOG_FILE
                        Set log file path, absolute or relative to working
                        dir. (default: ./Logs/mtsv_{COMMAND}_{TIMESTAMP}.log)
  -t THREADS, --threads THREADS
                        Number of worker threads to spawn. (default: 4)
```


## Metadata
- **Skill**: generated
