cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metagem
  - smetana
label: metagem_smetana
doc: "The provided text does not contain help information for the tool; it contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to build an image due to lack of disk space.\n\nTool homepage: https://github.com/franciscozorrilla/metaGEM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metagem:1.0.5--hdfd78af_0
stdout: metagem_smetana.out
