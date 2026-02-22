cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-html-form
label: perl-html-form
doc: "The provided text does not contain help information or usage instructions. It
  consists of system error messages indicating a failure to pull or run a Singularity
  container due to insufficient disk space ('no space left on device').\n\nTool homepage:
  https://metacpan.org/pod/HTML::Form"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-html-form:6.11--pl5321hdfd78af_0
stdout: perl-html-form.out
