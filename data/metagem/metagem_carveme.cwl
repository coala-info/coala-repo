cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metagem
  - carveme
label: metagem_carveme
doc: "The provided text does not contain help information, but appears to be an error
  log from a container execution environment (Apptainer/Singularity) indicating a
  failure to build the SIF format due to insufficient disk space.\n\nTool homepage:
  https://github.com/franciscozorrilla/metaGEM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metagem:1.0.5--hdfd78af_0
stdout: metagem_carveme.out
