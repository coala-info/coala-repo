cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - macsyfinder
  - msf-split
label: macsyfinder_msf_split
doc: "The provided text does not contain help information for macsyfinder_msf_split;
  it contains system error messages regarding a container runtime failure (no space
  left on device).\n\nTool homepage: https://github.com/gem-pasteur/macsyfinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macsyfinder:2.1.6--pyhdfd78af_0
stdout: macsyfinder_msf_split.out
