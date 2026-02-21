cwlVersion: v1.2
class: CommandLineTool
baseCommand: safesim
label: safesim
doc: "The provided text does not contain help information or usage instructions for
  the tool 'safesim'. It appears to be an error log from a container build process
  (Apptainer/Singularity).\n\nTool homepage: https://github.com/genetronhealth/safesim"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/safesim:0.1.6.8d44580--h7d57edc_4
stdout: safesim.out
