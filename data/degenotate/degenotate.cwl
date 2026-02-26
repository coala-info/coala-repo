cwlVersion: v1.2
class: CommandLineTool
baseCommand: degenotate
label: degenotate
doc: "A tool to annotate degeneracy (0-fold, 2-fold, 3-fold, and 4-fold sites) in
  a genome given an annotation and a genome file.\n\nTool homepage: https://github.com/harvardinformatics/degenotate"
inputs:
  - id: annotation
    type: File
    doc: The annotation file in GFF or GTF format.
    inputBinding:
      position: 101
      prefix: --ann
  - id: genome
    type: File
    doc: The genome file in FASTA format.
    inputBinding:
      position: 101
      prefix: --gen
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite the output directory if it already exists.
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress progress messages.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: write_sequences
    type:
      - 'null'
      - boolean
    doc: If provided, the tool will also output the extracted coding sequences.
    inputBinding:
      position: 101
      prefix: --seq
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: The directory to write output files to.
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/degenotate:1.3--pyhdfd78af_0
