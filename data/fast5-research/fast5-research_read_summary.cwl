cwlVersion: v1.2
class: CommandLineTool
baseCommand: read_summary
label: fast5-research_read_summary
doc: "Summarize reads stored in a Bulk .fast5\n\nTool homepage: https://github.com/nanoporetech/fast5_research"
inputs:
  - id: input
    type: File
    doc: Bulk .fast5 file for input.
    inputBinding:
      position: 101
  - id: output
    type: string
    doc: Output text file.
    inputBinding:
      position: 102
  - id: channel_range
    type:
      - 'null'
      - type: array
        items: int
    doc: Channel range (inclusive), two values.
    inputBinding:
      position: 1
      prefix: --channel_range
outputs:
  - id: summary
    type: File
    doc: Text file with the read summary.
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fast5-research:1.2.22--pyh864c0ab_0
