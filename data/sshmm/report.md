# sshmm CWL Generation Report

## sshmm_preprocess_dataset

### Tool Description
Pipeline for the preparation of a CLIP-Seq dataset in BED format. The pipeline consists of the following steps:
1 - Filter BED file
2 - Elongate BED file for later structure prediction
3 - Fetch genomic sequences for elongated BED file
4 - Produce FASTA file with genomic sequences in viewpoint format
5 - Secondary structure prediction with RNAshapes
6 - Secondary structure prediction with RNAstructures

### Metadata
- **Docker Image**: quay.io/biocontainers/sshmm:1.0.7--py27_0
- **Homepage**: https://github.molgen.mpg.de/heller/ssHMM
- **Package**: https://anaconda.org/channels/bioconda/packages/sshmm/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sshmm/overview
- **Total Downloads**: 6.6K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: preprocess_dataset [-h] [--disable_filtering] [--disable_RNAshapes]
                          [--disable_RNAstructure] [--generate_negative]
                          [--min_score MIN_SCORE] [--min_length MIN_LENGTH]
                          [--max_length MAX_LENGTH] [--elongation ELONGATION]
                          [--genome_genes GENOME_GENES] [--skip_check]
                          working_dir dataset_name input genome genome_sizes

Pipeline for the preparation of a CLIP-Seq dataset in BED format. The pipeline consists of the following steps:
1 - Filter BED file
2 - Elongate BED file for later structure prediction
3 - Fetch genomic sequences for elongated BED file
4 - Produce FASTA file with genomic sequences in viewpoint format
5 - Secondary structure prediction with RNAshapes
6 - Secondary structure prediction with RNAstructures

DEPENDENCIES: This script requires bedtools (shuffle, slop, getfasta), RNAshapes, and RNAstructures.

A working directory and a dataset name (e.g., the protein name) have to be given. The output files can be found in:
- <workingdir>/fasta/<dataset_name>/positive.fasta - genomic sequences in viewpoint format
- <workingdir>/shapes/<dataset_name>/positive.txt - secondary structures of genomic sequence (predicted by RNAshapes)
- <workingdir>/structures/<dataset_name>/positive.txt - secondary structures of genomic sequence (predicted by RNAstructures)

For classification, a negative set of binding sites with shuffled coordinates can be generated with the --generate_negative option.
For this option, gene boundaries are required and need to be given as --genome_genes. They can be downloaded e.g. from the UCSC table 
browser (http://genome.ucsc.edu/cgi-bin/hgTables). Choose the most recent GENCODE track (currently GENCODE Gene V24lift37->Basic (for hg19) 
and All GENCODE V24->Basic (for hg38)) and 'BED' as output format.

positional arguments:
  working_dir           working/output directory
  dataset_name          dataset name
  input                 input file in .bed format
  genome                reference genome in FASTA format
  genome_sizes          chromosome sizes of reference genome (e.g. from http:/
                        /hgdownload.soe.ucsc.edu/goldenPath/hg19/bigZips/hg19.
                        chrom.sizes)

optional arguments:
  -h, --help            show this help message and exit
  --disable_filtering, -f
                        skip the filtering step
  --disable_RNAshapes   skip secondary structure prediction with RNAshapes
  --disable_RNAstructure
                        skip secondary structure prediction with RNAstructures
  --generate_negative, -n
                        generate a negative set for classification
  --min_score MIN_SCORE
                        filtering: minimum score for binding site (default:
                        0.0)
  --min_length MIN_LENGTH
                        filtering: minimum binding site length (default: 8)
  --max_length MAX_LENGTH
                        filtering: maximum binding site length (default: 75)
  --elongation ELONGATION
                        elongation: span for up- and downstream elongation of
                        binding sites (default: 20)
  --genome_genes GENOME_GENES
                        negative set generation: gene boundaries
  --skip_check, -s      skip check for installed prerequisites
```


## sshmm_train_seqstructhmm

### Tool Description
Trains a Hidden Markov Model for the sequence-structure binding preferences of an RNA-binding protein. The model is trained on sequences and structures from a CLIP-seq experiment given in two FASTA-like files.
During the training process, statistics about the model are printed on stdout. In every iteration, the current model and a visualization of the model can be stored in the output directory.
The training process terminates when no significant progress has been made for three iterations.

### Metadata
- **Docker Image**: quay.io/biocontainers/sshmm:1.0.7--py27_0
- **Homepage**: https://github.molgen.mpg.de/heller/ssHMM
- **Package**: https://anaconda.org/channels/bioconda/packages/sshmm/overview
- **Validation**: PASS

### Original Help Text
```text
usage: train_seqstructhmm [-h] [--motif_length MOTIF_LENGTH] [--random]
                          [--flexibility FLEXIBILITY]
                          [--block_size BLOCK_SIZE] [--threshold THRESHOLD]
                          [--job_name JOB_NAME]
                          [--output_directory OUTPUT_DIRECTORY]
                          [--termination_interval TERMINATION_INTERVAL]
                          [--no_model_state] [--only_best_shape]
                          training_sequences training_structures

Trains a Hidden Markov Model for the sequence-structure binding preferences of an RNA-binding protein. The model is trained on sequences and structures from a CLIP-seq experiment given in two FASTA-like files.
During the training process, statistics about the model are printed on stdout. In every iteration, the current model and a visualization of the model can be stored in the output directory.
The training process terminates when no significant progress has been made for three iterations.

positional arguments:
  training_sequences    FASTA file with sequences for training
  training_structures   FASTA file with RNA structures for training

optional arguments:
  -h, --help            show this help message and exit
  --motif_length MOTIF_LENGTH, -n MOTIF_LENGTH
                        length of the motif that shall be found (default: 6)
  --random, -r          Initialize the model randomly (default: initialize
                        with Baum-Welch optimized sequence motif)
  --flexibility FLEXIBILITY, -f FLEXIBILITY
                        greedyness of Gibbs sampler: model parameters are
                        sampled from among the top f configurations (default:
                        f=10), set f to 0 in order to include all possible
                        configurations
  --block_size BLOCK_SIZE, -s BLOCK_SIZE
                        number of sequences to be held-out in each iteration
                        (default: 1)
  --threshold THRESHOLD, -t THRESHOLD
                        the iterative algorithm is terminated if this
                        reduction in sequence structure loglikelihood is not
                        reached for any of the 3 last measurements (default:
                        10)
  --job_name JOB_NAME, -j JOB_NAME
                        name of the job (default: "job")
  --output_directory OUTPUT_DIRECTORY, -o OUTPUT_DIRECTORY
                        directory to write output files to (default: current
                        directory)
  --termination_interval TERMINATION_INTERVAL, -i TERMINATION_INTERVAL
                        produce output every <i> iterations (default: i=100)
  --no_model_state, -w  do not write model state every i iterations
  --only_best_shape     train only using best structure for each sequence
                        (default: use all structures)
```


## sshmm_draw_model_graph

### Tool Description
Takes a ssHMM model file in XML format and produces a model graph in PNG format.

### Metadata
- **Docker Image**: quay.io/biocontainers/sshmm:1.0.7--py27_0
- **Homepage**: https://github.molgen.mpg.de/heller/ssHMM
- **Package**: https://anaconda.org/channels/bioconda/packages/sshmm/overview
- **Validation**: PASS

### Original Help Text
```text
usage: draw_model_graph [-h] model sequence_number output

Takes a ssHMM model file in XML format and produces a model graph in PNG format.

positional arguments:
  model            model file in XML format
  sequence_number  number of training sequences that were used to generate the
                   model. This number can be found in the verbose log file.
  output           model graph output

optional arguments:
  -h, --help       show this help message and exit
```

