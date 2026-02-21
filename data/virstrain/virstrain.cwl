cwlVersion: v1.2
class: CommandLineTool
baseCommand: virstrain
label: virstrain
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be an error log from a container build process (Apptainer/Singularity).\n
  \nTool homepage: https://github.com/liaoherui/VirStrain"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virstrain:1.17--pyhdfd78af_1
stdout: virstrain.out
