# tedna CWL Generation Report

## tedna

### Tool Description
Tedna is a tool for detecting transposable elements in genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/tedna:1.3.1--h503566f_0
- **Homepage**: https://github.com/mzytnicki/tedna
- **Package**: https://anaconda.org/channels/bioconda/packages/tedna/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tedna/overview
- **Total Downloads**: 6.7K
- **Last updated**: 2025-11-28
- **GitHub**: https://github.com/mzytnicki/tedna
- **Stars**: N/A
### Original Help Text
```text
USAGE: tedna [options]

Compulsory options:
  -1, --file1          First FASTQ file.
  -k, --kmer           K-mer size.
  -o, --output         Output file.

Other options:
  -2, --file2          Second FASTQ file.
  -i, --insert         Insert size.
  -t, --threshold      K-mer frequency threshold   (default: ad hoc).
  -m, --min-te-size    Minimum TE size             (default: 500).
  -M, --max-te-size    Maximum TE size             (default: 30000).
  -p, --processors     Number of processors        (default: 2).
  --help               Print usage and exit.
  --version            Print version and exit.

Obscure options:

  k-mer frequency:
  --repeat-frequency   Minimum number of repetitions      (default: 2).
  --min-frequency      Minimum k-mer frequency            (default: 3).
  --frequency-dif      Maximum k-mer frequency difference (default: 2.5).

  graph:
  --small-graph        Minimum graph size                 (default: 300).
  --big-graph          Maximum graph size                 (default: 100000).
  --small-graph-count  Stop after N small graphs          (default: 10000), 0:
                       never stop.
  --max-paths          Maximum # paths                    (default: 100), 0:
                       never stop.
  --erosion            Erosion strength                   (default: 100).
  --bubble-size        Size of the bubbles                (default: 1000).

  LTR elements:
  --min-ltr            Minimum LTR size                   (default: 50).
  --max-ltr            Maximum LTR size                   (default: 5000).

  duplicate removal:
  --duplicate-id       Maximum id. to remove duplicate    (default: 30%).

  merge:
  --min-overlap        Minimum overlap to merge TEs       (default: 20).
  --max-overlap        Maximum overlap to merge TEs       (default: 500).
  --short-kmer         Small k-mer size                   (default: 15).
  --indel-pen          Indel penalty                      (default: 30).
  --mismatch-pen       Mismatch penalty                   (default: 10).
  --size-pen           Size penalty                       (default: 1).
  --max-pen            Maximum penalty                    (default: 200).
  --min-id             Minimum identity                   (default: 80).
  --merge-max-nb       Maximum number of repeats          (default: 10000), 0:
                       do not use.
  --merge-max-nodes    Maximum number of neighbor/node    (default: 10), 0: do
                       not use.

  scaffolding:
  --min-scaffold       Minimum number of evidences/scaff. (default: 100).
  --max-scaffold       Maximum number of evidences/scaff. (default: 10000).
  --scaffold-max-nb    Maximum number of neighbor/node    (default: 5), 0: do
                       not use.

  input reading:
  --fasta-input        Input file is in FASTA format      (default: not set).
  --bytes-per-thread   Number of bytes read per thread    (default: 10000000).
  --max-reads          Maximum number of reads read       (default: 0), 0: read
                       all.
  --check              Check if a sequence is assembled   (default: none).

Example:
  ./tedna -1 left.fastq -2 right.fastq -k 61 -i 300 -o output.fasta
```

