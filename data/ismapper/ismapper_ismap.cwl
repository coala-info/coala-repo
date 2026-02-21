cwlVersion: v1.2
class: CommandLineTool
baseCommand: ismap
label: ismapper_ismap
doc: "The provided text is an error message from a container runtime (Singularity/Apptainer)
  and does not contain help information or argument definitions for the tool.\n\n
  Tool homepage: https://github.com/jhawkey/IS_mapper/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ismapper:2.0.2--pyhdfd78af_1
stdout: ismapper_ismap.out
