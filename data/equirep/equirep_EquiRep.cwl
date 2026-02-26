cwlVersion: v1.2
class: CommandLineTool
baseCommand: ./EquiRep
label: equirep_EquiRep
doc: "This program processes an input FASTA file and generates an output file.\n\n\
  Tool homepage: https://github.com/Shao-Group/EquiRep"
inputs:
  - id: input_file
    type: File
    doc: Path to the input FASTA file.
    inputBinding:
      position: 1
  - id: output_file_prefix
    type: string
    doc: Prefix for the output FASTA file.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/equirep:1.0.0--h9948957_0
stdout: equirep_EquiRep.out
