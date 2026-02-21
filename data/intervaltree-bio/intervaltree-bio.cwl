cwlVersion: v1.2
class: CommandLineTool
baseCommand: intervaltree-bio
label: intervaltree-bio
doc: "A tool for handling interval trees in biological data (Note: The provided help
  text contains only system error messages and no usage information).\n\nTool homepage:
  https://github.com/konstantint/intervaltree-bio"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/intervaltree-bio:v1.0.1-3-deb-py3_cv1
stdout: intervaltree-bio.out
