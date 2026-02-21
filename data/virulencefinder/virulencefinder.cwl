cwlVersion: v1.2
class: CommandLineTool
baseCommand: virulencefinder
label: virulencefinder
doc: "A tool for identifying virulence genes in bacterial genomes. (Note: The provided
  text is a container execution error log and does not contain help documentation
  or argument definitions.)\n\nTool homepage: https://bitbucket.org/genomicepidemiology/virulencefinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virulencefinder:3.2.0--pyhdfd78af_0
stdout: virulencefinder.out
