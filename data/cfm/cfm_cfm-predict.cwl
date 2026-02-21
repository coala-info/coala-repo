cwlVersion: v1.2
class: CommandLineTool
baseCommand: cfm-predict
label: cfm_cfm-predict
doc: "The provided text does not contain help information for the tool. It appears
  to be a fatal error log from a container runtime (Apptainer/Singularity) indicating
  a 'no space left on device' failure during image extraction.\n\nTool homepage: https://sourceforge.net/p/cfm-id/wiki/Home/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cfm:33--h7600467_7
stdout: cfm_cfm-predict.out
