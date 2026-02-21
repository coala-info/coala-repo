cwlVersion: v1.2
class: CommandLineTool
baseCommand: secimtools
label: secimtools
doc: "SECIMTools: A suite of python scripts for processing metabolomics data. (Note:
  The provided input text was an error log and did not contain CLI help information.)\n
  \nTool homepage: https://github.com/secimTools/SECIMTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/secimtools:22.3.23--pyhdfd78af_0
stdout: secimtools.out
