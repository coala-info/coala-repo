cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnaclust
label: dnaclust
doc: "The provided text does not contain help information for dnaclust; it contains
  container runtime error messages regarding disk space.\n\nTool homepage: https://github.com/jenhantao/DNACluster"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/dnaclust:v3-4b2-deb_cv1
stdout: dnaclust.out
