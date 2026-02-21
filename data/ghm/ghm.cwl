cwlVersion: v1.2
class: CommandLineTool
baseCommand: ghm
label: ghm
doc: "The provided text does not contain help information for the tool 'ghm'. It appears
  to be an error log from a container runtime (Apptainer/Singularity) indicating a
  failure to pull or build the container image due to lack of disk space.\n\nTool
  homepage: https://www.helmholtz-muenchen.de/en/ige/service/software-download/genehunter-modscore/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ghm:3.1--ha92aebf_2
stdout: ghm.out
