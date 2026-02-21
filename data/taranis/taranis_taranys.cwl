cwlVersion: v1.2
class: CommandLineTool
baseCommand: taranis
label: taranis_taranys
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be an error log from a container build process (Apptainer/Singularity)
  failing to fetch or convert an OCI image.\n\nTool homepage: https://github.com/BU-ISCIII/taranis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taranis:2.0.1--hdfd78af_0
stdout: taranis_taranys.out
