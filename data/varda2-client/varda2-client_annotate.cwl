cwlVersion: v1.2
class: CommandLineTool
baseCommand: varda2-client annotate
label: varda2-client_annotate
doc: "Annotate variants with sample information.\n\nTool homepage: https://github.com/varda/varda2-client"
inputs:
  - id: lab_sample_id
    type:
      - 'null'
      - string
    doc: Local sample id
    inputBinding:
      position: 101
      prefix: --lab-sample-id
  - id: sample_sheet
    type:
      - 'null'
      - File
    doc: 'Sample sheet file: sample_id, gvcf, vcf, bam'
    inputBinding:
      position: 101
      prefix: --sample-sheet
  - id: variants_file
    type:
      - 'null'
      - File
    doc: Varda variants file
    inputBinding:
      position: 101
      prefix: --variants-file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varda2-client:0.9--py_0
stdout: varda2-client_annotate.out
