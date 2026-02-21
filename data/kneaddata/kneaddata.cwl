cwlVersion: v1.2
class: CommandLineTool
baseCommand: kneaddata
label: kneaddata
doc: "KneadData is a tool in the bioBakery suite designed to perform quality control
  on metagenomic sequencing data, primarily by removing host-derived reads.\n\nTool
  homepage: https://huttenhower.sph.harvard.edu/kneaddata"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kneaddata:0.12.4--pyhdfd78af_0
stdout: kneaddata.out
