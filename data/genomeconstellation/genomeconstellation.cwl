cwlVersion: v1.2
class: CommandLineTool
baseCommand: genomeconstellation
label: genomeconstellation
doc: "GenomeConstellation (Note: The provided text is an error log from a container
  runtime and does not contain help documentation or argument definitions.)\n\nTool
  homepage: https://bitbucket.org/berkeleylab/jgi-genomeconstellation"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomeconstellation:0.21.1--h077b44d_7
stdout: genomeconstellation.out
