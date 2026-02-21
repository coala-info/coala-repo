cwlVersion: v1.2
class: CommandLineTool
baseCommand: rtg
label: rtg-core
doc: "The provided text does not contain help information or usage instructions for
  rtg-core. It appears to be a log of a failed container build process (Singularity/Apptainer).\n
  \nTool homepage: https://github.com/RealTimeGenomics/rtg-core"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rtg-core:3.13--hdfd78af_0
stdout: rtg-core.out
