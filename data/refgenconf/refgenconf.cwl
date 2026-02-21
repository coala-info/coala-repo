cwlVersion: v1.2
class: CommandLineTool
baseCommand: refgenconf
label: refgenconf
doc: "The provided text does not contain help information or usage instructions for
  refgenconf. It appears to be an error log from a container build process (Apptainer/Singularity).\n
  \nTool homepage: https://refgenie.databio.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/refgenconf:0.12.2--pyhdfd78af_0
stdout: refgenconf.out
