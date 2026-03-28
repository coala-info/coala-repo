# halfdeep CWL Generation Report

## halfdeep_bam_depth.sh

### Tool Description
Assumes we have <ref> and input.fofn in the current dir

### Metadata
- **Docker Image**: quay.io/biocontainers/halfdeep:0.1.0--hdfd78af_1
- **Homepage**: https://github.com/richard-burhans/HalfDeep
- **Package**: https://anaconda.org/channels/bioconda/packages/halfdeep/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/halfdeep/overview
- **Total Downloads**: 673
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/richard-burhans/HalfDeep
- **Stars**: N/A
### Original Help Text
```text
Usage: ./bam_depth <ref> [<number>]
    Assumes we have <ref> and input.fofn in the current dir
    If <number> is not given, SLURM_ARRAY_TASK_ID is used
    <number> is the line number in input.fofn of the file to process
```


## halfdeep_halfdeep.sh

### Tool Description
Assumes we have <ref>.lengths and <input.fofn> in the same dir

### Metadata
- **Docker Image**: quay.io/biocontainers/halfdeep:0.1.0--hdfd78af_1
- **Homepage**: https://github.com/richard-burhans/HalfDeep
- **Package**: https://anaconda.org/channels/bioconda/packages/halfdeep/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ./halfdeep <ref>
    Assumes we have <ref>.lengths and <input.fofn> in the same dir
```


## Metadata
- **Skill**: generated
