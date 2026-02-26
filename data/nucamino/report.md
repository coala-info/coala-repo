# nucamino CWL Generation Report

## nucamino_hiv1b

### Tool Description
Use HIV-1 type B consensus from LANL to align input sequences; support genes POL (56gag + 99PR + 560RT + 288IN)

### Metadata
- **Docker Image**: quay.io/biocontainers/nucamino:0.1.3--0
- **Homepage**: https://github.com/hivdb/nucamino
- **Package**: https://anaconda.org/channels/bioconda/packages/nucamino/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/nucamino/overview
- **Total Downloads**: 5.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/hivdb/nucamino
- **Stars**: N/A
### Original Help Text
```text
Usage:
  nucamino [OPTIONS] hiv1b [hiv1b-OPTIONS]

Use HIV-1 type B consensus from LANL to align input sequences; support genes
POL (56gag + 99PR + 560RT + 288IN)

Help Options:
  -h, --help                                         Show this help message

[hiv1b command options]
      -q, --quiet                                    hide non-error information
                                                     output
      -g, --gene=[GAG|POL|GP41]                      gene(s) the input
                                                     sequences should be
                                                     aligned with
          --indel-codon-opening-bonus=BONUS          bonus score when a indel
                                                     codon was opened (default:
                                                     0)
          --indel-codon-extension-bonus=BONUS        bonus score when a indel
                                                     codon was extended
                                                     (default: 2)
          --stop-codon-penalty=PENALTY               penalty score when a stop
                                                     codon was met (default: 4)
          --gap-opening-penalty=PENALTY              penalty score when a gap
                                                     was opened (default: 10)
          --gap-extension-penalty=PENALTY            penalty score when a gap
                                                     was extended (default: 2)
          --goroutines=GOROUTINES                    number of goroutines the
                                                     alignment will use. Use
                                                     the core number when
                                                     equals to 0 (default: 0)
          --output-format=OUTPUT_FORMAT[tsv|json]    output format of the
                                                     alignment result (default:
                                                     tsv)

    File Options:
      -i, --input=INPUT                              FASTA file contains one or
                                                     more DNA sequences
                                                     (default: -)
      -o, --output=OUTPUT                            output destination of the
                                                     alignment results
                                                     (default: -)

    Pprof Options:
          --pprof                                    output pprof benchmark
                                                     result
```

