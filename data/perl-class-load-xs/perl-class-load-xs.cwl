cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-class-load-xs
label: perl-class-load-xs
doc: "The provided text is an error log indicating that the executable 'perl-class-load-xs'
  was not found in the system PATH. No help text or usage information was available
  to parse arguments.\n\nTool homepage: https://github.com/moose/Class-Load-XS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-class-load-xs:0.10--pl526h2d50403_0
stdout: perl-class-load-xs.out
