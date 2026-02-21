cwlVersion: v1.2
class: CommandLineTool
baseCommand: prestor
label: prestor
doc: "The provided text does not contain help information or usage instructions for
  the tool 'prestor'. It appears to be an error log from a container runtime (Singularity/Apptainer)
  failing to fetch the tool's image.\n\nTool homepage: https://bitbucket.org/javh/prototype-prestor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prestor:07f9c7caeb60--0
stdout: prestor.out
