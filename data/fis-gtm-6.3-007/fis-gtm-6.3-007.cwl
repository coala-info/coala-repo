cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtm
label: fis-gtm-6.3-007
doc: FIS GT.M is a database engine with a scalability-focused implementation of 
  the M (MUMPS) language.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fis-gtm-6.3-007:v6.3-007-1-deb_cv1
stdout: fis-gtm-6.3-007.out
