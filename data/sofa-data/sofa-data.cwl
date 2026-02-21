cwlVersion: v1.2
class: CommandLineTool
baseCommand: sofa-data
label: sofa-data
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a log of a failed container image build/fetch process.\n\n
  Tool homepage: https://github.com/danielsaban/data-scraping-sofascore"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sofa-data:v1.0beta4-12-deb_cv1
stdout: sofa-data.out
