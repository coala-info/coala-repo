cwlVersion: v1.2
class: CommandLineTool
baseCommand: sbol-utilities
label: sbol-utilities
doc: "The provided text does not contain help documentation or usage instructions.
  It appears to be a system log showing a fatal error during a Singularity/Apptainer
  container build process.\n\nTool homepage: https://github.com/SynBioDex/SBOL-utilities"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sbol-utilities:1.0a16--pyhdfd78af_0
stdout: sbol-utilities.out
