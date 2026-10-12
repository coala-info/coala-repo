cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - PathogenTrack
  - filter
label: pathogentrack_filter
doc: "filter out low quality / complexity reads\n\nTool homepage: https://github.com/ncrna/PathogenTrack"
inputs:
  - id: input_reads
    type:
      - 'null'
      - File
    doc: input single-end fastq file produced by "extract" command (it is placed in
      the project folder)
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
  - id: complexity_threshold
    type:
      - 'null'
      - int
    doc: the threshold for low complexity filter [0-100], default is 30
    inputBinding:
      position: 101
      prefix: --complexity_threshold
  - id: filter_low_complexity
    type:
      - 'null'
      - boolean
    doc: enable filter out low complexity reads, default is False
    inputBinding:
      position: 101
      prefix: --filter_low_complexity
  - id: trim_poly_x
    type:
      - 'null'
      - boolean
    doc: enable polyA/T/C/G/N trimming in 3' ends
    inputBinding:
      position: 101
      prefix: --trim_poly_x
  - id: output
    type:
      - 'null'
      - string
    doc: file to output processed read to, default is reads_barcoded_clean.fq.gz
    default: reads_barcoded_clean.fq.gz
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: reads_clean
    type: File
    doc: filtered reads
    outputBinding:
      glob: $(inputs.project_id + '/' + inputs.output)
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
