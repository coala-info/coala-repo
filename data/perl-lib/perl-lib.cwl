cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-lib
label: perl-lib
doc: "The provided text does not contain help information; it indicates a fatal error
  where the executable 'perl-lib' was not found in the system PATH during a container
  execution.\n\nTool homepage: https://github.com/landy22granatt/Kumpulan-Script-Termux"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-lib:0.63--pl5.22.0_0
stdout: perl-lib.out
