cwlVersion: v1.2
class: CommandLineTool
baseCommand: ga4ghmongo
label: ga4ghmongo
doc: "A tool for GA4GH (Global Alliance for Genomics and Health) data management with
  MongoDB.\n\nTool homepage: https://github.com/Phelimb/ga4gh-mongo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ga4ghmongo:0.0.1.2--py36_0
stdout: ga4ghmongo.out
