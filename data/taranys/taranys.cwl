cwlVersion: v1.2
class: CommandLineTool
baseCommand: taranys
label: taranys
doc: "The provided text does not contain help information or usage instructions; it
  appears to be a log of a failed container build process (Singularity/Apptainer).\n
  \nTool homepage: https://github.com/BU-ISCIII/taranys"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taranys:3.0.1--pyhdfd78af_0
stdout: taranys.out
