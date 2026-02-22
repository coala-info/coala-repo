cwlVersion: v1.2
class: CommandLineTool
baseCommand: panaroo
label: panaroo
doc: "The provided text is an error log related to a container runtime (Singularity/Apptainer)
  failing to pull the panaroo image due to insufficient disk space. It does not contain
  CLI help information or argument definitions.\n\nTool homepage: https://gtonkinhill.github.io/panaroo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panaroo:1.6.0--pyhdfd78af_0
stdout: panaroo.out
