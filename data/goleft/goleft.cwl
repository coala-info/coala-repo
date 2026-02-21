cwlVersion: v1.2
class: CommandLineTool
baseCommand: goleft
label: goleft
doc: "The provided text does not contain help information for the tool 'goleft'. It
  contains error messages related to a container runtime (Singularity/Apptainer) failing
  to build a SIF format image due to insufficient disk space.\n\nTool homepage: https://github.com/brentp/goleft"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/goleft:0.2.6--he881be0_1
stdout: goleft.out
