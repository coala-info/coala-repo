cwlVersion: v1.2
class: CommandLineTool
baseCommand: wtdbg2_wtdbg2.pl
label: wtdbg2_wtdbg2.pl
doc: "The provided text does not contain help information for the tool. It appears
  to be a fatal error log from a container runtime (Singularity/Apptainer) attempting
  to fetch a Docker image.\n\nTool homepage: https://github.com/ruanjue/wtdbg2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wtdbg2:2.0--h470a237_0
stdout: wtdbg2_wtdbg2.pl.out
