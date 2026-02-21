cwlVersion: v1.2
class: CommandLineTool
baseCommand: czlab_perl_lib
label: czlab_perl_lib
doc: "A Perl library from the CZ Lab. (Note: The provided text is a system error log
  regarding a container build failure and does not contain command-line usage instructions
  or argument definitions.)\n\nTool homepage: https://github.com/huijfeng/czlab_perl_lib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/czlab_perl_lib:1.0.1--hdfd78af_0
stdout: czlab_perl_lib.out
