cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scarap
  - search
label: scarap_search
doc: "Search query genes in a profile database.\n\nTool homepage: https://github.com/SWittouck/SCARAP"
inputs:
  - id: faa_files
    type: Directory
    doc: "Folder with one fasta file with amino acid sequences (faa file) per genome"
    inputBinding:
      position: 1
  - id: db
    type: Directory
    doc: "Input database containing alignments and profile score cutoffs"
    inputBinding:
      position: 2
  - id: outfolder_path
    type: string
    doc: "Output folder"
    inputBinding:
      position: 3
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use"
    inputBinding:
      position: 101
      prefix: --threads
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
    doc: "Output folder with the search results"
    outputBinding:
      glob: "$(inputs.outfolder_path)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scarap:1.0.2--pyhdfd78af_0
