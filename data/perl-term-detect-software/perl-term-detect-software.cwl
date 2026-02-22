cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-term-detect-software
label: perl-term-detect-software
doc: "The provided text does not contain help information for the tool, but rather
  system error messages regarding a failed container execution due to insufficient
  disk space. No arguments or tool descriptions could be extracted from the input.\n\
  \nTool homepage: https://metacpan.org/pod/Term::Detect::Software"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-term-detect-software:0.227--pl5321hdfd78af_0
stdout: perl-term-detect-software.out
