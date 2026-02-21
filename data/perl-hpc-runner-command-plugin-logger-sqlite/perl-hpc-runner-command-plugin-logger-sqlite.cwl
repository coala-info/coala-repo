cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-hpc-runner-command-plugin-logger-sqlite
label: perl-hpc-runner-command-plugin-logger-sqlite
doc: 'A plugin for the HPC::Runner::Command Perl module that provides SQLite logging
  capabilities. (Note: The provided text was a container build error log and did not
  contain functional help text or argument definitions.)'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-hpc-runner-command-plugin-logger-sqlite:0.0.3--pl5.22.0_0
stdout: perl-hpc-runner-command-plugin-logger-sqlite.out
