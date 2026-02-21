cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyexcelerator_xls2csv
label: pyexcelerator_xls2csv
doc: "A tool to convert Excel (.xls) files to CSV format. Note: The provided text
  contains container runtime logs and error messages rather than the tool's help documentation,
  so specific arguments could not be extracted.\n\nTool homepage: http://sourceforge.net/projects/pyexcelerator/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyexcelerator:0.6.4a--py27_2
stdout: pyexcelerator_xls2csv.out
