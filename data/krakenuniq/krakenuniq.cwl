cwlVersion: v1.2
class: CommandLineTool
baseCommand: krakenuniq
label: krakenuniq
doc: "The provided text is a system error message related to container image creation
  (Apptainer/Singularity) and does not contain the help documentation or usage instructions
  for the krakenuniq tool.\n\nTool homepage: https://github.com/fbreitwieser/krakenuniq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krakenuniq:1.0.4--pl5321h668145b_4
stdout: krakenuniq.out
