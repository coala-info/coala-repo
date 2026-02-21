cwlVersion: v1.2
class: CommandLineTool
baseCommand: metamobilepicker
label: metamobilepicker
doc: "A tool for picking mobile genetic elements from metagenomic data (Note: The
  provided text is a container execution error log and does not contain the standard
  help documentation or argument list).\n\nTool homepage: https://gitlab.com/jkerkvliet/metamobilepicker"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metamobilepicker:0.7.3--pyhdfd78af_0
stdout: metamobilepicker.out
