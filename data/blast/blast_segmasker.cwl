cwlVersion: v1.2
class: CommandLineTool
baseCommand: segmasker
label: blast_segmasker
doc: Low complexity region masker based on the SEG algorithm
inputs:
  - id: input_file
    type: File
    doc: input file name
    inputBinding:
      position: 101
      prefix: -in
  - id: output_file
    type: string
    doc: output file name
    inputBinding:
      position: 101
      prefix: -out
  - id: input_format
    type:
      - 'null'
      - string
    doc: controls the format of the masker input
    inputBinding:
      position: 101
      prefix: -infmt
  - id: parse_seqids
    type:
      - 'null'
      - boolean
    doc: Parse Seq-ids in FASTA input
    inputBinding:
      position: 101
      prefix: -parse_seqids
  - id: output_format
    type:
      - 'null'
      - string
    doc: controls the format of the masker output
    inputBinding:
      position: 101
      prefix: -outfmt
  - id: window
    type:
      - 'null'
      - int
    doc: SEG window
    inputBinding:
      position: 101
      prefix: -window
  - id: locut
    type:
      - 'null'
      - float
    doc: SEG locut
    inputBinding:
      position: 101
      prefix: -locut
  - id: hicut
    type:
      - 'null'
      - float
    doc: SEG hicut
    inputBinding:
      position: 101
      prefix: -hicut
outputs:
  - id: output_output_file
    type:
      - 'null'
      - File
    doc: output file name
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blast:2.17.0--h66d330f_0
s:url: https://blast.ncbi.nlm.nih.gov/doc/blast-help/
$namespaces:
  s: https://schema.org/
