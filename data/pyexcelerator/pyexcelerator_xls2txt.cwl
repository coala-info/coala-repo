cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyexcelerator_xls2txt
label: pyexcelerator_xls2txt
doc: "The provided text does not contain help information for the tool; it is a log
  of a failed container build process.\n\nTool homepage: http://sourceforge.net/projects/pyexcelerator/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyexcelerator:0.6.4a--py27_2
stdout: pyexcelerator_xls2txt.out
