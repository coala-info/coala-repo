cwlVersion: v1.2
class: CommandLineTool
baseCommand: regtools
label: regtools
doc: "The provided text does not contain help information for regtools; it contains
  error logs from a container runtime (Singularity/Apptainer) failing to pull the
  regtools image.\n\nTool homepage: https://github.com/griffithlab/regtools/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/regtools:1.0.0--h077b44d_5
stdout: regtools.out
