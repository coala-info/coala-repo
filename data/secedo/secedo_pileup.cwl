cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - secedo
  - pileup
label: secedo_pileup
doc: "The provided text does not contain help information for the tool; it contains
  system error logs related to a container build failure (no space left on device).\n
  \nTool homepage: https://github.com/ratschlab/secedo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/secedo:1.0.7--ha041835_4
stdout: secedo_pileup.out
