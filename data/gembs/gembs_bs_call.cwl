cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gembs
  - bs_call
label: gembs_bs_call
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  due to lack of disk space.\n\nTool homepage: https://github.com/heathsc/gemBS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gembs:3.5.5_IHEC--py39h6859054_8
stdout: gembs_bs_call.out
