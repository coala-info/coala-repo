cwlVersion: v1.2
class: CommandLineTool
baseCommand: clinvar-this
label: clinvar-this
doc: "ClinVar submission tool (Note: The provided text contains container build error
  logs rather than command-line help documentation; therefore, no arguments could
  be extracted).\n\nTool homepage: https://github.com/bihealth/clinvar-this"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clinvar-this:0.18.5--pyhdfd78af_0
stdout: clinvar-this.out
