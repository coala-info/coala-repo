cwlVersion: v1.2
class: CommandLineTool
baseCommand: R-scape
label: rscape_R-scape
doc: "The provided text does not contain help information for the tool. It appears
  to be a log of a failed container build process.\n\nTool homepage: http://eddylab.org/R-scape/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rscape:2.0.4.a--h503566f_1
stdout: rscape_R-scape.out
