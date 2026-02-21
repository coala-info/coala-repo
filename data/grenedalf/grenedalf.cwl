cwlVersion: v1.2
class: CommandLineTool
baseCommand: grenedalf
label: grenedalf
doc: "The provided text does not contain help information for the tool; it is an error
  log from a container runtime (Apptainer/Singularity) indicating a failure to pull
  the image due to lack of disk space.\n\nTool homepage: https://github.com/lczech/grenedalf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grenedalf:0.6.3--hbefcdb2_0
stdout: grenedalf.out
