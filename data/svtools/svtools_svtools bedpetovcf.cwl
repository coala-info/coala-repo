cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - svtools
  - bedpetovcf
label: svtools_svtools bedpetovcf
doc: "Convert BEDPE files to VCF format\n\nTool homepage: https://github.com/hall-lab/svtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svtools:0.5.1--py_0
stdout: svtools_svtools bedpetovcf.out
