cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastkit
label: fastkit
doc: "Fastkit is a toolkit for processing FASTQ files. (Note: The provided text is
  a container runtime error log and does not contain the tool's help documentation
  or argument definitions.)\n\nTool homepage: https://github.com/neoformit/fastkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastkit:1.0.2--pyhdfd78af_0
stdout: fastkit.out
