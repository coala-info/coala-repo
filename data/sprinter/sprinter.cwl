cwlVersion: v1.2
class: CommandLineTool
baseCommand: sprinter
label: sprinter
doc: "The provided text does not contain help information or usage instructions for
  the tool 'sprinter'. It appears to be a log of a failed container build process
  (Apptainer/Singularity).\n\nTool homepage: https://github.com/zaccaria-lab/SPRINTER"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sprinter:1.0.0--pyhdfd78af_0
stdout: sprinter.out
