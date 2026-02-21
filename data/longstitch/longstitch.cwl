cwlVersion: v1.2
class: CommandLineTool
baseCommand: longstitch
label: longstitch
doc: "LongStitch is a tool for scaffolding and misassembly correction using long reads.
  (Note: The provided help text contains only system error messages and no usage information.)\n
  \nTool homepage: https://bcgsc.ca/resources/software/longstitch"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/longstitch:1.0.5--hdfd78af_1
stdout: longstitch.out
