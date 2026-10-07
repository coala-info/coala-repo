# ddocent CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ddocent_RefMapOpt.sh | PASS |  |
| ddocent_ReferenceOpt.sh | PASS |  |

## ddocent_ReferenceOpt.sh

### Tool Description
Scales similarity parameters for reference-based assembly.

### Metadata
- **Docker Image**: quay.io/biocontainers/ddocent:2.9.8--hdfd78af_0
- **Homepage**: https://ddocent.com
- **Package**: https://anaconda.org/channels/bioconda/packages/ddocent/overview
- **Validation**: PASS

### Original Help Text
```text
Usage is sh ReferenceOpt.sh minK1 maxK1 minK2 maxK2 Assembly_Type Number_of_Processors



Optionally, a new range of similarities can be entered as well:
ReferenceOpt.sh minK1 maxK1 minK2 maxK2 Assembly_Type Number_of_Processors minSim maxSim increment

For example, to scale between 0.95 and 0.99 using 0.005 increments:
ReferenceOpt.sh minK1 maxK1 minK2 maxK2 Assembly_Type Number_of_Processors 0.95 0.99 0.005
```


## ddocent_RefMapOpt.sh

### Tool Description
RefMapOpt

### Metadata
- **Docker Image**: quay.io/biocontainers/ddocent:2.9.8--hdfd78af_0
- **Homepage**: https://ddocent.com
- **Package**: https://anaconda.org/channels/bioconda/packages/ddocent/overview
- **Validation**: PASS

### Original Help Text
```text
Usage is RefMapOpt minK1 maxK1 minK2 maxK2 cluster_similarity Assembly_Type Num_of_Processors optional_list_of_individuals
```


## Metadata
- **Skill**: generated
