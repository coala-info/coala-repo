cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-parallel-forkmanager
label: perl-parallel-forkmanager
doc: "A simple parallel processing fork manager for Perl. Note: The provided text
  contains system error messages regarding container execution and disk space, rather
  than command-line help documentation.\n\nTool homepage: https://github.com/dluxhu/perl-parallel-forkmanager"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-parallel-forkmanager:2.04--pl5321hdfd78af_0
stdout: perl-parallel-forkmanager.out
