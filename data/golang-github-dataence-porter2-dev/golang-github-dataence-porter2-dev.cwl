cwlVersion: v1.2
class: CommandLineTool
baseCommand: porter2
label: golang-github-dataence-porter2-dev
doc: 'A Go implementation of the Porter2 stemming algorithm. (Note: The provided text
  appears to be a container runtime error log rather than help text; no arguments
  could be extracted from the input.)'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      biocontainers/golang-github-dataence-porter2-dev:v0.0git20150829.56e4718-2-deb_cv1
stdout: golang-github-dataence-porter2-dev.out
