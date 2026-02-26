cwlVersion: v1.2
class: CommandLineTool
baseCommand: emu collapse-taxonomy
label: emu_collapse-taxonomy
doc: "Collapse taxonomic ranks in emu output.\n\nTool homepage: https://gitlab.com/treangenlab/emu"
inputs:
  - id: input_path
    type: File
    doc: emu output filepath
    inputBinding:
      position: 1
  - id: rank
    type: string
    doc: collapsed taxonomic rank
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/emu:3.6.1--hdfd78af_0
stdout: emu_collapse-taxonomy.out
