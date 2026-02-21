cwlVersion: v1.2
class: CommandLineTool
baseCommand: mia-doctools
label: mia-doctools
doc: 'A tool for documentation processing (Note: The provided help text contains only
  system error messages and no usage information).'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mia-doctools:v2.4.6-4-deb_cv1
stdout: mia-doctools.out
