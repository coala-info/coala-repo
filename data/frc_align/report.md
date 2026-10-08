# frc_align CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| frc_align_FRC | PASS |  |

## frc_align_FRC

### Tool Description
Feature Response Curve (FRC) computes assembly quality features and the FRC from paired-end and mate-pair read alignments against an assembly.

### Metadata
- **Docker Image**: quay.io/biocontainers/frc:5b3f53e--boost1.64_0
- **Homepage**: https://github.com/vezzi/FRC_align
- **Package**: https://anaconda.org/channels/bioconda/packages/frc_align/overview
- **Validation**: PASS

### Original Help Text
```text
FRC version 1.3.0

Allowed options:
  --help                produce help message
  --pe-sam arg          paired end alignment file (in sam or bam format). 
                        Orientation must be -> <-
  --pe-max-insert arg   maximum allowed insert size for PE (to filter out 
                        outleyers)
  --mp-sam arg          mate pairs alignment file. (in sam or bam format). 
                        Orientation must be <- ->
  --mp-max-insert arg   maximum allowed insert size for MP (to filter out 
                        outleyers)
  --genome-size arg     estimated genome size (if not supplied genome size is 
                        believed to be assembly length
  --output arg          Header output file names (default FRC.txt and 
                        Features.txt)
  --CEstats-PE-min arg  minimum allowed CE_stats in PE library
  --CEstats-PE-max arg  maximum allowed CE_stats in PE library
  --CEstats-MP-min arg  minimum allowed CE_stats in MP library
  --CEstats-MP-max arg  maximum allowed CE_stats in MP library
```

