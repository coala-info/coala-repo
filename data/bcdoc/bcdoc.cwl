cwlVersion: v1.2
class: CommandLineTool
baseCommand: bcdoc
label: bcdoc
doc: "A tool for generating documentation for BioContainers.\n\nTool homepage: https://github.com/boto/bcdoc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcdoc:0.16.0--py35_0
stdout: bcdoc.out
