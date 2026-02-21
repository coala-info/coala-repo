cwlVersion: v1.2
class: CommandLineTool
baseCommand: rscape
label: rscape
doc: "The provided text does not contain help information for the tool 'rscape'. It
  appears to be a log of a failed container build/fetch process.\n\nTool homepage:
  http://eddylab.org/R-scape/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rscape:2.0.4.a--h503566f_1
stdout: rscape.out
