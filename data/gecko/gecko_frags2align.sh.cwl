cwlVersion: v1.2
class: CommandLineTool
baseCommand: frags2align.sh
label: gecko_frags2align.sh
doc: "Converts a GECKO fragments file (.frags/.csv) into a text file with the alignments of the fragments.\n\nTool homepage: https://github.com/otorreno/gecko"
inputs:
  - id: frags_file
    type: File
    doc: "Input fragment file (.frags/.csv)"
    inputBinding:
      position: 1
  - id: fasta_x
    type: File
    doc: "First FASTA file (the query)"
    inputBinding:
      position: 2
  - id: fasta_y
    type: File
    doc: "Second FASTA file (the reference)"
    inputBinding:
      position: 3
  - id: alignments_name
    type: string
    doc: "Name of the output alignments file"
    inputBinding:
      position: 4
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: alignments_file
    type: File
    doc: Output alignment file
    outputBinding:
      glob: $(inputs.alignments_name)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.frags_file)
        writable: true
      - entry: $(inputs.fasta_x)
        writable: true
      - entry: $(inputs.fasta_y)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gecko:1.2--h7b50bb2_6
stdout: gecko_frags2align.sh.out
