# tr-trimmer CWL Generation Report

## tr-trimmer

### Tool Description
Trim terminal repeats from sequences in FASTA files

### Metadata
- **Docker Image**: quay.io/biocontainers/tr-trimmer:0.4.0--h4349ce8_0
- **Homepage**: https://github.com/apcamargo/tr-trimmer
- **Package**: https://anaconda.org/channels/bioconda/packages/tr-trimmer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tr-trimmer/overview
- **Total Downloads**: 2.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/apcamargo/tr-trimmer
- **Stars**: N/A
### Original Help Text
```text
Trim terminal repeats from sequences in FASTA files

Usage: tr-trimmer [OPTIONS] [INPUT]...

Arguments:
  [INPUT]...  Input file(s). Use '-' for stdin [default: -]

Options:
  -h, --help     Print help
  -V, --version  Print version

Terminal repeat identification:
  -i, --enable-itr-identification
          Identify inverted terminal repeats (ITRs) from sequences
  -d, --disable-dtr-trimming
          Disable identification of direct terminal repeats (DTRs) from
          sequences (requires --enable-itr-trimming)
  -l, --min-length <MIN_LENGTH>
          Minimum length of terminal repeat [default: 21]

Terminal repeat filtering:
  -c, --ignore-low-complexity
          Ignore terminal repeats that contain a high proportion of low
          complexity sequences
      --max-low-complexity-frac <MAX_LOW_COMPLEXITY_FRAC>
          Maximum fraction of the terminal repeat length that is comprised of
          low-complexity sequence [default: 0.5]
  -n, --ignore-ambiguous
          Ignore terminal repeats that contain a high proportion of ambiguous
          bases (e.g. 'N')
      --max-ambiguous-frac <MAX_AMBIGUOUS_FRAC>
          Maximum fraction of the terminal repeat length that is comprised of
          ambiguous bases [default: 0.0]

Output:
  -x, --exclude-non-tr-seqs  Retain only the sequences for which terminal
                             repeats were identified
  -a, --include-tr-info      Add terminal repeat information to the sequence
                             headers (e.g., 'tr=dtr tr_length=55')
  -t, --disable-trimming     Disable trimming of terminal repeats from
                             sequences. Can be used with `--include-tr-info` or
                             `--exclude-non-tr-seqs` to identify and report
                             sequences with terminal repeats without modifying
                             the sequences
```

