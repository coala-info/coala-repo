# eukrep CWL Generation Report

## eukrep_EukRep

### Tool Description
Identify sequences of predicted eukaryotic origin from a nucleotide fasta file. Individual sequences are split into 5kb chunks. Prediction is performed on each 5kb chunk and sequence origin is determined by majority rule of the chunks.

### Metadata
- **Docker Image**: quay.io/biocontainers/eukrep:0.6.7--pyh7e72e81_3
- **Homepage**: https://github.com/patrickwest/EukRep
- **Package**: https://anaconda.org/channels/bioconda/packages/eukrep/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/eukrep/overview
- **Total Downloads**: 6.1K
- **Last updated**: 2025-07-30
- **GitHub**: https://github.com/patrickwest/EukRep
- **Stars**: N/A
### Original Help Text
```text
usage: EukRep [-h] -i I -o O [-ff] [--min MIN] [--model MODEL] [-k KMER_LEN]
              [--prokarya PROKARYA] [--seq_names]
              [-m {strict,balanced,lenient}] [--version] [--tie TIE]

Identify sequences of predicted eukaryotic origin from a nucleotide fasta file. Individual sequences are split into 5kb chunks. Prediction is performed on each 5kb chunk and sequence origin is determined by majority rule of the chunks.

optional arguments:
  -h, --help            show this help message and exit
  -i I                  input fasta file
  -o O                  output file name
  -ff                   Force overwrite of existing output files
  --min MIN             Minimum sequence length cutoff for sequences to be included in prediction. Default is 3kb
  --model MODEL         Path to an alternate trained linear SVM model. Default is lin_svm_160_3.0.pickle
  -k KMER_LEN, --kmer_len KMER_LEN
                        Kmer length to use for making predictions. Lengths between 3-7bp are available by default. If using a custom trained model, specify kmer length here.
  --prokarya PROKARYA   Name of file to output predicted prokaryotic sequences to. Default is to not output prokaryotic sequences.
  --seq_names           Only output fasta headers of identified sequences. Default is full fasta entry
  -m {strict,balanced,lenient}
                        Not compatable with --model.
                                How stringent the algorithm is in identifying eukaryotic scaffolds. Strict has a lower false positive rate and true positive rate; vice verso for leneient. Default is balanced.
  --version             show program's version number and exit
  --tie TIE             Specify how to handle cases where an equal number of a sequences chunks are predicted to be of eukaryotic and prokaryotic origin (Generally occurs infrequently).
                                euk = classify as euk
                                prok = classify as prok
                                rand = assign randomly
                                skip = do not classify
                                Default is to classify as eukaryotic.
```

