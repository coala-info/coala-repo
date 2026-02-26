cwlVersion: v1.2
class: CommandLineTool
baseCommand: svhip.py
label: svhip_index
doc: "Index SVHIP data\n\nTool homepage: https://github.com/chrisBioInf/Svhip"
inputs:
  - id: input_file
    type: File
    doc: The input directory or file (Required).
    inputBinding:
      position: 101
      prefix: --input
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svhip:1.0.9--hdfd78af_0
stdout: svhip_index.out
