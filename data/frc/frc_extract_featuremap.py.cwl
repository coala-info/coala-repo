cwlVersion: v1.2
class: CommandLineTool
baseCommand: frc_extract_featuremap.py
label: frc_extract_featuremap.py
doc: "The provided help text contains only system error messages related to a container
  runtime (Singularity/Apptainer) and does not contain usage information or argument
  descriptions for the tool.\n\nTool homepage: https://github.com/lucasjinreal/keras_frcnn"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/frc:5b3f53e--boost1.64_0
stdout: frc_extract_featuremap.py.out
