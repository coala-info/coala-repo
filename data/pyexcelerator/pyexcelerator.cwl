cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyexcelerator
label: pyexcelerator
doc: "The provided text is a log of a failed container build process and does not
  contain help documentation or argument definitions for the tool.\n\nTool homepage:
  http://sourceforge.net/projects/pyexcelerator/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyexcelerator:0.6.4a--py27_2
stdout: pyexcelerator.out
