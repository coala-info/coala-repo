cwlVersion: v1.2
class: CommandLineTool
baseCommand: [scrappie, event_table]
label: scrappie_event_table
doc: "Scrappie basecaller -- output table of events for read\n\nTool homepage: https://github.com/nanoporetech/scrappie"
inputs:
  - id: fast5_files
    type:
      type: array
      items: File
    doc: "Input fast5 files"
    inputBinding:
      position: 200
  - id: output
    type: ['null', string]
    doc: "Write to file rather than stdout"
    inputBinding:
      prefix: --output
  - id: segmentation
    type: ['null', string]
    doc: "Chunk size and percentile for variance based segmentation (chunk:percentile)"
    inputBinding:
      prefix: --segmentation
  - id: trim
    type: ['null', string]
    doc: "Number of events to trim, as start:end"
    inputBinding:
      prefix: --trim
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (used when --output is not set)
  - id: output_file
    type: ['null', File]
    doc: Output file written with --output
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scrappie:1.4.2--py310pl5321h9a1f509_7
stdout: scrappie_event_table.out
