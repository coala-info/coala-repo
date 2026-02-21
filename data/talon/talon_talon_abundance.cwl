cwlVersion: v1.2
class: CommandLineTool
baseCommand: talon_abundance
label: talon_talon_abundance
doc: "The provided text does not contain help information for the tool. It appears
  to be a fatal error log from a container runtime (Apptainer/Singularity) while attempting
  to fetch the TALON image.\n\nTool homepage: https://github.com/mortazavilab/TALON"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/talon:6.0.1--pyhdfd78af_0
stdout: talon_talon_abundance.out
