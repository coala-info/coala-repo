# spacerextractor CWL Generation Report

## spacerextractor_download_database

### Tool Description
extract spacers from metagenomic reads using a database of known repeats

### Metadata
- **Docker Image**: quay.io/biocontainers/spacerextractor:0.9.8--pyhdfd78af_0
- **Homepage**: https://code.jgi.doe.gov/SRoux/spacerextractor
- **Package**: https://anaconda.org/channels/bioconda/packages/spacerextractor/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/spacerextractor/overview
- **Total Downloads**: 352
- **Last updated**: 2025-12-30
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage: spacerextractor download_database [OPTIONS]                             
                                                                                
 extract spacers from metagenomic reads using a database of known repeats       
 see --help for full list of options                                            
                                                                                
╭─ Main parameters ────────────────────────────────────────────────────────────╮
│ *  --out_dir    -o  DIRECTORY  Path to the repeat database folder, needs to  │
│                                exist (default: ./) [required]                │
│    --n_threads  -t  INTEGER    number of threads to use [default: 2]         │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --bbtools_memory  -bmem  TEXT  memory allocated to bbtools [default: 20g]    │
│ --debug                        Run in a more verbose mode for debugging /    │
│                                troubleshooting purposes (warning:            │
│                                spacerextractor becomes quite chatty in this  │
│                                mode..)                                       │
│ --quiet                        Run in a very quiet mode, will only show      │
│                                error/critical messages                       │
│ --force_rerun     -fr          If you want to force SpacerExtractor to       │
│                                recompute all the steps                       │
│ --help                         Show this message and exit.                   │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## spacerextractor_extract_spacers

### Tool Description
extract spacers from metagenomic reads using a database of known repeats

### Metadata
- **Docker Image**: quay.io/biocontainers/spacerextractor:0.9.8--pyhdfd78af_0
- **Homepage**: https://code.jgi.doe.gov/SRoux/spacerextractor
- **Package**: https://anaconda.org/channels/bioconda/packages/spacerextractor/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: spacerextractor extract_spacers [OPTIONS]                               
                                                                                
 extract spacers from metagenomic reads using a database of known repeats       
 see --help for full list of options                                            
                                                                                
╭─ Main parameters ────────────────────────────────────────────────────────────╮
│ *  --repeat_db_dir   -d    DIRECTORY  Path to the repeat database folder     │
│                                       [required]                             │
│ *  --input_fastq     -f    FILE       Fastq file of the reads to be mined    │
│                                       (can be gzipped) [required]            │
│    --input_fastq_r2  -fr2  FILE       Fastq file of the R2 reads, if the     │
│                                       reads come as R1 and R2 file           │
│ *  --out_dir         -o    DIRECTORY  Output directory (will be created if   │
│                                       it does not exist) [required]          │
│    --n_threads       -t    INTEGER    number of threads to use [default: 2]  │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Advanced parameters ────────────────────────────────────────────────────────╮
│ --no_trim  -nt           To bypass the quality-based trimming (e.g. for SRA  │
│                          data without quality information) - note that this  │
│                          will also bypass the attempt at merging reads       │
│ --min_len  -ml  INTEGER  To change the default cutoff on minimum read length │
│                          (default: 90) - Note: SpacerExtractor has only been │
│                          tested with reads 90bp and longer, so lowering this │
│                          cutoff should be considered experimental !!         │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --bbtools_memory  -bmem  TEXT  memory allocated to bbtools [default: 20g]    │
│ --debug                        Run in a more verbose mode for debugging /    │
│                                troubleshooting purposes (warning:            │
│                                spacerextractor becomes quite chatty in this  │
│                                mode..)                                       │
│ --quiet                        Run in a very quiet mode, will only show      │
│                                error/critical messages                       │
│ --force_rerun     -fr          If you want to force SpacerExtractor to       │
│                                recompute all the steps                       │
│ --help                         Show this message and exit.                   │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## spacerextractor_filter_hq_spacers

### Tool Description
filter results of 'extract_spacers' to only retain high-quality spacers

### Metadata
- **Docker Image**: quay.io/biocontainers/spacerextractor:0.9.8--pyhdfd78af_0
- **Homepage**: https://code.jgi.doe.gov/SRoux/spacerextractor
- **Package**: https://anaconda.org/channels/bioconda/packages/spacerextractor/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: spacerextractor filter_hq_spacers [OPTIONS]                             
                                                                                
 filter results of 'extract_spacers' to only retain high-quality spacers        
                                                                                
╭─ Main parameters ────────────────────────────────────────────────────────────╮
│ *  --repeat_db_dir  -d  DIRECTORY  Path to the repeat database folder        │
│                                    [required]                                │
│ *  --wdir           -w  DIRECTORY  Output directory from extract_spacers     │
│                                    (needs to exist) [required]               │
│    --min_n_spacers  -m  INTEGER    To change the default cutoff on minimum   │
│                                    number of distinct spacers required for   │
│                                    an array to be retained (default: 5) -    │
│                                    Note: SpacerExtractor has mostly been     │
│                                    tested with this default parameter of 5,  │
│                                    so lowering this cutoff should be         │
│                                    considered experimental !!                │
│    --n_threads      -t  INTEGER    number of threads to use [default: 2]     │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Advanced denoising options (ONLY USE WITH CAUTION) ─────────────────────────╮
│ --denoising_strict                    Run a more aggressive denoising, will  │
│                                       remove more singletons linked to       │
│                                       sequencing errors but also more rare   │
│                                       spacers mistakenly considered as       │
│                                       sequencing errors (set expected error  │
│                                       rate at 0.005)                         │
│ --denoising_very_strict               Run an even more aggressive denoising, │
│                                       will remove more singletons linked to  │
│                                       sequencing errors but also more rare   │
│                                       spacers mistakenly considered as       │
│                                       sequencing errors (set expected error  │
│                                       rate at 0.01)                          │
│ --custom_err_rate        -cer  FLOAT  To change the default sequencing error │
│                                       rate, used in the denoising process of │
│                                       repeats and spacer. Since the          │
│                                       denoising stat is based on a Poisson   │
│                                       law, this error rate should be low (<  │
│                                       0.1) - Note: This parameter should     │
│                                       only be changed if you have specific   │
│                                       information on the expected error rate │
│                                       of the sequencing run processed. If    │
│                                       not, the default value should work for │
│                                       most modern Illumina sequencing        │
│                                       technology, and the denoising can be   │
│                                       made more aggressive with the flags    │
│                                       'denoising_strict' and                 │
│                                       'denoising_very_strict', which should  │
│                                       be preferred to a custom error rate    │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --bbtools_memory  -bmem  TEXT  memory allocated to bbtools [default: 20g]    │
│ --debug                        Run in a more verbose mode for debugging /    │
│                                troubleshooting purposes (warning:            │
│                                spacerextractor becomes quite chatty in this  │
│                                mode..)                                       │
│ --quiet                        Run in a very quiet mode, will only show      │
│                                error/critical messages                       │
│ --force_rerun     -fr          If you want to force SpacerExtractor to       │
│                                recompute all the steps                       │
│ --help                         Show this message and exit.                   │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## spacerextractor_run_cctyper

### Tool Description
run CRISPR-Cas typer on a (set of) new genomes to identify new CRISPR repeats

### Metadata
- **Docker Image**: quay.io/biocontainers/spacerextractor:0.9.8--pyhdfd78af_0
- **Homepage**: https://code.jgi.doe.gov/SRoux/spacerextractor
- **Package**: https://anaconda.org/channels/bioconda/packages/spacerextractor/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: spacerextractor run_cctyper [OPTIONS]                                   
                                                                                
 run CRISPR-Cas typer on a (set of) new genomes to identify new CRISPR repeats  
                                                                                
╭─ Main parameters ────────────────────────────────────────────────────────────╮
│ *  --input             -i  DIRECTORY  Path to the folder containing the      │
│                                       input genome(s) (one fasta file per    │
│                                       genome/MAG) [required]                 │
│ *  --wdir              -w  DIRECTORY  Output folder where CRISPRCas Typer    │
│                                       results will be stored (will be        │
│                                       created if it does not exist)          │
│                                       [required]                             │
│    --genome_id_prefix  -p             If you want to add the genome id as a  │
│                                       prefix to contig id (i.e. if your      │
│                                       contig ids are not already unique).    │
│    --n_threads         -t  INTEGER    number of threads to use [default: 2]  │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --bbtools_memory  -bmem  TEXT  memory allocated to bbtools [default: 20g]    │
│ --debug                        Run in a more verbose mode for debugging /    │
│                                troubleshooting purposes (warning:            │
│                                spacerextractor becomes quite chatty in this  │
│                                mode..)                                       │
│ --quiet                        Run in a very quiet mode, will only show      │
│                                error/critical messages                       │
│ --force_rerun     -fr          If you want to force SpacerExtractor to       │
│                                recompute all the steps                       │
│ --help                         Show this message and exit.                   │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## spacerextractor_build_database

### Tool Description
add new repeats identified by CRISPR-Cas typer to the repeat database

### Metadata
- **Docker Image**: quay.io/biocontainers/spacerextractor:0.9.8--pyhdfd78af_0
- **Homepage**: https://code.jgi.doe.gov/SRoux/spacerextractor
- **Package**: https://anaconda.org/channels/bioconda/packages/spacerextractor/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: spacerextractor build_database [OPTIONS]                                
                                                                                
 add new repeats identified by CRISPR-Cas typer to the repeat database          
                                                                                
╭─ Main parameters ────────────────────────────────────────────────────────────╮
│ *  --input_from_contigs  -c  FILE       A table file listing additional      │
│                                         CRISPR array obtained from contigs   │
│                                         of this dataset, in the format of    │
│                                         CRISPR Cas Typer output              │
│                                         crisprs_all.tab (see                 │
│                                         https://github.com/Russel88/CRISPRCa │
│                                         sTyper). This can be directly the    │
│                                         crisprs_all.tab output of CRISPR Cas │
│                                         Typer, or the output of              │
│                                         SE_run_cctyper.py (specifically      │
│                                         `all_refined_repeats.tab`), and will │
│                                         add additional 'local' CRISPR arrays │
│                                         to a new or existing database.       │
│                                         [required]                           │
│ *  --new_db_dir          -d  DIRECTORY  Path to the repeat database folder,  │
│                                         will be created or overwritten (with │
│                                         option fr) [required]                │
│    --ref_db_dir          -r  DIRECTORY  (Optional) Path to the original      │
│                                         repeat database folder, to which we  │
│                                         will be add the new repeats. If not  │
│                                         provided, then build_database will   │
│                                         try to add to the database path      │
│                                         provided with --new_db_dir (if it    │
│                                         already exists).                     │
│    --n_threads           -t  INTEGER    number of threads to use [default:   │
│                                         2]                                   │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --bbtools_memory  -bmem  TEXT  memory allocated to bbtools [default: 20g]    │
│ --debug                        Run in a more verbose mode for debugging /    │
│                                troubleshooting purposes (warning:            │
│                                spacerextractor becomes quite chatty in this  │
│                                mode..)                                       │
│ --quiet                        Run in a very quiet mode, will only show      │
│                                error/critical messages                       │
│ --force_rerun     -fr          If you want to force SpacerExtractor to       │
│                                recompute all the steps                       │
│ --help                         Show this message and exit.                   │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## spacerextractor_create_target_db

### Tool Description
create a database of potential targets to map spacers to from a fasta file

### Metadata
- **Docker Image**: quay.io/biocontainers/spacerextractor:0.9.8--pyhdfd78af_0
- **Homepage**: https://code.jgi.doe.gov/SRoux/spacerextractor
- **Package**: https://anaconda.org/channels/bioconda/packages/spacerextractor/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: spacerextractor create_target_db [OPTIONS]                              
                                                                                
 create a database of potential targets to map spacers to from a fasta file     
                                                                                
╭─ Main parameters ────────────────────────────────────────────────────────────╮
│ *  --in_file     -i  FILE       A fasta file of potential targets to map     │
│                                 spacers to. [required]                       │
│ *  --new_db_dir  -d  DIRECTORY  Path to the target database folder, will be  │
│                                 created or overwritten (with option fr)      │
│                                 [required]                                   │
│    --n_threads   -t  INTEGER    number of threads to use [default: 2]        │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Advanced parameters ────────────────────────────────────────────────────────╮
│ --replace_spaces  -s  To replace all spaces by underscore in sequence names  │
│                       (default: False)                                       │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --bbtools_memory  -bmem  TEXT  memory allocated to bbtools [default: 20g]    │
│ --debug                        Run in a more verbose mode for debugging /    │
│                                troubleshooting purposes (warning:            │
│                                spacerextractor becomes quite chatty in this  │
│                                mode..)                                       │
│ --quiet                        Run in a very quiet mode, will only show      │
│                                error/critical messages                       │
│ --force_rerun     -fr          If you want to force SpacerExtractor to       │
│                                recompute all the steps                       │
│ --help                         Show this message and exit.                   │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## spacerextractor_map_to_target

### Tool Description
map spacers to a database of potential targets

### Metadata
- **Docker Image**: quay.io/biocontainers/spacerextractor:0.9.8--pyhdfd78af_0
- **Homepage**: https://code.jgi.doe.gov/SRoux/spacerextractor
- **Package**: https://anaconda.org/channels/bioconda/packages/spacerextractor/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: spacerextractor map_to_target [OPTIONS]                                 
                                                                                
 map spacers to a database of potential targets                                 
                                                                                
╭─ Main parameters ────────────────────────────────────────────────────────────╮
│ *  --in_file    -i  FILE       A fasta file of spacers [required]            │
│ *  --db_dir     -d  DIRECTORY  Path to the target database folder that was   │
│                                generated with create_target_db [required]    │
│ *  --out_dir    -o  DIRECTORY  Path to the output folder where temp files    │
│                                and result file will be written [required]    │
│    --n_threads  -t  INTEGER    number of threads to use [default: 2]         │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --bbtools_memory  -bmem  TEXT  memory allocated to bbtools [default: 20g]    │
│ --debug                        Run in a more verbose mode for debugging /    │
│                                troubleshooting purposes (warning:            │
│                                spacerextractor becomes quite chatty in this  │
│                                mode..)                                       │
│ --quiet                        Run in a very quiet mode, will only show      │
│                                error/critical messages                       │
│ --force_rerun     -fr          If you want to force SpacerExtractor to       │
│                                recompute all the steps                       │
│ --help                         Show this message and exit.                   │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## Metadata
- **Skill**: not generated
