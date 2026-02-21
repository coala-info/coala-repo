cwlVersion: v1.2
class: CommandLineTool
baseCommand: cami-opal_tsv2biom.py
label: cami-opal_tsv2biom.py
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log reporting a 'no space left on device' failure during a
  container build process.\n\nTool homepage: https://github.com/CAMI-challenge/OPAL"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cami-opal:1.0.13--pyhdfd78af_0
stdout: cami-opal_tsv2biom.py.out
