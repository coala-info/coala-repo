cwlVersion: v1.2
class: CommandLineTool
baseCommand: suffixfsm
label: suffixfsm
doc: The provided text does not contain help information or usage instructions; it
  is a log of a failed container build process. Consequently, no arguments could be
  extracted.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/suffixfsm:v0.0git20150829.56e4718-2-deb_cv1
stdout: suffixfsm.out
