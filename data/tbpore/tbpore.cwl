cwlVersion: v1.2
class: CommandLineTool
baseCommand: tbpore
label: tbpore
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs from a container runtime (Apptainer/Singularity) failing
  to fetch the tool's image.\n\nTool homepage: https://github.com/mbhall88/tbpore/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tbpore:0.7.1--pyhdfd78af_0
stdout: tbpore.out
