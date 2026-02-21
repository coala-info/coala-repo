cwlVersion: v1.2
class: CommandLineTool
baseCommand: domainlist
label: bftools_domainlist
doc: "The provided text does not contain help information for the tool. It contains
  system log messages indicating a failure to build or extract a container image due
  to insufficient disk space.\n\nTool homepage: https://docs.openmicroscopy.org/bio-formats/5.7.1/users/comlinetools/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bftools:8.0.0--hdfd78af_0
stdout: bftools_domainlist.out
