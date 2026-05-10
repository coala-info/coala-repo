cwlVersion: v1.2
class: CommandLineTool
baseCommand: corsid
label: corsid
doc: "Identify and classify ORFs in a FASTA genome file.\n\nTool homepage: http://github.com/elkebir-group/CORSID"
inputs:
  - id: fasta
    type: File
    doc: FASTA genome file
    inputBinding:
      position: 101
      prefix: --fasta
  - id: gff
    type:
      - 'null'
      - File
    doc: GFF annotation file
    inputBinding:
      position: 101
      prefix: --gff
  - id: mismatch
    type:
      - 'null'
      - int
    doc: mismatch score
    inputBinding:
      position: 101
      prefix: --mismatch
  - id: name
    type:
      - 'null'
      - string
    doc: sample name
    inputBinding:
      position: 101
      prefix: --name
  - id: no_missing_classifier
    type:
      - 'null'
      - boolean
    doc: set flag to disable missing TRS-L classifier
    inputBinding:
      position: 101
      prefix: --no-missing-classifier
  - id: shrink
    type:
      - 'null'
      - float
    doc: "fraction of positions that may overlap between\n                       \
      \ consecutive genes"
    inputBinding:
      position: 101
      prefix: --shrink
  - id: tau_max
    type:
      - 'null'
      - int
    doc: maximum matching score threshold
    inputBinding:
      position: 101
      prefix: --tau_max
  - id: tau_min
    type:
      - 'null'
      - int
    doc: minimum matching score threshold
    inputBinding:
      position: 101
      prefix: --tau_min
  - id: window
    type:
      - 'null'
      - int
    doc: length of sliding window
    inputBinding:
      position: 101
      prefix: --window
  - id: output_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 102
      prefix: --output
  - id: output_gff3_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_gff3_path`
    inputBinding:
      position: 103
      prefix: --output-gff3
  - id: output_orf_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_orf_path`
    inputBinding:
      position: 104
      prefix: --output-orf
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output json file name
    outputBinding:
      glob: $(inputs.output_path)
  - id: output_orf
    type:
      - 'null'
      - File
    doc: "output identified ORFs (FASTA), only contains the\n                    \
      \    first solution"
    outputBinding:
      glob: $(inputs.output_orf_path)
  - id: output_gff3
    type:
      - 'null'
      - File
    doc: "output identified ORFs (FASTA), only contains the\n                    \
      \    first solution"
    outputBinding:
      glob: $(inputs.output_gff3_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/corsid:0.1.3--pyh5e36f6f_0
