cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - test_effect.py
label: phyloaln_test_effect.py
doc: "Compare the aligned sequences of a species (or sequence) in a target directory with those in a reference directory.\n\nTool homepage: https://github.com/huangyh45/PhyloAln"
inputs:
  - id: reference_dir
    type: Directory
    doc: "reference directory of FASTA alignments"
    inputBinding:
      position: 1
      valueFrom: "$(self.path):$(inputs.reference_name)"
  - id: reference_name
    type: string
    doc: "species or sequence name to use in the reference directory"
  - id: target_dir
    type: Directory
    doc: "target directory of FASTA alignments"
    inputBinding:
      position: 2
      valueFrom: "$(self.path):$(inputs.target_name)"
  - id: target_name
    type: string
    doc: "species or sequence name to use in the target directory"
  - id: output_tsv
    type: string
    doc: "output TSV file"
    inputBinding:
      position: 3
  - id: unknown_symbol
    type: string
    doc: "unknown symbol (default='N')"
    default: "N"
    inputBinding:
      position: 4
  - id: separate_symbol
    type: string
    doc: "separate symbol (default='.')"
    default: "."
    inputBinding:
      position: 5
  - id: fasta_suffix
    type: string
    doc: "suffix of the FASTA files (default='.fa')"
    default: ".fa"
    inputBinding:
      position: 6
  - id: selected_species
    type:
      - 'null'
      - string
    doc: "selected species or sequences, separated by comma"
    inputBinding:
      position: 7
outputs:
  - id: output_table
    type:
      - 'null'
      - File
    doc: "Comparison table"
    outputBinding:
      glob: "$(inputs.output_tsv)"
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyloaln:1.1.0--hdfd78af_0
stdout: phyloaln_test_effect.py.out
