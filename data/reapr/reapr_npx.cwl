cwlVersion: v1.2
class: CommandLineTool
baseCommand: reapr_npx
label: reapr_npx
doc: "The provided text does not contain help information for the tool. It appears
  to be a fatal error log from a container runtime (Apptainer/Singularity) attempting
  to fetch the REAPR image.\n\nTool homepage: https://github.com/tadelv/reaprime"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/reapr:v1.0.18dfsg-4-deb_cv1
stdout: reapr_npx.out
