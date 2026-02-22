cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test2-suite
label: perl-test2-suite
doc: "The provided text does not contain help information or usage instructions for
  the tool. It consists of system error messages related to a container runtime (Singularity/Apptainer)
  failing to pull or build the image due to insufficient disk space.\n\nTool homepage:
  http://metacpan.org/pod/Test2-Suite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-test2-suite:0.000163--pl5321hdfd78af_0
stdout: perl-test2-suite.out
