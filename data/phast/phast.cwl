cwlVersion: v1.2
class: CommandLineTool
baseCommand: phast
label: phast
doc: "Phylogenetic Analysis with Space/Time Models (Note: The provided text is an
  error log from a container build process and does not contain CLI help information
  or argument definitions.)\n\nTool homepage: http://compgen.cshl.edu/phast/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phast:1.9.6--h93e12ee_0
stdout: phast.out
