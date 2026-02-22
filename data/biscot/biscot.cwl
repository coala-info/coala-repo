cwlVersion: v1.2
class: CommandLineTool
baseCommand: biscot
label: biscot
doc: "The provided text contains system error messages related to a container runtime
  (Singularity/Apptainer) failing to pull the biscot image due to lack of disk space.
  It does not contain the tool's help text or usage information.\n\nTool homepage:
  https://github.com/institut-de-genomique/biscot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biscot:2.3.3--pyh7cba7a3_0
stdout: biscot.out
