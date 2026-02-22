cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-postscript-simple
label: perl-postscript-simple
doc: "The provided text does not contain help documentation for the tool. It contains
  system error messages related to a container runtime (Singularity/Apptainer) failing
  to pull a Docker image due to insufficient disk space.\n\nTool homepage: https://metacpan.org/pod/PostScript::Simple"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-postscript-simple:0.09--pl5321hdfd78af_0
stdout: perl-postscript-simple.out
