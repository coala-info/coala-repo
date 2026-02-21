cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfinisher
label: gfinisher
doc: A tool for refining and finishing bacterial genome assemblies.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfinisher:1.4--py35_0
stdout: gfinisher.out
