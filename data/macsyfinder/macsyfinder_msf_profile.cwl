cwlVersion: v1.2
class: CommandLineTool
baseCommand: macsyfinder_msf_profile
label: macsyfinder_msf_profile
doc: "The provided text does not contain help information for the tool, but appears
  to be a system error log regarding a container execution failure (no space left
  on device).\n\nTool homepage: https://github.com/gem-pasteur/macsyfinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macsyfinder:2.1.6--pyhdfd78af_0
stdout: macsyfinder_msf_profile.out
