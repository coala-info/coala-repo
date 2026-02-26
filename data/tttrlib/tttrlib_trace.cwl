cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tttrlib
  - trace
label: tttrlib_trace
doc: "Trace processing (correlation, burst selection, burst analysis, ...)\n\nTool
  homepage: https://github.com/fluorescence-tools/tttrlib"
inputs:
  - id: command
    type: string
    doc: The command to run
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tttrlib:0.25.1--py312hd82e9f0_1
stdout: tttrlib_trace.out
