cwlVersion: v1.2
class: CommandLineTool
baseCommand: freediams-doc-fr
label: freediams-doc-fr
doc: French documentation for FreeDiams (pharmaceutical prescriber).
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/freediams-doc-fr:v0.9.4-2-deb_cv1
stdout: freediams-doc-fr.out
