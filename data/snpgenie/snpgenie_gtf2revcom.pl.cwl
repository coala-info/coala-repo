cwlVersion: v1.2
class: CommandLineTool
baseCommand: snpgenie_gtf2revcom.pl
label: snpgenie_gtf2revcom.pl
doc: "The provided text does not contain help information for the tool; it contains
  container runtime (Apptainer/Singularity) log messages and a fatal error regarding
  image fetching.\n\nTool homepage: https://github.com/chasewnelson/SNPGenie"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snpgenie:1.0--hdfd78af_1
stdout: snpgenie_gtf2revcom.pl.out
