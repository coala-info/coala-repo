cwlVersion: v1.2
class: CommandLineTool
baseCommand: magphi
label: magphi
doc: "A tool for the extraction and analysis of prophages and other genomic islands
  from bacterial genomes.\n\nTool homepage: https://github.com/milnus/Magphi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/magphi:2.0.2--pyhdfd78af_0
stdout: magphi.out
