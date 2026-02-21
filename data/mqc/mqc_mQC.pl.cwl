cwlVersion: v1.2
class: CommandLineTool
baseCommand: mqc_mQC.pl
label: mqc_mQC.pl
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system log messages and a fatal error regarding container
  image building and disk space.\n\nTool homepage: https://github.com/Biobix/mQC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mqc:1.10--py27pl5.22.0r3.4.1_0
stdout: mqc_mQC.pl.out
