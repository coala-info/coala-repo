cwlVersion: v1.2
class: CommandLineTool
baseCommand: yleaf
label: yleaf
doc: "The provided text does not contain help information or usage instructions for
  the tool 'yleaf'. It appears to be a fatal error log from a container execution
  environment (Singularity/Apptainer) failing to pull the image.\n\nTool homepage:
  https://github.com/genid/Yleaf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yleaf:3.2.1--pyh1286868_0
stdout: yleaf.out
