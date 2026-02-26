cwlVersion: v1.2
class: CommandLineTool
baseCommand: rtg
label: rtg-tools_rtg
doc: "RTG-Tools command-line interface. Type 'rtg help COMMAND' for help on a specific
  command.\n\nTool homepage: https://github.com/RealTimeGenomics/rtg-tools"
inputs:
  - id: command
    type: string
    doc: The command to execute
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: Options for the specified command
    inputBinding:
      position: 2
  - id: rtg_mem
    type:
      - 'null'
      - string
    doc: Set maximum memory use (e.g., 16G)
    inputBinding:
      position: 103
      prefix: RTG_MEM
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
stdout: rtg-tools_rtg.out
