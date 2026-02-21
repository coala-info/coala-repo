cwlVersion: v1.2
class: CommandLineTool
baseCommand: primedrpa
label: primedrpa
doc: "The provided text does not contain help information for the tool 'primedrpa'.
  It appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  failing to fetch or build the image.\n\nTool homepage: https://github.com/MatthewHiggins2017/bioconda-PrimedRPA/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/primedrpa:1.0.3--pyhdfd78af_0
stdout: primedrpa.out
