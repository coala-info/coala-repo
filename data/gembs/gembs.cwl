cwlVersion: v1.2
class: CommandLineTool
baseCommand: gembs
label: gembs
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a system error log from a container runtime (Apptainer/Singularity)
  indicating a failure to pull or build the gembs container image due to lack of disk
  space.\n\nTool homepage: https://github.com/heathsc/gemBS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gembs:3.5.5_IHEC--py39h6859054_8
stdout: gembs.out
