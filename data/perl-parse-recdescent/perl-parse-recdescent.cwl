cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-parse-recdescent
label: perl-parse-recdescent
doc: "A tool related to the Perl Parse::RecDescent module. Note: The provided help
  text contains a fatal error indicating the executable was not found in the environment,
  and thus no specific arguments or usage information could be extracted.\n\nTool
  homepage: http://metacpan.org/pod/Parse-RecDescent"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-parse-recdescent:1.967015--pl526_0
stdout: perl-parse-recdescent.out
