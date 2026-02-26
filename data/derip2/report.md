# derip2 CWL Generation Report

## derip2

### Tool Description
Predict ancestral sequence of fungal repeat elements by correcting for RIP-like mutations or cytosine deamination in multi-sequence DNA alignments. Optionally, mask mutated positions in alignment.

### Metadata
- **Docker Image**: quay.io/biocontainers/derip2:0.4.1--pyhdfd78af_0
- **Homepage**: https://github.com/Adamtaranto/deRIP2
- **Package**: https://anaconda.org/channels/bioconda/packages/derip2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/derip2/overview
- **Total Downloads**: 323
- **Last updated**: 2025-11-12
- **GitHub**: https://github.com/Adamtaranto/deRIP2
- **Stars**: N/A
### Original Help Text
```text
Usage: derip2 [OPTIONS]

  Predict ancestral sequence of fungal repeat elements by correcting for RIP-
  like mutations or cytosine deamination in multi-sequence DNA alignments.
  Optionally, mask mutated positions in alignment.

Options:
  --version                       Show the version and exit.
  -i, --input TEXT                Multiple sequence alignment.  [required]
  -g, --max-gaps FLOAT            Maximum proportion of gapped positions in
                                  column to be tolerated before forcing a gap
                                  in final deRIP sequence.  [default: 0.7]
  -a, --reaminate                 Correct all deamination events independent
                                  of RIP context.
  --max-snp-noise FLOAT           Maximum proportion of conflicting SNPs
                                  permitted before excluding column from
                                  RIP/deamination assessment. i.e. By default
                                  a column with >= 0.5 'C/T' bases will have
                                  'TpA' positions logged as RIP events.
                                  [default: 0.5]
  --min-rip-like FLOAT            Minimum proportion of deamination events in
                                  RIP context (5' CpA 3' --> 5' TpA 3')
                                  required for column to deRIP'd in final
                                  sequence. Note: If 'reaminate' option is set
                                  all deamination events will be corrected.
                                  [default: 0.1]
  --fill-max-gc                   By default uncorrected positions in the
                                  output sequence are filled from the sequence
                                  with the lowest RIP count. If this option is
                                  set remaining positions are filled from the
                                  sequence with the highest G/C content.
  --fill-index INTEGER            Force selection of alignment row to fill
                                  uncorrected positions from by row index
                                  number (indexed from 0). Note: Will override
                                  '--fill-max-gc' option.
  --mask                          Mask corrected positions in alignment with
                                  degenerate IUPAC codes.
  --no-append                     If set, do not append deRIP'd sequence to
                                  output alignment.
  -d, --out-dir TEXT              Directory for deRIP'd sequence files to be
                                  written to.
  -p, --prefix TEXT               Prefix for output files. Output files will
                                  be named prefix.fasta,
                                  prefix_alignment.fasta, etc.  [default:
                                  deRIPseq]
  --plot                          Create a visualization of the alignment with
                                  RIP markup.
  --plot-rip-type [both|product|substrate]
                                  Specify the type of RIP events to be
                                  displayed in the alignment visualization.
                                  [default: both]
  --loglevel [DEBUG|INFO|WARNING|ERROR|CRITICAL]
                                  Set logging level.  [default: INFO]
  --logfile TEXT                  Log file path.
  -h, --help                      Show this message and exit.
```

