cwlVersion: v1.2
class: CommandLineTool
baseCommand: miraligner
label: seqbuster_miraligner
doc: "The provided text does not contain help information for the tool. It contains
  container build logs and a fatal error indicating 'no space left on device' during
  the extraction of the seqbuster OCI image.\n\nTool homepage: https://github.com/lpantano/seqbuster"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqbuster:3.5--0
stdout: seqbuster_miraligner.out
