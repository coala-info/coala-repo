cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-params-validationcompiler
label: perl-params-validationcompiler
doc: "The provided text does not contain help documentation for the tool. It consists
  of system error messages related to a container runtime (Singularity/Apptainer)
  failing to pull or build the image due to insufficient disk space.\n\nTool homepage:
  http://metacpan.org/release/Params-ValidationCompiler"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-params-validationcompiler:0.31--pl5321hdfd78af_0
stdout: perl-params-validationcompiler.out
