cwlVersion: v1.2
class: CommandLineTool
baseCommand: bcbio_nextgen.py
label: bcbio-nextgen
doc: "Validated, scalable, community-developed variant calling, RNA-seq and small
  RNA analysis pipeline. (Note: The provided input text appears to be a system error
  log regarding a container build failure and does not contain the standard help documentation
  for the tool.)\n\nTool homepage: https://github.com/bcbio/bcbio-nextgen"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcbio-nextgen:1.0.5--py27_0
stdout: bcbio-nextgen.out
