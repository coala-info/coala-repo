cwlVersion: v1.2
class: CommandLineTool
baseCommand: stk2ct
label: conus_stk2ct
doc: "Convert the structures of a Stockholm file (CONUS format) into CT format.\n\nTool homepage: http://eddylab.org/software/conus/"
inputs:
  - id: seqfile_in
    type: File
    doc: Input sequence file
    inputBinding:
      position: 200
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/conus:1.0--h7b50bb2_6
stdout: conus_stk2ct.out
