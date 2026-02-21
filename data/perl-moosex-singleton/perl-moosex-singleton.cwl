cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-moosex-singleton
label: perl-moosex-singleton
doc: "The provided help text indicates that the executable 'perl-moosex-singleton'
  was not found in the environment's PATH. No usage information or arguments could
  be extracted from the provided logs.\n\nTool homepage: https://github.com/moose/MooseX-Singleton"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-moosex-singleton:0.30--pl526_0
stdout: perl-moosex-singleton.out
