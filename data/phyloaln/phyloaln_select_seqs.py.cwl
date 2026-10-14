cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - select_seqs.py
label: phyloaln_select_seqs.py
doc: "Select (or exclude) species or sequences from the alignments in a directory.\n\nTool homepage: https://github.com/huangyh45/PhyloAln"
inputs:
  - id: input_dir
    type: Directory
    doc: "directory with the input FASTA alignments"
    inputBinding:
      position: 1
  - id: selected
    type: string
    doc: "selected species or sequences, separated by comma"
    inputBinding:
      position: 2
  - id: output_dir
    type: string
    doc: "output directory"
    inputBinding:
      position: 3
  - id: fasta_suffix
    type: string
    doc: "suffix of the FASTA files (default='.fa')"
    default: ".fa"
    inputBinding:
      position: 4
  - id: separate_symbol
    type: string
    doc: "separate symbol between species and sequence name (default='.')"
    default: "."
    inputBinding:
      position: 5
  - id: exclusion
    type:
      - 'null'
      - string
    doc: "give 1 to exclude the listed species or sequences instead of selecting them (default=no)"
    inputBinding:
      position: 6
outputs:
  - id: selected_dir
    type:
      - 'null'
      - Directory
    doc: "Selected alignments"
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
stdout: phyloaln_select_seqs.py.out
