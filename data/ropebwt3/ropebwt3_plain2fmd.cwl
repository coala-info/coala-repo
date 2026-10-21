cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ropebwt3
  - plain2fmd
label: ropebwt3_plain2fmd
doc: "Convert plain text to FM-index\n\nTool homepage: https://github.com/lh3/ropebwt3"
inputs:
  - id: input_file
    type: File
    doc: Input plain text file
    inputBinding:
      position: 1
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: output FMD to FILE [stdout]
    inputBinding:
      position: 101
      prefix: -o
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (the FMD index when -o is not given)
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output FM-index file
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ropebwt3:3.10--h577a1d6_0
stdout: ropebwt3_plain2fmd.out
