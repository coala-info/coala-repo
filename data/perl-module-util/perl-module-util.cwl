cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-module-util
label: perl-module-util
doc: "The provided text does not contain help information for the tool; it contains
  an execution error log indicating the executable was not found in the environment.\n
  \nTool homepage: http://metacpan.org/pod/Module::Util"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-module-util:1.09--pl526_0
stdout: perl-module-util.out
