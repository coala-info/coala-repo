cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-types-serialiser
label: perl-types-serialiser
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a log of a failed Singularity/Apptainer container build due
  to insufficient disk space.\n\nTool homepage: http://metacpan.org/pod/Types::Serialiser"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-types-serialiser:1.01--pl5321hdfd78af_0
stdout: perl-types-serialiser.out
