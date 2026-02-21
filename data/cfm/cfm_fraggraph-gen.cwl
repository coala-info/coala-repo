cwlVersion: v1.2
class: CommandLineTool
baseCommand: cfm_fraggraph-gen
label: cfm_fraggraph-gen
doc: "The provided text does not contain help information for the tool; it is an error
  log from a container runtime (Apptainer/Singularity) indicating a 'no space left
  on device' failure during image extraction.\n\nTool homepage: https://sourceforge.net/p/cfm-id/wiki/Home/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cfm:33--h7600467_7
stdout: cfm_fraggraph-gen.out
