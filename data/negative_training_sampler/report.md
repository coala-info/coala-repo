# negative_training_sampler CWL Generation Report

## negative_training_sampler

### Tool Description
A simple script that takes a tsv file with positive and negative labels
  and a reference file. Generates negative samples with the same GC
  distribution as the positive samples per chromosome.

### Metadata
- **Docker Image**: quay.io/biocontainers/negative_training_sampler:0.3.1--py_0
- **Homepage**: https://github.com/kircherlab/negative_training_sampler
- **Package**: https://anaconda.org/channels/bioconda/packages/negative_training_sampler/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/negative_training_sampler/overview
- **Total Downloads**: 10.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/kircherlab/negative_training_sampler
- **Stars**: N/A
### Original Help Text
```text
Usage: negative_training_sampler [OPTIONS]

  A simple script that takes a tsv file with positive and negative labels
  and a reference file. Generates negative samples with the same GC
  distribution as the positive samples per chromosome.

Options:
  -i, --label-file PATH      Input bed file with labeled regions  [required]
  -r, --reference-file PATH  Input genome reference in fasta format
                             [required]

  -g, --genome-file PATH     Input genome file of reference  [required]
  -o, --output_file PATH     Path to output file.
  -n, --label_num INTEGER    Number of separate label columns.
  --precision INTEGER        Precision of decimals when computing the
                             attributes like GC content.

  -c, --bgzip                Output will be bgzipped.
  --log PATH                 Write logging to this file.
  --verbose                  Will print verbose messages.
  --seed INTEGER             Sets the seed for sampling.
  --cores INTEGER            number of used cores default: 1
  --memory TEXT              amount of memory per core (e.g. 2 cores * 2GB =
                             4GB) default: 2GB

  --help                     Show this message and exit.
```

