cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - CAT_pack
  - add_names
label: cat_add_names
doc: "Add taxonomic names to CAT, BAT, or RAT output files.\n\nTool homepage: https://github.com/MGXlab/CAT_pack"
inputs:
  - id: input_file
    type: File
    doc: "Path to input file. Can be classification or ORF2LCA output file from CAT, BAT or RAT."
    inputBinding:
      position: 101
      prefix: --input_file
  - id: output_file
    type: string
    doc: "Path to output file."
    inputBinding:
      position: 101
      prefix: --output_file
  - id: taxonomy_folder
    type: Directory
    doc: "Path to directory that contains taxonomy files."
    inputBinding:
      position: 101
      prefix: --taxonomy_folder
  - id: only_official
    type:
      - 'null'
      - boolean
    doc: "Only output official taxonomic ranks (superkingdom, phylum, class, order, family, genus, species)."
    inputBinding:
      position: 101
      prefix: --only_official
  - id: exclude_scores
    type:
      - 'null'
      - boolean
    doc: "Do not include bit-score support scores in the lineage of a classification output file."
    inputBinding:
      position: 101
      prefix: --exclude_scores
  - id: force
    type:
      - 'null'
      - boolean
    doc: "Force overwrite existing files."
    inputBinding:
      position: 101
      prefix: --force
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Suppress verbosity."
    inputBinding:
      position: 101
      prefix: --quiet
outputs:
  - id: output
    type: File
    doc: "Output file with taxonomic names"
    outputBinding:
      glob: "$(inputs.output_file)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cat:6.0.1--hdfd78af_1
