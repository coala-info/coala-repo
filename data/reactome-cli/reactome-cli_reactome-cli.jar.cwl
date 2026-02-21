cwlVersion: v1.2
class: CommandLineTool
baseCommand: reactome-cli
label: reactome-cli_reactome-cli.jar
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a fatal error log from a container runtime (Singularity/Apptainer)
  attempting to fetch the image.\n\nTool homepage: https://github.com/reactome/reactome_galaxy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reactome-cli:1.0.0--hdfd78af_0
stdout: reactome-cli_reactome-cli.jar.out
