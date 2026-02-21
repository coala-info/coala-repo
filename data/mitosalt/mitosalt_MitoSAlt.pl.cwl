cwlVersion: v1.2
class: CommandLineTool
baseCommand: mitosalt_MitoSAlt.pl
label: mitosalt_MitoSAlt.pl
doc: "MitoSAlt is a tool for the identification of mitochondrial DNA deletions and
  duplications. (Note: The provided text is a container execution error log and does
  not contain help documentation; therefore, no arguments could be extracted.)\n\n
  Tool homepage: https://sourceforge.net/projects/mitosalt/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mitosalt:1.1.1--hdfd78af_2
stdout: mitosalt_MitoSAlt.pl.out
