cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - macsyfinder
  - msf_merge
label: macsyfinder_msf_merge
doc: "The provided text does not contain help information or a description of the
  tool. It contains system error messages related to container image building (no
  space left on device).\n\nTool homepage: https://github.com/gem-pasteur/macsyfinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macsyfinder:2.1.6--pyhdfd78af_0
stdout: macsyfinder_msf_merge.out
