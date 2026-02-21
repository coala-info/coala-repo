cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqbuster_adrec
label: seqbuster_adrec
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log related to a container image build failure (no space left
  on device).\n\nTool homepage: https://github.com/lpantano/seqbuster"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqbuster:3.5--0
stdout: seqbuster_adrec.out
