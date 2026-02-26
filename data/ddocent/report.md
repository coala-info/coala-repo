# ddocent CWL Generation Report

## ddocent_dDocent

### Tool Description
dDocent 2.9.8

### Metadata
- **Docker Image**: quay.io/biocontainers/ddocent:2.9.8--hdfd78af_0
- **Homepage**: https://ddocent.com
- **Package**: https://anaconda.org/channels/bioconda/packages/ddocent/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ddocent/overview
- **Total Downloads**: 116.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/jpuritz/dDocent
- **Stars**: N/A
### Original Help Text
```text
dDocent 2.9.8 

Contact jpuritz@uri.edu with any problems 

 
Checking for required software

All required software is installed!

dDocent version 2.9.8 started Wed Feb 25 06:22:11 AM UTC 2026 

0 individuals are detected. Is this correct? Enter yes or no and press [ENTER]
Incorrect Input
```


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

