cwlVersion: v1.2
class: CommandLineTool
baseCommand: halfdeep_halfdeep.sh
label: halfdeep_halfdeep.sh
doc: "halfdeep_halfdeep.sh (Note: The provided help text contains only system error
  messages and no usage information.)\n\nTool homepage: https://github.com/richard-burhans/HalfDeep"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/halfdeep:0.1.0--hdfd78af_1
stdout: halfdeep_halfdeep.sh.out
