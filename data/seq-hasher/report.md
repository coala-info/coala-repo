# seq-hasher CWL Generation Report

## seq-hasher

### Tool Description
Compute hash digests for sequences in a FASTA file

### Metadata
- **Docker Image**: quay.io/biocontainers/seq-hasher:0.2.0--h4349ce8_0
- **Homepage**: https://github.com/zszszszsz/.config
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/seq-hasher/overview
- **Total Downloads**: 1.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/zszszszsz/.config
- **Stars**: N/A
### Original Help Text
```text
Compute hash digests for sequences in a FASTA file

Usage: seq-hasher [OPTIONS] [INPUT]...

Arguments:
  [INPUT]...  Input file(s). Use '-' for stdin [default: -]

Options:
  -h, --help     Print help
  -V, --version  Print version

Output:
  -s, --print-sequence  Print sequences in a third column

Hashing:
  -m, --multi-kmer-hashing  Instead of hashing the entire sequence at once,
                            hash each k-mer individually and then combine the
                            resulting hashes
  -x, --xxhash              Replace ntHash with xxHash for hashing k-mers.
                            Works only with --multi-kmer-hashing
  -k, --kmer-size <K>       Size of the k-mers to hash when using
                            --multi-kmer-hashing [default: 31]

Circular sequences:
  -r, --circular-rotation  Make hashing robust to circular permutations via
                           deterministic rotation to the lexicographically
                           minimal sequence
  -w, --circular-kmers     Make hashing robust to circular permutations via
                           addition of the k-mers that wrap around the end of
                           the sequence. Works only with --multi-kmer-hashing
```


## Metadata
- **Skill**: not generated
