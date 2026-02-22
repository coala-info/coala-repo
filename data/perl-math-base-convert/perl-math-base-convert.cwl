cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-math-base-convert
label: perl-math-base-convert
doc: "A tool (typically a Perl module) used for converting numbers between different
  bases. Note: The provided text contains system error messages regarding disk space
  and container conversion rather than the tool's help documentation.\n\nTool homepage:
  https://metacpan.org/pod/Math::Base::Convert"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-math-base-convert:0.13--pl5321hdfd78af_0
stdout: perl-math-base-convert.out
