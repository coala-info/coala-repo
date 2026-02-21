cwlVersion: v1.2
class: CommandLineTool
baseCommand: mity
label: mity
doc: "A tool for mitochondrial variant calling. (Note: The provided text is a system
  error log regarding container execution and does not contain help documentation
  or argument definitions.)\n\nTool homepage: https://github.com/KCCG/mity"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mity:2.0.1--pyhdfd78af_0
stdout: mity.out
