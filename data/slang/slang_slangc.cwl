cwlVersion: v1.2
class: CommandLineTool
baseCommand: slangc
label: slang_slangc
doc: "The provided text does not contain help information for the tool; it appears
  to be a log of a failed container build process.\n\nTool homepage: https://github.com/shader-slang/slang"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slang:2.3.0--hd3527cb_3
stdout: slang_slangc.out
