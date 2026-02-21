cwlVersion: v1.2
class: CommandLineTool
baseCommand: mtbls-dwnld
label: mtbls-dwnld
doc: "MetaboLights download tool (Note: The provided help text contains only system
  error messages and does not list usage instructions or arguments).\n\nTool homepage:
  https://github.com/workflow4metabolomics/mtbls-dwnld"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mtbls-dwnld:phenomenal-v4.1.3_cv2.0.34
stdout: mtbls-dwnld.out
