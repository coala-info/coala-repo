cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cressent
  - sl_finder
label: cressent_sl_finder
doc: "A module for putative stem-loop annotation.\n\nTool homepage: https://github.com/ricrocha82/cressent"
inputs:
  - id: input_fasta
    type: File
    doc: "Input FASTA file"
    inputBinding:
      position: 101
      prefix: --input_fasta
  - id: gff_in
    type: File
    doc: "Input GFF/GTF file"
    inputBinding:
      position: 101
      prefix: --gff_in
  - id: out_gff
    type: string
    doc: "Output GFF filename"
    inputBinding:
      position: 101
      prefix: --out_gff
  - id: output_dir
    type: string
    doc: "Path to the output directory (created by the tool; collected as the output)"
    inputBinding:
      position: 101
      prefix: --output
  - id: csv_out
    type:
      - 'null'
      - string
    doc: "Output CSV filename"
    inputBinding:
      position: 101
      prefix: --csv_out
  - id: motif
    type:
      - 'null'
      - string
    doc: "Conserved motif (default = nantantan)"
    inputBinding:
      position: 101
      prefix: --motif
  - id: family
    type:
      - 'null'
      - string
    doc: "CRESS viral family: geminiviridae, genomoviridae, smacoviridae, cycloviridae, circoviridae or general"
    inputBinding:
      position: 101
      prefix: --family
  - id: idealstemlen
    type:
      - 'null'
      - int
    doc: "Ideal stem length (default = 11)"
    inputBinding:
      position: 101
      prefix: --idealstemlen
  - id: ideallooplen
    type:
      - 'null'
      - int
    doc: "Ideal loop length (default = 11)"
    inputBinding:
      position: 101
      prefix: --ideallooplen
  - id: frame
    type:
      - 'null'
      - int
    doc: "Bases around motif for folding (default = 15)"
    inputBinding:
      position: 101
      prefix: --frame
outputs:
  - id: output
    type: Directory
    doc: Output directory with all result files
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cressent:1.0.2--pyhdfd78af_0
