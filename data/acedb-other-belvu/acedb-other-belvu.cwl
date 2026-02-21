cwlVersion: v1.2
class: CommandLineTool
baseCommand: belvu
label: acedb-other-belvu
doc: 'A multiple sequence alignment viewer and editor (Note: The provided text is
  a system error log and does not contain help information. Arguments could not be
  extracted from the source text).'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/acedb-other-belvu:v4.9.39dfsg.02-4-deb_cv1
stdout: acedb-other-belvu.out
