cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-if
label: perl-if
doc: "The 'if' module is used to conditionally load a Perl module. Note: The provided
  text contains system error messages regarding container image retrieval and does
  not contain standard CLI help documentation.\n\nTool homepage: http://metacpan.org/pod/if"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-if:0.0608--pl5321hdfd78af_2
stdout: perl-if.out
