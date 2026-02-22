cwlVersion: v1.2
class: CommandLineTool
baseCommand: consensuscore2
label: consensuscore2
doc: "ConsensusCore2 is a library for PacBio consensus algorithms (Note: The provided
  text contains system error messages regarding container image retrieval and does
  not contain help documentation or argument definitions).\n\nTool homepage: https://github.com/Global-localhost/ConsensusCore2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/consensuscore2:v3.3.0dfsg-2.1-deb-py2_cv1
stdout: consensuscore2.out
