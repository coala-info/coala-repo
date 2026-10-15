cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pod5
  - inspect
  - reads
label: pod5_inspect_reads
doc: "Print read information on all reads as a csv table\n\nTool homepage: https://github.com/nanoporetech/pod5-file-format"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input pod5 file(s)
    inputBinding:
      position: 1
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: Search for input files recursively matching `*.pod5`
    inputBinding:
      position: 102
      prefix: --recursive
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pod5:0.3.33--pyhdfd78af_0
stdout: pod5_inspect_reads.out
