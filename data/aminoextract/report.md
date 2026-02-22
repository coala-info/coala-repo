# aminoextract CWL Generation Report

## aminoextract

### Tool Description
A quick tool to extract amino acid sequences from a FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/aminoextract:0.4.1--pyhdfd78af_0
- **Homepage**: https://pypi.org/project/AminoExtract/
- **Package**: https://anaconda.org/channels/bioconda/packages/aminoextract/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/aminoextract/overview
- **Total Downloads**: 5.3K
- **Last updated**: 2025-10-31
- **GitHub**: https://github.com/RIVM-bioinformatics/AminoExtract
- **Stars**: 1
### Original Help Text
```text
usage: AminoExtract [required options] [optional options]

AminoExtract: A quick tool to extract amino
acid sequences from a FASTA file.

Required Arguments:
  --input, -i File                     Input FASTA file with nucleotide
                                       sequences.
  --features, -gff File                GFF file containing the information of
                                       the amino acid sequences to extract.
  --output, -o Path                    Output path, either a file or
                                       directory.
                                        * If a file path is given, then all
                                          amino acid sequences will be written
                                          to this file.
                                        * If a directory path is given, then
                                          each amino acid sequence will be
                                          written to a separate file in this
                                          directory.
                                        Please see the docs for
                                        more info
  --name, -n Text                      Name of the sample that is being
                                       processed.
                                        * This will be used to create the
                                          fasta headers when all amino acid
                                          sequences are written to a single
                                          file.
                                        * If the output is going to be written
                                          to individual files in an output-
                                          directory, then this name will be
                                          used as a prefix to create the
                                          output files.
                                        Please see the docs for
                                        more info

Optional Arguments:
  --feature-type, -ft Text [Text ...]  Defines which feature types in the
                                       input GFF will be processed to AA
                                       sequences. Defaults to 'CDS'. You can
                                       provide multiple types (space-
                                       separated), e.g. -ft CDS gene exon
  --keep-gaps, -kg                     If this flag is set then the AA
                                       translation will be done including gaps
                                       in the nucleotide sequence. This
                                       results in an "X" on gapped positions
                                       in the AA sequence as gap characters
                                       ("-") will be replaced by "N" in the
                                       nucleotide sequence. By
                                       default, gaps are removed before
                                       translation.
  --version, -v                        Print the AminoExtract version and
                                       exit.
  --help, -h                           Show this help message and exit.
  --verbose, -vb                       Print out more information during the
                                       process.
                                        (default:
                                        False)
```


## Metadata
- **Skill**: not generated
