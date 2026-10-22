# soapdenovo2-prepare CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| soapdenovo2-prepare_finalFusion | PASS | new CWL replacing junk; data prepare mode (-D) on the SARS-CoV-2 nf-core genome gives a contig file of 29829 bases; mapping, bundling and scaffolding modes not run |

## soapdenovo2-prepare_finalFusion

### Tool Description
SOAPdenovo2 mapping and scaffolding module (finalFusion).

### Metadata
- **Docker Image**: quay.io/biocontainers/soapdenovo2-prepare:2.0--h577a1d6_9
- **Homepage**: https://github.com/aquaskyline/SOAPdenovo2
- **Package**: https://anaconda.org/channels/bioconda/packages/soapdenovo2-prepare/overview
- **Validation**: PASS

### Original Help Text
```text
Mapping & Scaffolding module.
Author: BGIRD-CD
Version: prototype.
parameters:
global:
-s	Library file.
-g	Prefix of input files.
-p	Threads.

Data prepare mode:
-D	Enable this mode.
-K	Kmer.
-c	Input contig file.(can't be name prefix.contig)

Mapping mode:
-M	Enable this mode.

Bundling mode.
-B	Enable this mode.
-u	Weight threshold for outputting bundle file.(default 3)

Potential analysis mode.
-O	Enable this mode.
Scaffolding mode:
-S	Enable this mode.
-L	threshold for minimum length of contig(default K+2).
-P	Overlap percent threshold for a subgraph(default 0.075).
-t	Overlap percent threshold for a PE(default 0.2).
-i	Overlap length threshold for remove transitive connect(default 20).
```

## Metadata
- **Skill**: not generated
