# tiara CWL Generation Report

## tiara

### Tool Description
a deep-learning-based approach for identification of eukaryotic sequences in the metagenomic data powered by PyTorch.

### Metadata
- **Docker Image**: quay.io/biocontainers/tiara:1.0.3
- **Homepage**: https://github.com/ibe-uw/tiara
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/conda-forge/packages/tiara/overview
- **Total Downloads**: 5.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ibe-uw/tiara
- **Stars**: N/A
### Original Help Text
```text
usage: tiara [-h] -i input [-o output] [-m MIN_LEN]
             [--first_stage_kmer FIRST_STAGE_KMER]
             [--second_stage_kmer SECOND_STAGE_KMER] [-p cutoff [cutoff ...]]
             [--to_fasta class [class ...]] [-t THREADS] [--probabilities]
             [-v] [--gzip]

tiara - a deep-learning-based approach for identification of eukaryotic sequences 
in the metagenomic data powered by PyTorch.  

The sequences are classified in two stages:

- In the first stage, the sequences are classified to classes: 
      archaea, bacteria, prokarya, eukarya, organelle and unknown.
- In the second stage, the sequences labeled as organelle in the first stage 
      are classified to either mitochondria, plastid or unknown.

optional arguments:
  -h, --help            show this help message and exit
  -i input, --input input
                        A path to a fasta file.
  -o output, --output output
                        A path to output file. If not provided, the result is printed to stdout.
  -m MIN_LEN, --min_len MIN_LEN
                        Minimum length of a sequence. Sequences shorter than min_len are discarded. 
                                Default: 3000.
  --first_stage_kmer FIRST_STAGE_KMER, --k1 FIRST_STAGE_KMER
                        k-mer length used in the first stage of classification. Default: 6.
  --second_stage_kmer SECOND_STAGE_KMER, --k2 SECOND_STAGE_KMER
                        k-mer length used in the second stage of classification. Default: 7.
  -p cutoff [cutoff ...], --prob_cutoff cutoff [cutoff ...]
                        Probability threshold needed for classification to a class. 
                                If two floats are provided, the first is used in a first stage, the second in the second stage
                                Default: [0.65, 0.65].
  --to_fasta class [class ...], --tf class [class ...]
                        Write sequences to fasta files specified in the arguments to this option.
                                The arguments are: mit - mitochondria, pla - plastid, bac - bacteria, 
                                arc - archaea, euk - eukarya, unk - unknown, pro - prokarya, 
                                all - all classes present in input fasta (to separate fasta files).
  -t THREADS, --threads THREADS
                        Number of threads used.
  --probabilities, --pr
                        Whether to write probabilities of individual classes for each sequence to the output.
  -v, --verbose         Whether to display some additional messages and progress bar during classification.
  --gzip, --gz          Whether to gzip results or not.
```

