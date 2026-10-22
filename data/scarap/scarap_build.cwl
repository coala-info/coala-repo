cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scarap
  - build
label: scarap_build
doc: "Build a profile database for a core genome or pangenome.\n\nTool homepage: https://github.com/SWittouck/SCARAP"
inputs:
  - id: faa_files
    type: Directory
    doc: "Folder with one fasta file with amino acid sequences (faa file) per genome"
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
  - id: core_prefilter
    type:
      - 'null'
      - float
    doc: "Minimum relative frequency of single-copy presence to be used for initial database construction"
    inputBinding:
      position: 107
      prefix: --core-prefilter
  - id: core_filter
    type:
      - 'null'
      - float
    doc: "Minimum relative frequency of single-copy presence to be used for the final selection"
    inputBinding:
      position: 108
      prefix: --core-filter
  - id: max_core_genes
    type:
      - 'null'
      - int
    doc: "Maximum number of core genes to retrieve (0 = no maximum, default 0)"
    inputBinding:
      position: 109
      prefix: --max-core-genes
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
    doc: "Output folder with the profile database"
    outputBinding:
      glob: "$(inputs.outfolder_path)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scarap:1.0.2--pyhdfd78af_0
