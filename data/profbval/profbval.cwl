cwlVersion: v1.2
class: CommandLineTool
baseCommand: profbval
label: profbval
doc: "Predicts flexible and rigid residues in proteins (Note: The provided text contains
  container build logs and error messages rather than the tool's help documentation)."
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/profbval:v1.0.22-6-deb_cv1
stdout: profbval.out
