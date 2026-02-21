cwlVersion: v1.2
class: CommandLineTool
baseCommand: pysvg
label: pysvg
doc: "A Python library to generate SVG files. (Note: The provided text is a container
  build log and does not contain CLI help documentation; therefore, no arguments could
  be extracted.)\n\nTool homepage: http://codeboje.de/pysvg/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pysvg:0.2.2--py27_0
stdout: pysvg.out
