cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fuc
  - find
label: fuc_fuc-find
doc: "The provided text does not contain help information for the tool. It appears
  to be a fatal error log from a container runtime (Singularity/Apptainer) indicating
  a failure to build a SIF image due to insufficient disk space.\n\nTool homepage:
  https://github.com/sbslee/fuc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
stdout: fuc_fuc-find.out
