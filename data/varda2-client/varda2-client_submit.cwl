cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - varda2-client
  - submit
label: varda2-client_submit
doc: "Submit VCF or sample sheet to Varda\n\nTool homepage: https://github.com/varda/varda2-client"
inputs:
  - id: coverage_file
    type:
      - 'null'
      - File
    doc: Varda coverage file
    inputBinding:
      position: 101
      prefix: --coverage-file
  - id: disease_code
    type: string
    doc: Disease indication code
    inputBinding:
      position: 101
      prefix: --disease-code
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
stdout: varda2-client_submit.out
