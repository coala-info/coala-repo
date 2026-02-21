cwlVersion: v1.2
class: CommandLineTool
baseCommand: bcbio-prioritize
label: bcbio-prioritize
doc: "A tool for prioritizing variants in bcbio-nextgen analysis.\n\nTool homepage:
  https://github.com/chapmanb/bcbio.prioritize"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcbio-prioritize:0.0.8--0
stdout: bcbio-prioritize.out
