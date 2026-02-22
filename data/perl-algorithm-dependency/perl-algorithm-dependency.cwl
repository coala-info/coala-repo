cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-algorithm-dependency
label: perl-algorithm-dependency
doc: "Algorithm::Dependency is a Perl module used to manage dependency hierarchies.
  (Note: The provided input text contains system error messages regarding disk space
  and container image retrieval rather than the tool's help documentation.)\n\nTool
  homepage: http://metacpan.org/pod/Algorithm::Dependency"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-algorithm-dependency:1.112--pl5321hdfd78af_0
stdout: perl-algorithm-dependency.out
