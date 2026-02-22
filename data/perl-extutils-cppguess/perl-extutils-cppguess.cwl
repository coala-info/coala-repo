cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-extutils-cppguess
label: perl-extutils-cppguess
doc: "ExtUtils::CppGuess - guess C++ compiler and flags. (Note: The provided input
  text contains system error messages regarding disk space and container image conversion
  rather than the tool's help documentation.)\n\nTool homepage: http://metacpan.org/pod/ExtUtils::CppGuess"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-extutils-cppguess:0.27--pl5321h9948957_0
stdout: perl-extutils-cppguess.out
