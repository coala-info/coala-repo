cwlVersion: v1.2
class: CommandLineTool
baseCommand: rdp_classifier
label: rdp_classifier
doc: "The provided text does not contain help information or usage instructions for
  rdp_classifier; it contains container runtime logs and a fatal error message.\n\n
  Tool homepage: http://rdp.cme.msu.edu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rdp-classifier:v2.10.2-4-deb_cv1
stdout: rdp_classifier.out
