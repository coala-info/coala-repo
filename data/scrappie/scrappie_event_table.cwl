cwlVersion: v1.2
class: CommandLineTool
baseCommand: event_table
label: scrappie_event_table
doc: "Scrappie basecaller -- basecall via events\n\nTool homepage: https://github.com/nanoporetech/scrappie"
inputs:
  - id: fast5_files
    type:
      type: array
      items: File
    doc: FAST5 files to process
    inputBinding:
      position: 1
  - id: licence
    type:
      - 'null'
      - boolean
    doc: Print licensing information
    inputBinding:
      position: 102
      prefix: --licence
  - id: license
    type:
      - 'null'
      - boolean
    doc: Print licensing information
    inputBinding:
      position: 102
      prefix: --license
  - id: segmentation
    type:
      - 'null'
      - string
    doc: Chunk size and percentile for variance based segmentation
    inputBinding:
      position: 102
      prefix: --segmentation
  - id: trim
    type:
      - 'null'
      - string
    doc: Number of events to trim, as start:end
    inputBinding:
      position: 102
      prefix: --trim
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Write to file rather than stdout
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scrappie:1.4.2--py310pl5321h9a1f509_7
