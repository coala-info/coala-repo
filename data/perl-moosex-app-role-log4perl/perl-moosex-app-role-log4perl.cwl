cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-moosex-app-role-log4perl
label: perl-moosex-app-role-log4perl
doc: "The provided text does not contain help documentation. It is an error log indicating
  that the executable 'perl-moosex-app-role-log4perl' was not found in the system
  PATH during an Apptainer build process.\n\nTool homepage: https://github.com/gitpan/MooseX-App-Role-Log4perl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-moosex-app-role-log4perl:0.03--pl526_1
stdout: perl-moosex-app-role-log4perl.out
