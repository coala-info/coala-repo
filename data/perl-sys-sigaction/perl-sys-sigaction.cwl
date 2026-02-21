cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-sys-sigaction
label: perl-sys-sigaction
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be an error log indicating that the executable 'perl-sys-sigaction'
  was not found in the system PATH during a container build/execution process.\n\n
  Tool homepage: http://metacpan.org/pod/Sys::SigAction"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-sys-sigaction:0.23--pl5.22.0_0
stdout: perl-sys-sigaction.out
