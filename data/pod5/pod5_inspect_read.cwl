cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pod5
  - inspect
  - read
label: pod5_inspect_read
doc: "Print detailed read information for a named read id\n\nTool homepage: https://github.com/nanoporetech/pod5-file-format"
inputs:
  - id: input_files
    type: File
    doc: Input pod5 file(s)
    inputBinding:
      position: 1
  - id: read_id
    type: string
    doc: Read id (UUID) to print
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pod5:0.3.33--pyhdfd78af_0
stdout: pod5_inspect_read.out
