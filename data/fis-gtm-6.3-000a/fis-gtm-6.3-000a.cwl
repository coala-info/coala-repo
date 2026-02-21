cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtm
label: fis-gtm-6.3-000a
doc: 'FIS-GTM is a database engine and application development platform. Note: The
  provided text contains system error logs rather than tool help documentation, so
  no arguments could be extracted.'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fis-gtm-6.3-000a:v6.3-000A-1-deb_cv1
stdout: fis-gtm-6.3-000a.out
