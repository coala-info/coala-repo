cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-string-rewriteprefix
label: perl-string-rewriteprefix
doc: "A tool for rewriting string prefixes (Note: The provided text contains system
  error messages rather than help documentation, so no arguments could be extracted).\n\
  \nTool homepage: https://github.com/rjbs/String-RewritePrefix"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-string-rewriteprefix:0.009--pl5321hdfd78af_0
stdout: perl-string-rewriteprefix.out
