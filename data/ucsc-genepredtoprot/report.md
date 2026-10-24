# ucsc-genepredtoprot CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ucsc-genepredtoprot | PASS | New CWL for genePredToProt; protein and CDS from a human chr22 slice (genePred from the nf-core GTF) match an independent translation |

## ucsc-genepredtoprot

### Tool Description
Create protein sequences by translating gene annotations.

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-genepredtoprot:482--h0b57e2e_0
- **Homepage**: https://hgdownload.cse.ucsc.edu/admin/exe
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-genepredtoprot/overview
- **Validation**: PASS

### Original Help Text
```text
genePredToProt - create protein sequences by translating gene annotations
usage:
   genePredToProt genePredFile genomeSeqs protFa

This honors frame if genePred has frames, dropping partial codons.
genomeSeqs is a 2bit or directory of nib files.

options:
  -cdsFa=fasta - output FASTA with CDS that was used to generate protein.
                 This will not include dropped partial codons.
  -protIdSuffix=str - add this string to the end of the name for protein FASTA
  -cdsIdSuffix=str - add this string to the end of the name for CDS FASTA
  -translateSeleno - assume internal TGA code for selenocysteine and translate to `U'.
  -includeStop - If the CDS ends with a stop codon, represent it as a `*'
  -starForInframeStops - use `*' instead of `X' for in-frame stop codons.
                  This will result in selenocysteine's being `*', with only codons
                  containing `N' being translated to `X'.  This doesn't include terminal
                  stop
```

## Metadata
- **Skill**: generated

