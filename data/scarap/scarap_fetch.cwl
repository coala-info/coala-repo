cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scarap
  - fetch
label: scarap_fetch
doc: "Fetch sequences and store them in a fasta file per orthogroup.\n\nTool homepage: https://github.com/SWittouck/SCARAP"
inputs:
  - id: fasta_files
    type: Directory
    doc: "Folder with one fasta file with amino acid sequences (faa file) or one fasta file with nucleic acid sequences (ffn file) per genome"
    inputBinding:
      position: 1
  - id: pangenome
    type: File
    doc: "Input file with pangenome"
    inputBinding:
      position: 2
  - id: outfolder_path
    type: string
    doc: "Output folder"
    inputBinding:
      position: 3
  - id: cont
    type:
      - 'null'
      - boolean
    doc: "Continue in existing output folder"
    inputBinding:
      position: 102
      prefix: --cont
outputs:
  - id: outfolder
    type: Directory
    doc: "Output folder with one fasta file per orthogroup"
    outputBinding:
      glob: "$(inputs.outfolder_path)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scarap:1.0.2--pyhdfd78af_0
