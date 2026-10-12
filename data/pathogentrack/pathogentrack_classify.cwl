cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - PathogenTrack
  - classify
label: pathogentrack_classify
doc: "classify unmapped reads to taxons\n\nTool homepage: https://github.com/ncrna/PathogenTrack"
inputs:
  - id: kraken_db
    type: Directory
    doc: kraken2 database name
    inputBinding:
      position: 101
      prefix: --kraken_db
  - id: input_reads
    type:
      - 'null'
      - File
    doc: input single-end fastq file produced by "align" command (it is placed in the
      project folder)
    inputBinding:
      position: 101
      prefix: --input_reads
      valueFrom: "$(self ? self.basename : null)"
  - id: project_id
    type: string
    doc: project id to store output files
    inputBinding:
      position: 101
      prefix: --project_id
  - id: thread
    type:
      - 'null'
      - int
    doc: number of threads to use, default is 8
    inputBinding:
      position: 101
      prefix: --thread
  - id: confidence
    type:
      - 'null'
      - float
    doc: confidence threshold to use [0-1], default is 0.11
    inputBinding:
      position: 101
      prefix: --confidence
  - id: out_reads
    type:
      - 'null'
      - string
    doc: file to output processed reads to
    default: classified_reads.fq
    inputBinding:
      position: 101
      prefix: --out_reads
  - id: out_table
    type:
      - 'null'
      - string
    doc: file to output kraken results to
    default: classified_table.txt
    inputBinding:
      position: 101
      prefix: --out_table
  - id: out_report
    type:
      - 'null'
      - string
    doc: file to output kraken report to
    default: classified_report.txt
    inputBinding:
      position: 101
      prefix: --out_report
outputs:
  - id: classified_reads
    type: File
    doc: reads classified by kraken2
    outputBinding:
      glob: $(inputs.project_id + '/' + inputs.out_reads)
  - id: classified_table
    type: File
    doc: kraken2 result table
    outputBinding:
      glob: $(inputs.project_id + '/' + inputs.out_table)
  - id: classified_report
    type: File
    doc: kraken2 report
    outputBinding:
      glob: $(inputs.project_id + '/' + inputs.out_report)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.project_id)
        writable: true
        entry: "$({\"class\": \"Directory\", \"basename\": inputs.project_id, \"listing\": [inputs.input_reads]})"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pathogentrack:0.2.3--pyh5e36f6f_0
