cwlVersion: v1.2
class: CommandLineTool
baseCommand: nextstrain
label: nextstrain-cli
doc: "The provided text does not contain help documentation or usage instructions.
  It appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  indicating a failure to pull or build the container image due to insufficient disk
  space.\n\nTool homepage: https://docs.nextstrain.org/projects/cli/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextstrain-cli:10.4.2--pyhdfd78af_0
stdout: nextstrain-cli.out
