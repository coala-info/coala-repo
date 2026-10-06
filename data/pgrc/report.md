# pgrc CWL Generation Report

## Metadata
- **Skill**: generated

## pgrc_PgRC

### Tool Description
PgRC 2.0: A tool for genomic read compression and decompression.

### Metadata
- **Docker Image**: quay.io/biocontainers/pgrc:2.0.2--h9948957_1
- **Homepage**: https://github.com/kowallus/PgRC
- **Package**: https://anaconda.org/channels/bioconda/packages/pgrc/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
PgRC 2.0: Copyright (c) Tomasz Kowalski, Szymon Grabowski: 2024

Usage: /usr/local/bin/PgRC [-i seqSrcFile [pairSrcFile]] [-t noOfThreads]
[-o] [-d] archiveName

	-d decompression mode
	-o preserve original read order information
	-t number of threads used (40 - default)
	-h print full command help and exit
	-v print version number and exit

------------------ EXPERT OPTIONS ----------------
[-q qualityStreamErrorProbability*1000] (1000=>disable)
[-Q] disable simplified quality estimation mode
[-g generatorBasedQualityCoefficientIn_%] (0=>disable; 'ov' param in the paper)
[-s lengthOfReadSeedPartForReadsAlignmentPhase]
[-M minimalNumberOfCharsPerMismatchForReadsAlignmentPhase]
[-p minimalReverseComplementedRepeatLength]

The order of all selected options is arbitrary.
```

