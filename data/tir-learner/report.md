# tir-learner CWL Generation Report

## tir-learner_TIR-Learner

### Tool Description
TIR-Learner is an ensemble pipeline for Terminal Inverted Repeat (TIR) transposable elements annotation in eukaryotic genomes

### Metadata
- **Docker Image**: quay.io/biocontainers/tir-learner:3.0.7--hdfd78af_0
- **Homepage**: https://github.com/lutianyu2001/TIR-Learner
- **Package**: https://anaconda.org/channels/bioconda/packages/tir-learner/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tir-learner/overview
- **Total Downloads**: 7.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/lutianyu2001/TIR-Learner
- **Stars**: N/A
### Original Help Text
```text
usage: TIR-Learner [-h] [-v] -f GENOME_FILE [-n GENOME_NAME] -s SPECIES
                   [-l LENGTH] [-p PROCESSORS] [-m MODE] [-w WORKING_DIR]
                   [-o OUTPUT_DIR] [-c [CHECKPOINT_DIR]] [--verbose] [-d]
                   [--grf_path GRF_PATH] [--gt_path GT_PATH]
                   [-a ADDITIONAL_ARGS [ADDITIONAL_ARGS ...]]

TIR-Learner is an ensemble pipeline for Terminal Inverted Repeat (TIR)
transposable elements annotation in eukaryotic genomes

optional arguments:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit
  -f GENOME_FILE, --genome_file GENOME_FILE
                        Genome file in fasta format
  -n GENOME_NAME, --genome_name GENOME_NAME
                        Genome name (Optional)
  -s SPECIES, --species SPECIES
                        One of the following: "maize", "rice" or "others"
  -l LENGTH, --length LENGTH
                        Max length of TIR (Optional)
  -p PROCESSORS, --processors PROCESSORS, -t PROCESSORS, --cpu PROCESSORS
                        Number of processors allowed (Optional)
  -m MODE, --mode MODE  Parallel execution mode, one of the following: "py"
                        and "gnup" (Optional)
  -w WORKING_DIR, --working_dir WORKING_DIR
                        The path to the working directory (Optional). An
                        isolated sandbox directory for storing all the
                        temporary files will be created in the working
                        directory. This sandbox directory will only persist
                        during the program execution. DO NOT TOUCH THE SANDBOX
                        DIRECTORY IF IT IS NOT FOR DEBUGGING!
  -o OUTPUT_DIR, --output_dir OUTPUT_DIR
                        Output directory (Optional)
  -c [CHECKPOINT_DIR], --checkpoint_dir [CHECKPOINT_DIR]
                        The path to the checkpoint directory (Optional). If
                        not specified, the program will automatically search
                        for it in the genome file directory and the output
                        directory.
  --verbose             Verbose mode (Optional). Will show interactive
                        progress bar and more execution details.
  -d, --debug           Debug mode (Optional). If activated, data for all
                        completed steps will be stored in the checkpoint file.
                        Meanwhile, the temporary files in the working
                        directory will also be kept.
  --grf_path GRF_PATH   Path to GRF program (Optional)
  --gt_path GT_PATH     Path to genometools program (Optional)
  -a ADDITIONAL_ARGS [ADDITIONAL_ARGS ...], --additional_args ADDITIONAL_ARGS [ADDITIONAL_ARGS ...]
                        Additional arguments (Optional). See documentation for
                        more details.
```

