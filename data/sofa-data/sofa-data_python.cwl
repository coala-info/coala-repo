cwlVersion: v1.2
class: CommandLineTool
baseCommand: sofa-data
label: sofa-data_python
doc: "The provided text is a log of a failed container build process and does not
  contain help information, descriptions, or argument definitions for the tool.\n\n
  Tool homepage: https://github.com/danielsaban/data-scraping-sofascore"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sofa-data:v1.0beta4-12-deb_cv1
stdout: sofa-data_python.out
