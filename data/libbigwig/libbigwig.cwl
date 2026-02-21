cwlVersion: v1.2
class: CommandLineTool
baseCommand: libbigwig
label: libbigwig
doc: "A C library for handling bigWig files. Note: The provided text appears to be
  a container runtime error log rather than CLI help text, so no arguments could be
  extracted.\n\nTool homepage: https://github.com/dpryan79/libBigWig"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/libbigwig:0.4.8--h44aa6d8_0
stdout: libbigwig.out
