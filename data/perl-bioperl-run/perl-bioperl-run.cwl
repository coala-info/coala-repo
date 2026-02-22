cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-bioperl-run
label: perl-bioperl-run
doc: "BioPerl-run is a collection of BioPerl wrappers for external bioinformatics
  tools. (Note: The provided text contains system error messages regarding container
  image conversion and disk space, rather than command-line help documentation).\n\
  \nTool homepage: http://metacpan.org/pod/BioPerl-Run"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-bioperl-run:1.007003--pl5321hdfd78af_0
stdout: perl-bioperl-run.out
