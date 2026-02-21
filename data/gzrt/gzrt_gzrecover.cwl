cwlVersion: v1.2
class: CommandLineTool
baseCommand: gzrecover
label: gzrt_gzrecover
doc: "The gzip recovery toolkit (gzrt) is designed to recover data from corrupted
  gzip files. The gzrecover tool attempts to extract the uncompressed data from a
  damaged .gz file.\n\nTool homepage: https://www.urbanophile.com/arenn/hacking/gzrt"
inputs:
  - id: input_file
    type: File
    doc: The corrupted gzip file to recover data from.
    inputBinding:
      position: 1
  - id: patch
    type:
      - 'null'
      - boolean
    doc: Try to patch the corrupted file (experimental).
    inputBinding:
      position: 102
      prefix: -p
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Specify the output file for the recovered data.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gzrt:0.9.1--h577a1d6_0
