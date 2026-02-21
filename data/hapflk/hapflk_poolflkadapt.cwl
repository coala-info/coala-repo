cwlVersion: v1.2
class: CommandLineTool
baseCommand: hapflk-poolflkadapt
label: hapflk_poolflkadapt
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Singularity/Apptainer) failing
  to build an image due to insufficient disk space.\n\nTool homepage: https://github.com/BertrandServin/hapflk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hapflk:1.3.0--py27_0
stdout: hapflk_poolflkadapt.out
