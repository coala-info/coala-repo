cwlVersion: v1.2
class: CommandLineTool
baseCommand: pod5_convert
label: pod5_convert
doc: "File conversion tools\n\nTool homepage: https://github.com/nanoporetech/pod5-file-format"
inputs:
  - id: input_format
    type: string
    doc: Input file format (fast5, from_fast5, to_fast5)
    inputBinding:
      position: 1
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pod5:0.3.33--pyhdfd78af_0
