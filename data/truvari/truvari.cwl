cwlVersion: v1.2
class: CommandLineTool
baseCommand: truvari
label: truvari
doc: "The provided text is a system error log from a container runtime (Singularity/Apptainer)
  and does not contain CLI help information or usage instructions. As a result, no
  arguments could be parsed.\n\nTool homepage: https://github.com/spiralgenetics/truvari"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/truvari:5.4.0--pyhdfd78af_0
stdout: truvari.out
