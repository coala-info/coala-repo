cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dashing
  - printmat
label: dashing_printmat
doc: "Displays binary output (distance matrix written by dashing cmp --emit-binary)\n\
  \nTool homepage: https://github.com/dnbaker/dashing"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.binary_file)
        writable: true
inputs:
  - id: binary_file
    type: File
    doc: Binary distance matrix file
    inputBinding:
      position: 1
  - id: output_path
    type:
      - 'null'
      - string
    doc: 'Specify output file (default: stdout)'
    inputBinding:
      position: 102
      prefix: -o
  - id: scientific
    type:
      - 'null'
      - boolean
    doc: Emit in scientific notation
    inputBinding:
      position: 102
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output
    type:
      - 'null'
      - File
    doc: Human-readable matrix
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dashing:1.0--h5b0a936_3
stdout: dashing_printmat.out
