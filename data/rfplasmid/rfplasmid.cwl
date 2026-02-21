cwlVersion: v1.2
class: CommandLineTool
baseCommand: rfplasmid
label: rfplasmid
doc: "A tool for plasmid identification (Note: The provided help text contains only
  system logs and error messages, no usage information was found).\n\nTool homepage:
  https://github.com/aldertzomer/RFPlasmid"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rfplasmid:0.0.18--pyhdfd78af_0
stdout: rfplasmid.out
