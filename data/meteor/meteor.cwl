cwlVersion: v1.2
class: CommandLineTool
baseCommand: meteor
label: meteor
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help information or usage instructions for the 'meteor' tool.
  As a result, no arguments could be extracted.\n\nTool homepage: https://github.com/metagenopolis/meteor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meteor:2.0.22--pyhdfd78af_0
stdout: meteor.out
