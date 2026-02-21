cwlVersion: v1.2
class: CommandLineTool
baseCommand: antismash
label: antismash
doc: "The provided text does not contain help information for antiSMASH; it is a log
  of a failed container build/extraction process due to insufficient disk space.\n
  \nTool homepage: http://antismash.secondarymetabolites.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/antismash:8.0.4--pyhdfd78af_0
stdout: antismash.out
