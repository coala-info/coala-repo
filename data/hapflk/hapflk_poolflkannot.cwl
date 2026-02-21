cwlVersion: v1.2
class: CommandLineTool
baseCommand: hapflk_poolflkannot
label: hapflk_poolflkannot
doc: "The provided text does not contain help information for the tool. It contains
  container runtime error messages (Singularity/Apptainer) indicating a failure to
  pull or build the image due to lack of disk space.\n\nTool homepage: https://github.com/BertrandServin/hapflk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hapflk:1.3.0--py27_0
stdout: hapflk_poolflkannot.out
