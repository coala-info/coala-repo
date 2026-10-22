cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - miraligner
label: seqbuster_miraligner
doc: "miraligner is a tool for microRNA alignment and isomiR identification.\n\nTool
  homepage: https://github.com/lpantano/seqbuster"
inputs:
  - id: addition_nts
    type:
      - 'null'
      - int
    doc: nt allowed for addition processes
    inputBinding:
      position: 101
      prefix: -add
  - id: database
    type: Directory
    doc: database folder containing miRBase files
    inputBinding:
      position: 101
      prefix: -db
  - id: debug
    type:
      - 'null'
      - boolean
    doc: add verbosity
    inputBinding:
      position: 101
      prefix: -debug
  - id: format
    type:
      - 'null'
      - string
    doc: format input
    inputBinding:
      position: 101
      prefix: -format
  - id: freq
    type:
      - 'null'
      - boolean
    doc: add freq information
    inputBinding:
      position: 101
      prefix: -freq
  - id: input
    type: File
    doc: input read sequence file
    inputBinding:
      position: 101
      prefix: -i
  - id: min_length
    type:
      - 'null'
      - int
    doc: minimum size
    inputBinding:
      position: 101
      prefix: -minl
  - id: precursor
    type:
      - 'null'
      - boolean
    doc: add reads mapping to precursor
    inputBinding:
      position: 101
      prefix: -pre
  - id: species
    type: string
    doc: three letter code for species (e.g., hsa)
    inputBinding:
      position: 101
      prefix: -s
  - id: substitution_nts
    type:
      - 'null'
      - int
    doc: nt allowed for substitution processes
    inputBinding:
      position: 101
      prefix: -sub
  - id: trimming_nts
    type:
      - 'null'
      - int
    doc: nt allowed for trimming processes
    inputBinding:
      position: 101
      prefix: -trim
  - id: output_path
    type: string
    doc: Output prefix; the tool writes <output>.mirna, <output>.mirna.opt and <output>.mirna.nomap
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: output
    type: File
    doc: Annotated isomiR table (<output>.mirna)
    outputBinding:
      glob: $(inputs.output_path).mirna
  - id: track_file
    type:
      - 'null'
      - File
    doc: Track file with information about the process (<output>.mirna.opt)
    outputBinding:
      glob: $(inputs.output_path).mirna.opt
  - id: nomap_file
    type:
      - 'null'
      - File
    doc: Sequences that could not be annotated (<output>.mirna.nomap)
    outputBinding:
      glob: $(inputs.output_path).mirna.nomap
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqbuster:3.5--0
