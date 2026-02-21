cwlVersion: v1.2
class: CommandLineTool
baseCommand: multiqc
label: multiqc
doc: "MultiQC aggregates results from bioinformatics analyses across many samples
  into a single report.\n\nTool homepage: https://multiqc.info/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/multiqc:1.33--pyhdfd78af_0
stdout: multiqc.out
