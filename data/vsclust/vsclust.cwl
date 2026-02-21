cwlVersion: v1.2
class: CommandLineTool
baseCommand: vsclust
label: vsclust
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  attempting to fetch the tool's image.\n\nTool homepage: https://bitbucket.org/veitveit/vsclust/src/master/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsclust:0.91--r41hdfd78af_0
stdout: vsclust.out
