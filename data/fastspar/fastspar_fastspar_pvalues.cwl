cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastspar_pvalues
label: fastspar_fastspar_pvalues
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to build an image due to lack of disk space.\n\nTool homepage: https://github.com/scwatts/fastspar"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastspar:1.0.0--h1b620e3_6
stdout: fastspar_fastspar_pvalues.out
