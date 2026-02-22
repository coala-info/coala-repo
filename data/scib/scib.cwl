cwlVersion: v1.2
class: CommandLineTool
baseCommand: scib
label: scib
doc: "The provided text does not contain help information or usage instructions for
  the 'scib' tool. It appears to be an error log from a Singularity/Apptainer execution
  environment indicating a 'no space left on device' failure during image conversion.\n\
  \nTool homepage: https://github.com/theislab/scib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scib:1.1.7--py311hf552afe_1
stdout: scib.out
