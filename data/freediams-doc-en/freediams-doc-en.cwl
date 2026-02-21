cwlVersion: v1.2
class: CommandLineTool
baseCommand: freediams-doc-en
label: freediams-doc-en
doc: English documentation for FreeDiams (pharmaceutical prescriber and drug database).
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/freediams-doc-en:v0.9.4-2-deb_cv1
stdout: freediams-doc-en.out
