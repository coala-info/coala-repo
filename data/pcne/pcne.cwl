cwlVersion: v1.2
class: CommandLineTool
baseCommand: pcne
label: pcne
doc: "The provided text does not contain help information or documentation for the
  'pcne' tool; it consists of system error messages related to a container runtime
  (Singularity/Apptainer) failing to pull a Docker image due to insufficient disk
  space.\n\nTool homepage: https://github.com/riccabolla/PCNE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pcne:2.0.0--hdfd78af_0
stdout: pcne.out
