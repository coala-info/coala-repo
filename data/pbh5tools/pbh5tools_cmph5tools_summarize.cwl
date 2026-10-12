cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cmph5tools.py
  - summarize
label: pbh5tools_cmph5tools_summarize
doc: "Summarize cmp.h5 files.\n\nTool homepage: https://github.com/PacificBiosciences/pbh5tools"
inputs:
  - id: input_cmp_h5
    type:
      type: array
      items: File
    doc: cmp.h5 files to summarize
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
stdout: pbh5tools_cmph5tools_summarize_stdout.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbh5tools:0.8.0--py27h470a237_1
