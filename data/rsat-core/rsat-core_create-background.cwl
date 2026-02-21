cwlVersion: v1.2
class: CommandLineTool
baseCommand: create-background
label: rsat-core_create-background
doc: "The provided text does not contain help information for the tool, but appears
  to be a fatal error log from a container runtime (Apptainer/Singularity) attempting
  to fetch the rsat-core image.\n\nTool homepage: http://rsat.eu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsat-core:2025.04.04--hb2a3317_1
stdout: rsat-core_create-background.out
