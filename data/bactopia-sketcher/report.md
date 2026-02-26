# bactopia-sketcher CWL Generation Report

## bactopia-sketcher_sketch

### Tool Description
The 'sketch dna' command reads in DNA sequences and outputs DNA sketches.

### Metadata
- **Docker Image**: quay.io/biocontainers/bactopia-sketcher:1.0.2--hdfd78af_0
- **Homepage**: https://bactopia.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bactopia-sketcher/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bactopia-sketcher/overview
- **Total Downloads**: 6.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bactopia/bactopia-sketcher
- **Stars**: N/A
### Original Help Text
```text
usage: 

    sourmash sketch dna data/*.fna.gz

The 'sketch dna' command reads in DNA sequences and outputs DNA
sketches.

By default, 'sketch dna' uses the parameter string 'k=31,scaled=1000,noabund'.

This creates sketches with a k-mer size of 31, a scaled factor of
1000, and no abundance tracking of k-mers.  You can specify one or
more parameter strings of your own with -p, e.g.  'sourmash sketch dna
-p k=31,noabund -p k=21,scaled=100,abund'. Note that a single `-p` parameter string can contain multiple ksize values, but only a single scaled value or abundance value, e.g. -p k=21,k=31,abund

'sourmash sketch' takes input sequences in FASTA and FASTQ,
uncompressed or gz/bz2 compressed.

Please see the 'sketch' documentation for more details:
  https://sourmash.readthedocs.io/en/latest/sourmash-sketch.html

positional arguments:
  filenames             file(s) of sequences

options:
  -h, --help            show this help message and exit
  --license LICENSE     signature license. Currently only CC0 is supported.
  --check-sequence      complain if input sequence is invalid DNA
  -p PARAM_STRING, --param-string PARAM_STRING
                        signature parameters to use.
  --from-file FROM_FILE
                        a text file containing a list of sequence files to
                        load

File handling options:
  -f, --force           recompute signatures even if the file exists
  -o OUTPUT, --output OUTPUT
                        output computed signatures to this file
  --merge FILE, --name FILE
                        merge all input files into one signature file with the
                        specified name
  --output-dir OUTPUT_DIR, --outdir OUTPUT_DIR
                        output computed signatures to this directory
  --singleton           compute a signature for each sequence record
                        individually
  --name-from-first     name the signature generated from each file after the
                        first record in the file
  --randomize           shuffle the list of input filenames randomly
```

