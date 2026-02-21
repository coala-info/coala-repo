cwlVersion: v1.2
class: CommandLineTool
baseCommand: homopolish
label: homopolish
doc: "A tool for polishing genome assemblies (Note: The provided text is an error
  message and does not contain usage instructions or argument definitions).\n\nTool
  homepage: https://github.com/ythuang0522/homopolish"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/homopolish:0.4.2--pyhdfd78af_0
stdout: homopolish.out
