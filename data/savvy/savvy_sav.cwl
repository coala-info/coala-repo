cwlVersion: v1.2
class: CommandLineTool
baseCommand: sav
label: savvy_sav
doc: "Savvy is a tool for handling SAV (Sparse Allele Vector) files. Note: The provided
  text is a container engine (Singularity/Apptainer) error log and does not contain
  CLI help information or argument definitions.\n\nTool homepage: https://github.com/statgen/savvy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/savvy:2.1.0--h5b0a936_4
stdout: savvy_sav.out
