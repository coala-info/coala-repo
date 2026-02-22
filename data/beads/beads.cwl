cwlVersion: v1.2
class: CommandLineTool
baseCommand: beads
label: beads
doc: "The provided text does not contain help information for the 'beads' tool; it
  contains error messages related to a container runtime (Singularity/Apptainer) failing
  to pull a Docker image due to lack of disk space.\n\nTool homepage: https://github.com/steveyegge/beads"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/beads:v1.1.18dfsg-3-deb_cv1
stdout: beads.out
