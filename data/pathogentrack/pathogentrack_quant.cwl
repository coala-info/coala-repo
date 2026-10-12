cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - PathogenTrack
  - quant
label: pathogentrack_quant
doc: "deduplication and quantification of microbes at single-cell levels\n\nTool homepage: https://github.com/ncrna/PathogenTrack"
inputs:
  - id: barcode
    type: File
    doc: file name for valid barcodes (a file made by trim, placed in the project
      folder)
    inputBinding:
      position: 101
      prefix: --barcode
      valueFrom: "$(self ? self.basename : null)"
  - id: input_reads
    type: File
    doc: input fastq file produced by "classify" command (it is placed in the project
      folder)
    inputBinding:
      position: 101
      prefix: --input_reads
      valueFrom: "$(self ? self.basename : null)"
  - id: input_table
    type: File
    doc: input table file produced by "classify" command (it is placed in the project
      folder)
    inputBinding:
      position: 101
      prefix: --input_table
      valueFrom: "$(self ? self.basename : null)"
  - id: input_report
    type: File
    doc: input report file produced by "classify" command (it is placed in the
      project folder)
    inputBinding:
      position: 101
      prefix: --input_report
      valueFrom: "$(self ? self.basename : null)"
  - id: project_id
    type: string
    doc: project id to store output files
    inputBinding:
      position: 101
      prefix: --project_id
  - id: min_reads
    type:
      - 'null'
      - int
    doc: minimum number of reads that supports the taxonomy, default is 10
    inputBinding:
      position: 101
      prefix: --min_reads
  - id: output_reads
    type:
      - 'null'
      - string
    doc: file to output classified reads to, default is microbes.fa
    default: microbes.fa
    inputBinding:
      position: 101
      prefix: --output_reads
  - id: output_matrix
    type:
      - 'null'
      - string
    doc: file to output microbe quantification matrix to, default is microbes.tsv
    default: microbes.tsv
    inputBinding:
      position: 101
      prefix: --output_matrix
outputs:
  - id: microbes_reads
    type: File
    doc: classified microbe reads
    outputBinding:
      glob: $(inputs.project_id + '/' + inputs.output_reads)
  - id: microbes_matrix
    type: File
    doc: microbe quantification matrix
    outputBinding:
      glob: $(inputs.project_id + '/' + inputs.output_matrix)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.project_id)
        writable: true
        entry: "$({\"class\": \"Directory\", \"basename\": inputs.project_id, \"listing\": [inputs.barcode, inputs.input_reads, inputs.input_table, inputs.input_report]})"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pathogentrack:0.2.3--pyh5e36f6f_0
