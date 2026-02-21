cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - svtools
  - lsort
label: svtools_svtools lsort
doc: "The provided text does not contain help information for svtools lsort. It contains
  container execution logs and a fatal error message.\n\nTool homepage: https://github.com/hall-lab/svtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svtools:0.5.1--py_0
stdout: svtools_svtools lsort.out
