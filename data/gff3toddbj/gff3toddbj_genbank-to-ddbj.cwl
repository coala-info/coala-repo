cwlVersion: v1.2
class: CommandLineTool
baseCommand: genbank-to-ddbj
label: gff3toddbj_genbank-to-ddbj
doc: "Convert a GenBank file to the DDBJ annotation format.\n\nTool homepage: https://github.com/yamaton/gff3toddbj"
inputs:
  - id: gbk
    type:
      - 'null'
      - File
    doc: "Input GenBank file"
    inputBinding:
      position: 101
      prefix: --gbk
  - id: metadata
    type:
      - 'null'
      - File
    doc: "Input metadata in TOML describing COMMON and other entries"
    inputBinding:
      position: 101
      prefix: --metadata
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Prefix of locus_tag. See https://www.ddbj.nig.ac.jp/ddbj/locus_tag-e.html"
    inputBinding:
      position: 101
      prefix: --prefix
  - id: transl_table
    type:
      - 'null'
      - int
    doc: "Genetic Code ID. 1 by default, and 11 for bacteria."
    inputBinding:
      position: 101
      prefix: --transl_table
  - id: config_filter
    type:
      - 'null'
      - File
    doc: "A set of Feature-Qualifier pairs allowed in the output."
    inputBinding:
      position: 101
      prefix: --config_filter
  - id: output_file_path
    type: string
    doc: "Specify annotation file name as output"
    inputBinding:
      position: 101
      prefix: --out
  - id: log
    type:
      - 'null'
      - string
    doc: "[debug] Choose log level from (DEBUG, INFO, WARNING, ERROR) (default: INFO)."
    inputBinding:
      position: 101
      prefix: --log
outputs:
  - id: output_file
    type: File
    doc: "DDBJ annotation file"
    outputBinding:
      glob: "$(inputs.output_file_path)"
  - id: stdout
    type: stdout
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gff3toddbj:0.4.3--pyhdfd78af_0
stdout: gff3toddbj_genbank-to-ddbj.out
