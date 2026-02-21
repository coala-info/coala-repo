cwlVersion: v1.2
class: CommandLineTool
baseCommand: profile_dists
label: profile_dists
doc: "The provided text does not contain help information for the tool. It is a log
  of a failed container build process.\n\nTool homepage: https://pypi.org/project/profile-dists"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/profile_dists:1.0.10--pyhdfd78af_0
stdout: profile_dists.out
