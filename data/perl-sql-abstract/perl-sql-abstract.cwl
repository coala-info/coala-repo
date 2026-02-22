cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-sql-abstract
label: perl-sql-abstract
doc: "The provided text contains system error messages regarding container image retrieval
  and storage space issues, rather than the help documentation for the tool itself.
  SQL::Abstract is typically a Perl library for generating SQL from Perl data structures.\n\
  \nTool homepage: http://metacpan.org/pod/SQL-Abstract"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-sql-abstract:2.000001--pl5321hdfd78af_0
stdout: perl-sql-abstract.out
