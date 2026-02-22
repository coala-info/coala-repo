cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-io-prompt
label: perl-io-prompt
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a series of system error messages related to a Singularity/Apptainer
  container build failure ('no space left on device').\n\nTool homepage: https://github.com/zszszszsz/.config"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-io-prompt:0.997004--pl5321hdfd78af_4
stdout: perl-io-prompt.out
