cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastools
  - merge
label: fastools_merge
doc: "Merge two FASTA files.\n\nTool homepage: https://git.lumc.nl/j.f.j.laros/fastools"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: input files (exactly two)
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: output file
    inputBinding:
      position: 2
  - id: fill
    type:
      - 'null'
      - int
    doc: "Add 'N's between the reads (int default: 0)"
    inputBinding:
      position: 3
      prefix: -f
outputs:
  - id: out_output
    type:
      - 'null'
      - File
    doc: Merged FASTA file.
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
