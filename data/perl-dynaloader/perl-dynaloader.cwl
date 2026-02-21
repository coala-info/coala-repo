cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-dynaloader
label: perl-dynaloader
doc: "The tool 'perl-dynaloader' could not be executed as the executable was not found
  in the system PATH. No help text or usage information was available to parse.\n\n
  Tool homepage: https://github.com/openela-main/perl-DynaLoader-Functions"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-dynaloader:1.25--pl526_1
stdout: perl-dynaloader.out
