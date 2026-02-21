cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyloFit
label: phast_phyloFit
doc: "The provided text does not contain help information for the tool; it is a container
  execution error log reporting a failure to fetch or build the OCI image.\n\nTool
  homepage: http://compgen.cshl.edu/phast/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phast:1.9.6--h93e12ee_0
stdout: phast_phyloFit.out
