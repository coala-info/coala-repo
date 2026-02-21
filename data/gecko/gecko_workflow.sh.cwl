cwlVersion: v1.2
class: CommandLineTool
baseCommand: gecko_workflow.sh
label: gecko_workflow.sh
doc: "The provided text does not contain help information or usage instructions; it
  is an error log from a container runtime (Singularity/Apptainer) indicating a failure
  to build a SIF image due to insufficient disk space.\n\nTool homepage: https://github.com/otorreno/gecko"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gecko:1.2--h7b50bb2_6
stdout: gecko_workflow.sh.out
