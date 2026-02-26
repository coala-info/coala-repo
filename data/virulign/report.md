# virulign CWL Generation Report

## virulign

### Tool Description
Aligns sequences to a reference genome, identifying mutations and structural variations.

### Metadata
- **Docker Image**: quay.io/biocontainers/virulign:1.1.1--hf316886_6
- **Homepage**: https://github.com/rega-cev/virulign
- **Package**: https://anaconda.org/channels/bioconda/packages/virulign/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/virulign/overview
- **Total Downloads**: 11.7K
- **Last updated**: 2025-08-14
- **GitHub**: https://github.com/rega-cev/virulign
- **Stars**: N/A
### Original Help Text
```text
Usage: virulign [reference.fasta orf-description.xml] sequences.fasta
Optional parameters (first option will be the default):
  --exportKind [Mutations PairwiseAlignments GlobalAlignment PositionTable MutationTable]
  --exportAlphabet [AminoAcids Nucleotides]
  --exportWithInsertions [yes no]
  --exportReferenceSequence [no yes]
  --gapExtensionPenalty doubleValue=>3.3
  --gapOpenPenalty doubleValue=>10.0
  --maxFrameShifts intValue=>3
  --progress [no yes]
  --threads intValue=>1 [default: all cpus available]
  --nt-debug directory
Output: The alignment will be printed to standard out and any progress or error messages will be printed to the standard error. This output can be redirected to files, e.g.:
   virulign ref.xml sequence.fasta > alignment.mutations 2> alignment.err
```


## Metadata
- **Skill**: generated
