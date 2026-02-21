cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyexcelerator_xls2html
label: pyexcelerator_xls2html
doc: "A tool to convert Excel (.xls) files to HTML format.\n\nTool homepage: http://sourceforge.net/projects/pyexcelerator/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyexcelerator:0.6.4a--py27_2
stdout: pyexcelerator_xls2html.out
