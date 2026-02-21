cwlVersion: v1.2
class: CommandLineTool
baseCommand: mobster
label: mobster_MobileInsertions.jar
doc: "A tool for detecting Mobile Element Insertions (MEI) in Next Generation Sequencing
  data.\n\nTool homepage: https://github.com/jyhehir/mobster"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mobster:0.2.4.1--1
stdout: mobster_MobileInsertions.jar.out
