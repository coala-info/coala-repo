cwlVersion: v1.2
class: CommandLineTool
baseCommand: fermi
label: fermi
doc: "The provided text does not contain help information for the tool 'fermi'. It
  contains error messages related to a container runtime (Apptainer/Singularity) failing
  to pull the image due to insufficient disk space.\n\nTool homepage: https://github.com/quantumlib/OpenFermion"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermi:1.1_r751_beta--h577a1d6_9
stdout: fermi.out
