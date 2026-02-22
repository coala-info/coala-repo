cwlVersion: v1.2
class: CommandLineTool
baseCommand: biomaj3-zipkin
label: biomaj3-zipkin
doc: 'BioMAJ3 Zipkin component. (Note: The provided text contains system error logs
  regarding container execution and storage space rather than command-line help documentation;
  therefore, no arguments could be extracted.)'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/biomaj3-zipkin:v0.2.2-1-deb-py3_cv1
stdout: biomaj3-zipkin.out
