cwlVersion: v1.2
class: CommandLineTool
baseCommand: ectyper
label: ectyper
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to build an image due to lack of disk space.\n\nTool homepage: https://github.com/phac-nml/ecoli_serotyping"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ectyper:2.0.0--pyhdfd78af_4
stdout: ectyper.out
