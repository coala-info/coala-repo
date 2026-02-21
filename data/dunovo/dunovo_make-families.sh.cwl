cwlVersion: v1.2
class: CommandLineTool
baseCommand: dunovo_make-families.sh
label: dunovo_make-families.sh
doc: "The provided text does not contain help information for the tool, but rather
  error messages from a container runtime (Singularity/Apptainer) indicating a failure
  to build the container image due to lack of disk space.\n\nTool homepage: https://github.com/galaxyproject/dunovo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dunovo:3.0.2--h7b50bb2_4
stdout: dunovo_make-families.sh.out
