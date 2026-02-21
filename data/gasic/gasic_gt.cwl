cwlVersion: v1.2
class: CommandLineTool
baseCommand: gasic_gt
label: gasic_gt
doc: "The provided text does not contain help information for the tool. It contains
  error logs related to a container runtime (Singularity/Apptainer) failure while
  attempting to pull the gasic image.\n\nTool homepage: https://github.com/steveyegge/gastown"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/gasic:v0.0.r19-4-deb_cv1
stdout: gasic_gt.out
