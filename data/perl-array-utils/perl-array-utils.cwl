cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-array-utils
label: perl-array-utils
doc: "The provided text is an error log indicating that the executable 'perl-array-utils'
  was not found in the system PATH. No help text or usage information was available
  to parse arguments.\n\nTool homepage: https://github.com/patch-orphan/operator-util-pm5"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-array-utils:0.5--pl526_2
stdout: perl-array-utils.out
