cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqtk_hpc
label: seqtk_hpc
doc: "A tool for processing biological sequences (HPC version).\n\nTool homepage:
  https://github.com/lh3/seqtk"
inputs:
  - id: input_file
    type: File
    doc: Input sequence file or stream
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqtk:1.5--h577a1d6_1
stdout: seqtk_hpc.out
