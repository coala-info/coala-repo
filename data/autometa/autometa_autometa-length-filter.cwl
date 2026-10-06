cwlVersion: v1.2
class: CommandLineTool
baseCommand: autometa-length-filter
label: autometa_autometa-length-filter
doc: "This script handles filtering by length and can calculate various metagenome statistics.\n\nTool homepage: https://github.com/KwanLab/Autometa"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: assembly
    type: File
    doc: "Path to metagenome assembly (nucleotide fasta)."
    inputBinding:
      position: 1
      prefix: --assembly
  - id: output_fasta
    type: string
    doc: "Path to output length-filtered assembly fasta file."
    inputBinding:
      position: 1
      prefix: --output-fasta
  - id: output_stats
    type:
      - 'null'
      - string
    doc: "Path to output assembly stats table."
    inputBinding:
      position: 1
      prefix: --output-stats
  - id: output_gc_content
    type:
      - 'null'
      - string
    doc: "Path to output assembly contigs' GC content and length."
    inputBinding:
      position: 1
      prefix: --output-gc-content
  - id: cutoff
    type:
      - 'null'
      - int
    doc: "Cutoff to apply to length filter (default: 3000)"
    inputBinding:
      position: 1
      prefix: --cutoff
  - id: force
    type:
      - 'null'
      - boolean
    doc: "Overwrite existing files"
    inputBinding:
      position: 1
      prefix: --force
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Log more information to terminal."
    inputBinding:
      position: 1
      prefix: --verbose
outputs:
  - id: fasta_out
    type: File
    doc: "Length-filtered assembly"
    outputBinding:
      glob: "$(inputs.output_fasta)"
  - id: stats_out
    type: File?
    doc: "Assembly stats table"
    outputBinding:
      glob: "${ return inputs.output_stats ? inputs.output_stats : []; }"
  - id: gc_content_out
    type: File?
    doc: "Contig GC content and length table"
    outputBinding:
      glob: "${ return inputs.output_gc_content ? inputs.output_gc_content : []; }"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/autometa:2.2.3--pyh7e72e81_0
