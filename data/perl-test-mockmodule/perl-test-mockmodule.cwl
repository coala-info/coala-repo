cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test-mockmodule
label: perl-test-mockmodule
doc: "The provided text does not contain help documentation; it is an error log indicating
  that the executable 'perl-test-mockmodule' was not found in the environment's PATH.\n
  \nTool homepage: https://github.com/geofffranks/test-mockmodule"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-test-mockmodule:0.13--pl526_1
stdout: perl-test-mockmodule.out
