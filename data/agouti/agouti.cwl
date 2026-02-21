cwlVersion: v1.2
class: CommandLineTool
baseCommand: agouti
label: agouti
doc: "The provided text does not contain help information or usage instructions for
  the tool 'agouti'. It contains error logs from a container runtime (Apptainer/Singularity)
  indicating a failure to extract the tool's image due to insufficient disk space.\n
  \nTool homepage: https://github.com/zywicki-lab/agouti"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/agouti:1.0.3--pyhdfd78af_0
stdout: agouti.out
