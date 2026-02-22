cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-class-inspector
label: perl-class-inspector
doc: "The provided text does not contain help information for the tool. It consists
  of system error messages related to a container runtime (Singularity/Apptainer)
  failing to pull an image due to insufficient disk space.\n\nTool homepage: http://metacpan.org/pod/Class-Inspector"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-class-inspector:1.36--pl5321hdfd78af_0
stdout: perl-class-inspector.out
