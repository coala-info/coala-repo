cwlVersion: v1.2
class: CommandLineTool
baseCommand: estmapper
label: estmapper_pip
doc: "The provided text does not contain help information for the tool, but appears
  to be error logs from a container runtime environment (Apptainer/Singularity) indicating
  a failure to build the image due to lack of disk space.\n\nTool homepage: https://github.com/estmapper/1234"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/estmapper:2008--py311pl5321hd8d945a_7
stdout: estmapper_pip.out
