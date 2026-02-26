# gxformat2 CWL Generation Report

## gxformat2_gxwf-lint

### Tool Description
Lint a workflow file.

### Metadata
- **Docker Image**: quay.io/biocontainers/gxformat2:0.22.0--pyhdfd78af_0
- **Homepage**: https://github.com/jmchilton/gxformat2
- **Package**: https://anaconda.org/channels/bioconda/packages/gxformat2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gxformat2/overview
- **Total Downloads**: 78.0K
- **Last updated**: 2026-02-20
- **GitHub**: https://github.com/jmchilton/gxformat2
- **Stars**: N/A
### Original Help Text
```text
usage: gxwf-lint [-h] [--training-topic TRAINING_TOPIC] PATH

positional arguments:
  PATH                  workflow path

options:
  -h, --help            show this help message and exit
  --training-topic TRAINING_TOPIC
                        If this is a training workflow, specify a training
                        topic.
```


## gxformat2_gxwf-viz

### Tool Description
This script converts an executable Galaxy workflow (in either format - Format 2 or native .ga) into a format for visualization with Cytoscape (https://cytoscape.org/). If the target output path ends with .html this script will output a HTML page with the workflow visualized using cytoscape.js. Otherwise, this script will output a JSON description of the workflow elements for consumption by Cytoscape.

### Metadata
- **Docker Image**: quay.io/biocontainers/gxformat2:0.22.0--pyhdfd78af_0
- **Homepage**: https://github.com/jmchilton/gxformat2
- **Package**: https://anaconda.org/channels/bioconda/packages/gxformat2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gxwf-viz [-h] INPUT [OUTPUT]

This script converts an executable Galaxy workflow (in either format - Format
2 or native .ga) into a format for visualization with Cytoscape
(https://cytoscape.org/). If the target output path ends with .html this
script will output a HTML page with the workflow visualized using
cytoscape.js. Otherwise, this script will output a JSON description of the
workflow elements for consumption by Cytoscape.

positional arguments:
  INPUT       input workflow path (.ga/gxwf.yml)
  OUTPUT      output viz path (.json/.html)

options:
  -h, --help  show this help message and exit
```


## gxformat2_gxwf-abstract-export

### Tool Description
This script converts an executable Galaxy workflow (in either format - Format 2 or native .ga) into an abstract CWL representation. In order to represent Galaxy tool executions in the Common Workflow Language workflow language, they are serialized as v1.2+ abstract 'Operation' classes. Because abstract 'Operation' classes are used, the resulting CWL workflow is not executable - either in Galaxy or by CWL implementations. The resulting CWL file should be thought of more as a common metadata specification describing the workflow structure.

### Metadata
- **Docker Image**: quay.io/biocontainers/gxformat2:0.22.0--pyhdfd78af_0
- **Homepage**: https://github.com/jmchilton/gxformat2
- **Package**: https://anaconda.org/channels/bioconda/packages/gxformat2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gxwf-abstract-export [-h] INPUT [OUTPUT]

This script converts an executable Galaxy workflow (in either format - Format
2 or native .ga) into an abstract CWL representation. In order to represent
Galaxy tool executions in the Common Workflow Language workflow language, they
are serialized as v1.2+ abstract 'Operation' classes. Because abstract
'Operation' classes are used, the resulting CWL workflow is not executable -
either in Galaxy or by CWL implementations. The resulting CWL file should be
thought of more as a common metadata specification describing the workflow
structure.

positional arguments:
  INPUT       input workflow path (.ga/gxwf.yml)
  OUTPUT      output workflow path (.cwl)

options:
  -h, --help  show this help message and exit
```

