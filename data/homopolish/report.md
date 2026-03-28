# homopolish CWL Generation Report

## homopolish_polish

### Tool Description
Homopolish is a tool for polishing genome assemblies using homologous sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/homopolish:0.4.2--pyhdfd78af_0
- **Homepage**: https://github.com/ythuang0522/homopolish
- **Package**: https://anaconda.org/channels/bioconda/packages/homopolish/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/homopolish/overview
- **Total Downloads**: 12.9K
- **Last updated**: 2025-08-15
- **GitHub**: https://github.com/ythuang0522/homopolish
- **Stars**: N/A
### Original Help Text
```text
ArgumentParser(prog='homopolish polish', usage=None, description=None, formatter_class=<class 'argparse.HelpFormatter'>, conflict_handler='error', add_help=True)
usage: homopolish polish [-h] -m MODEL_PATH -a ASSEMBLY
                         (-s SKETCH_PATH | -g GENUS | -l LOCAL_DB_PATH)
                         [-t THREADS] [-o OUTPUT_DIR]
                         [--minimap_args MINIMAP_ARGS]
                         [--mash_threshold MASH_THRESHOLD]
                         [--download_contig_nums DOWNLOAD_CONTIG_NUMS] [-d]
                         [--mash_screen] [--meta] [--ani ANI]
                         [--distance DISTANCE]

options:
  -h, --help            show this help message and exit
  -m MODEL_PATH, --model_path MODEL_PATH
                        [REQUIRED] Path to a trained model (pkl file). Please
                        see our github page to see options.
  -a ASSEMBLY, --assembly ASSEMBLY
                        [REQUIRED] Path to a assembly genome.
  -s SKETCH_PATH, --sketch_path SKETCH_PATH
                        Path to a mash sketch file.
  -g GENUS, --genus GENUS
                        Genus name
  -l LOCAL_DB_PATH, --local_DB_path LOCAL_DB_PATH
                        Path to your local DB
  -t THREADS, --threads THREADS
                        Number of threads to use. [1]
  -o OUTPUT_DIR, --output_dir OUTPUT_DIR
                        Path to the output directory. [output]
  --minimap_args MINIMAP_ARGS
                        Minimap2 -x argument. [asm5]
  --mash_threshold MASH_THRESHOLD
                        Mash output threshold. [0.95]
  --download_contig_nums DOWNLOAD_CONTIG_NUMS
                        How much contig to download from NCBI. [20]
  -d, --debug           Keep the information of every contig after mash, such
                        as homologous sequences and its identity infomation.
                        [no]
  --mash_screen         Use mash screen. [mash dist]
  --meta                Your assembly genome is metagenome. [no]
  --ani ANI             ani identity [99]
  --distance DISTANCE   Difference of structure (counted by ani). [5]
```


## homopolish_train

### Tool Description
Train a model for homopolish using alignment dataframes.

### Metadata
- **Docker Image**: quay.io/biocontainers/homopolish:0.4.2--pyhdfd78af_0
- **Homepage**: https://github.com/ythuang0522/homopolish
- **Package**: https://anaconda.org/channels/bioconda/packages/homopolish/overview
- **Validation**: PASS

### Original Help Text
```text
ArgumentParser(prog='homopolish polish', usage=None, description=None, formatter_class=<class 'argparse.HelpFormatter'>, conflict_handler='error', add_help=True)
usage: homopolish train [-h] -d DATAFRAME_DIR [-o OUTPUT_DIR]
                        [-p OUTPUT_PREFIX] [-t THREADS] [--pacbio]

options:
  -h, --help            show this help message and exit
  -d DATAFRAME_DIR, --dataframe_dir DATAFRAME_DIR
                        [REQUIRED] Path to a directory for alignment
                        dataframe.
  -o OUTPUT_DIR, --output_dir OUTPUT_DIR
                        Path to the output directory. [output]
  -p OUTPUT_PREFIX, --output_prefix OUTPUT_PREFIX
                        Prefix for the train model. [train]
  -t THREADS, --threads THREADS
                        Number of threads to use. [1]
  --pacbio              Your train data is Pacbio. [no]
```


## homopolish_make_train_data

### Tool Description
Make training data for homopolish by aligning reference genomes to assembly genomes and downloading homologous sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/homopolish:0.4.2--pyhdfd78af_0
- **Homepage**: https://github.com/ythuang0522/homopolish
- **Package**: https://anaconda.org/channels/bioconda/packages/homopolish/overview
- **Validation**: PASS

### Original Help Text
```text
ArgumentParser(prog='homopolish polish', usage=None, description=None, formatter_class=<class 'argparse.HelpFormatter'>, conflict_handler='error', add_help=True)
usage: homopolish make_train_data [-h] -r REFERENCE -a ASSEMBLY
                                  (-s SKETCH_PATH | -g GENUS | -l LOCAL_DB_PATH)
                                  [-t THREADS] [-o OUTPUT_DIR]
                                  [--minimap_args MINIMAP_ARGS]
                                  [--mash_threshold MASH_THRESHOLD]
                                  [--download_contig_nums DOWNLOAD_CONTIG_NUMS]
                                  [-d] [--mash_screen] [--meta] [--ani ANI]
                                  [--distance DISTANCE]

options:
  -h, --help            show this help message and exit
  -r REFERENCE, --reference REFERENCE
                        [REQUIRED] True reference aligned to assembly genome.
                        Include labels in output.
  -a ASSEMBLY, --assembly ASSEMBLY
                        [REQUIRED] Path to a assembly genome.
  -s SKETCH_PATH, --sketch_path SKETCH_PATH
                        Path to a mash sketch file.
  -g GENUS, --genus GENUS
                        Genus name
  -l LOCAL_DB_PATH, --local_DB_path LOCAL_DB_PATH
                        Path to your local DB
  -t THREADS, --threads THREADS
                        Number of threads to use. [1]
  -o OUTPUT_DIR, --output_dir OUTPUT_DIR
                        Path to the output directory. [output]
  --minimap_args MINIMAP_ARGS
                        Minimap2 -x argument. [asm5]
  --mash_threshold MASH_THRESHOLD
                        Mash output threshold. [0.95]
  --download_contig_nums DOWNLOAD_CONTIG_NUMS
                        How much contig to download from NCBI. [20]
  -d, --debug           Keep the information of every contig after mash, such
                        as homologous sequences and its identity infomation.
                        [no]
  --mash_screen         Use mash screen. [mash dist]
  --meta                Your assembly genome is metagenome. [no]
  --ani ANI             ani identity [99]
  --distance DISTANCE   Difference of structure (counted by ani). [5]
```


## homopolish_modpolish

### Tool Description
A tool for polishing genome assemblies using mash sketches and local databases.

### Metadata
- **Docker Image**: quay.io/biocontainers/homopolish:0.4.2--pyhdfd78af_0
- **Homepage**: https://github.com/ythuang0522/homopolish
- **Package**: https://anaconda.org/channels/bioconda/packages/homopolish/overview
- **Validation**: PASS

### Original Help Text
```text
ArgumentParser(prog='homopolish polish', usage=None, description=None, formatter_class=<class 'argparse.HelpFormatter'>, conflict_handler='error', add_help=True)
usage: homopolish modpolish [-h] -a FASTA [-q FASTQ] [-b BAM] [-o OUTPUT_DIR]
                            -s SKETCH_PATH [-p PATTERN] [-d] [-t THREADS]
                            [-l LOCAL_DB_PATH [LOCAL_DB_PATH ...]] [--ani ANI]
                            [--distance DISTANCE]

options:
  -h, --help            show this help message and exit
  -a FASTA, --fasta FASTA
                        fasta file
  -q FASTQ, --fastq FASTQ
                        fastq file
  -b BAM, --bam BAM     bam file
  -o OUTPUT_DIR, --output_dir OUTPUT_DIR
                        OUTPUT_DIR
  -s SKETCH_PATH, --sketch_path SKETCH_PATH
                        Path to a mash sketch file.
  -p PATTERN, --pattern PATTERN
                        special pattern
  -d, --debug           Keep the information . [no]
  -t THREADS, --threads THREADS
                        Number of threads to use. [1]
  -l LOCAL_DB_PATH [LOCAL_DB_PATH ...], --local_DB_path LOCAL_DB_PATH [LOCAL_DB_PATH ...]
                        Path to your local DB
  --ani ANI             Ani identity [99]
  --distance DISTANCE   Difference of structure (counted by ani). [5]
```


## Metadata
- **Skill**: generated
