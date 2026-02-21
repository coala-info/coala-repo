cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-module-runtime-conflicts
label: perl-module-runtime-conflicts
doc: "A tool to check for runtime conflicts in Perl modules.\n\nTool homepage: https://github.com/karenetheridge/Module-Runtime-Conflicts"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-module-runtime-conflicts:0.003--pl526_0
stdout: perl-module-runtime-conflicts.out
