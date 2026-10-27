cwlVersion: v1.2
class: CommandLineTool
baseCommand: bam_accuracy.py
label: wub_bam_accuracy.py
doc: "Produce accuracy statistics of the input BAM file. Calculates global accuracy
  and identity and various per-read statistics. The input BAM file must be sorted
  by coordinates and indexed.\n\nTool homepage: https://github.com/nanoporetech/wub"
inputs:
  - id: bam
    type: File
    secondaryFiles:
      - .bai
    doc: Input BAM file.
    inputBinding:
      position: 1
  - id: aqual
    type:
      - 'null'
      - int
    doc: Minimum alignment quality
    inputBinding:
      position: 102
      prefix: -q
  - id: bam_tag
    type:
      - 'null'
      - string
    doc: Dataset tag (BAM basename).
    inputBinding:
      position: 102
      prefix: -t
  - id: global_tsv
    type:
      - 'null'
      - string
    doc: Tab separated file to save global statistics
    inputBinding:
      position: 102
      prefix: -g
  - id: include_clips
    type:
      - 'null'
      - boolean
    doc: Include hard and soft clipps in alignment length when calculating 
      accuracy
    inputBinding:
      position: 102
      prefix: -e
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Be quiet and do not print progress bar
    inputBinding:
      position: 102
      prefix: -Q
  - id: read_tsv
    type:
      - 'null'
      - string
    doc: Tab separated file to save per-read statistics
    inputBinding:
      position: 102
      prefix: -l
  - id: region
    type:
      - 'null'
      - string
    doc: BAM region
    inputBinding:
      position: 102
      prefix: -c
  - id: report_pdf
    type:
      - 'null'
      - string
    doc: Report PDF
    inputBinding:
      position: 102
      prefix: -r
  - id: results_pickle
    type:
      - 'null'
      - string
    doc: Save pickled results in this file
    inputBinding:
      position: 102
      prefix: -p
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: global_tsv_file
    type:
      - 'null'
      - File
    doc: Global statistics table
    outputBinding:
      glob: $(inputs.global_tsv)
  - id: read_tsv_file
    type:
      - 'null'
      - File
    doc: Per-read statistics table
    outputBinding:
      glob: $(inputs.read_tsv)
  - id: report_pdf_file
    type:
      - 'null'
      - File
    doc: Report PDF
    outputBinding:
      glob: '${ return inputs.report_pdf ? inputs.report_pdf : "bam_accuracy.pdf"; }'
  - id: results_pickle_file
    type:
      - 'null'
      - File
    doc: Pickled results
    outputBinding:
      glob: $(inputs.results_pickle)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
stdout: wub_bam_accuracy.py.out
