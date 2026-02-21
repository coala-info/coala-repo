cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - svtools
  - bedpetobed12
label: svtools_svtools bedpetobed12
doc: "Convert BEDPE files to BED12 format. (Note: The provided help text contains
  only container runtime error messages and does not list specific arguments.)\n\n
  Tool homepage: https://github.com/hall-lab/svtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svtools:0.5.1--py_0
stdout: svtools_svtools bedpetobed12.out
