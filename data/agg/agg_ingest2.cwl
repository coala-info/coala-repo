cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - agg
  - ingest2
label: agg_ingest2
doc: "merges single sample agg files into an agg chunk\n\nTool homepage: https://github.com/Illumina/agg"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: single sample agg files to merge
    inputBinding:
      position: 1
  - id: list_file
    type:
      - 'null'
      - File
    doc: plain text file listing agg chunks to merge
    inputBinding:
      position: 102
      prefix: --list
  - id: threads
    type:
      - 'null'
      - int
    doc: number of compression threads
    inputBinding:
      position: 102
      prefix: --thread
outputs:
  - id: output_prefix
    type: File
    doc: agg will output output_prefix.bcf and output_prefix.dpt
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/agg:0.3.6--hd28b015_0
