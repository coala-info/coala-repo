cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pod5
  - inspect
  - summary
label: pod5_inspect_summary
doc: "Print a summary of the contents of pod5 files\n\nTool homepage: https://github.com/nanoporetech/pod5-file-format"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input pod5 file(s)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pod5:0.3.33--pyhdfd78af_0
stdout: pod5_inspect_summary.out
