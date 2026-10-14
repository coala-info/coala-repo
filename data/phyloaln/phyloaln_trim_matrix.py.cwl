cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - trim_matrix.py
label: phyloaln_trim_matrix.py
doc: "Trim alignments by removing columns (sites) and rows (species) with too few known characters.\n\nTool homepage: https://github.com/huangyh45/PhyloAln"
inputs:
  - id: input_dir
    type: Directory
    doc: "directory with the input FASTA alignments"
    inputBinding:
      position: 1
  - id: output_dir
    type: string
    doc: "output directory of the trimmed alignments"
    inputBinding:
      position: 2
  - id: unknown_symbol
    type: string
    doc: "unknown symbol (default='X')"
    default: "X"
    inputBinding:
      position: 3
  - id: known_percent_for_columns
    type: float
    doc: "minimum known percentage (>=1, as percent) or fraction (<1) of the characters in a column (default 50)"
    default: 50
    inputBinding:
      position: 4
  - id: known_percent_for_rows
    type: float
    doc: "minimum known percentage or fraction of the characters in a row (default 0)"
    default: 0
    inputBinding:
      position: 5
  - id: fasta_suffix
    type: string
    doc: "suffix of the input FASTA files (default='.fa')"
    default: ".fa"
    inputBinding:
      position: 6
outputs:
  - id: trimmed_dir
    type:
      - 'null'
      - Directory
    doc: "Trimmed alignments"
    outputBinding:
      glob: "$(inputs.output_dir)"
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyloaln:1.1.0--hdfd78af_0
stdout: phyloaln_trim_matrix.py.out
