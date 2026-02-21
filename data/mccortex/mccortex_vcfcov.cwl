cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mccortex
  - vcfcov
label: mccortex_vcfcov
doc: "The provided text does not contain help information for mccortex_vcfcov; it
  is an error log indicating a failure to build a container image due to lack of disk
  space.\n\nTool homepage: https://github.com/mcveanlab/mccortex"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mccortex:1.0--h24782f9_7
stdout: mccortex_vcfcov.out
