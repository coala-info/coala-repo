cwlVersion: v1.2
class: CommandLineTool
baseCommand: snippy-core
label: snippy_snippy-core
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a log of a failed container execution (Singularity/Apptainer) while
  attempting to fetch the Snippy image.\n\nTool homepage: https://github.com/tseemann/snippy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snippy:4.6.0--hdfd78af_6
stdout: snippy_snippy-core.out
