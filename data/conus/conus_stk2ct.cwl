cwlVersion: v1.2
class: CommandLineTool
baseCommand: givect
label: conus_stk2ct
doc: "A tool to process sequence files, likely converting or extracting vector information
  from sequence alignment files.\n\nTool homepage: http://eddylab.org/software/conus/"
inputs:
  - id: seqfile_in
    type: File
    doc: Input sequence file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/conus:1.0--h7b50bb2_6
stdout: conus_stk2ct.out
