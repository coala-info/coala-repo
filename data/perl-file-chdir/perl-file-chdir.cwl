cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-file-chdir
label: perl-file-chdir
doc: "A utility related to the Perl File::chdir module; however, no help text was
  provided as the executable was not found in the environment.\n\nTool homepage: https://github.com/Perl-Toolchain-Gang/File-chdir"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-file-chdir:0.1010--0
stdout: perl-file-chdir.out
