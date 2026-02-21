cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-math-random-mt-auto
label: perl-math-random-mt-auto
doc: "The provided text is an error log indicating that the executable 'perl-math-random-mt-auto'
  was not found in the system PATH. No help text or usage information was available
  to parse arguments.\n\nTool homepage: http://metacpan.org/pod/Math::Random::MT::Auto"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-math-random-mt-auto:6.23--pl526h470a237_0
stdout: perl-math-random-mt-auto.out
