cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-variable-magic
label: perl-variable-magic
doc: "The provided text does not contain help documentation or usage instructions.
  It consists of system error messages indicating a failure to build or pull a Singularity/Docker
  container due to insufficient disk space ('no space left on device').\n\nTool homepage:
  http://search.cpan.org/dist/Variable-Magic/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-variable-magic:0.63--pl5321hec16e2b_0
stdout: perl-variable-magic.out
