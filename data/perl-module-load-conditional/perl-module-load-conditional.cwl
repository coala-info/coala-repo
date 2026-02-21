cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-module-load-conditional
label: perl-module-load-conditional
doc: "The provided text does not contain help information; it is an error log indicating
  that the executable 'perl-module-load-conditional' was not found in the system PATH.\n
  \nTool homepage: http://metacpan.org/pod/Module::Load::Conditional"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-module-load-conditional:0.68--pl526_2
stdout: perl-module-load-conditional.out
