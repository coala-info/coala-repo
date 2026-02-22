cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-io-interactive
label: perl-io-interactive
doc: "The provided text does not contain help information for the tool. It consists
  of system error messages related to a container runtime (Singularity/Apptainer)
  failing to pull an image due to lack of disk space.\n\nTool homepage: https://github.com/briandfoy/io-interactive"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-io-interactive:1.027--pl5321hdfd78af_0
stdout: perl-io-interactive.out
