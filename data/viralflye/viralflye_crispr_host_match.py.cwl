cwlVersion: v1.2
class: CommandLineTool
baseCommand: viralflye_crispr_host_match.py
label: viralflye_crispr_host_match.py
doc: "A tool for CRISPR host matching within the viralFlye pipeline.\n\nTool homepage:
  https://github.com/Dmitry-Antipov/viralFlye/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viralflye:0.2--pyhdfd78af_0
stdout: viralflye_crispr_host_match.py.out
