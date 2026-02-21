cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanometa-prepare
label: nanometa-live_nanometa-prepare
doc: "The provided text does not contain help information for the tool. It appears
  to be an error log from a container runtime (Apptainer/Singularity) indicating a
  failure to build a SIF image due to insufficient disk space.\n\nTool homepage: https://github.com/FOI-Bioinformatics/nanometa_live"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanometa-live:0.4.3--pyhdfd78af_0
stdout: nanometa-live_nanometa-prepare.out
