cwlVersion: v1.2
class: CommandLineTool
baseCommand: rucs
label: rucs
doc: "The provided text does not contain help information for the tool 'rucs'. It
  contains error logs from a container runtime (Apptainer/Singularity) attempting
  to fetch a Docker image.\n\nTool homepage: https://bitbucket.org/genomicepidemiology/rucs/src/master/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rucs:1.0.3--hdfd78af_0
stdout: rucs.out
