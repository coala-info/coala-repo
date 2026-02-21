cwlVersion: v1.2
class: CommandLineTool
baseCommand: freediams
label: freediams
doc: "FreeDiams is a pharmaceutical prescriber (Note: The provided text contains container
  runtime errors and no help documentation; no arguments could be extracted).\n\n
  Tool homepage: https://github.com/gchiu/freediams-rebol-webportal"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/freediams:v0.9.4-2-deb_cv1
stdout: freediams.out
