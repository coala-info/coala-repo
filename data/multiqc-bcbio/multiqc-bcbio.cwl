cwlVersion: v1.2
class: CommandLineTool
baseCommand: multiqc-bcbio
label: multiqc-bcbio
doc: "MultiQC reporting tool for bcbio-nextgen bioinformatics pipelines.\n\nTool homepage:
  http://multiqc.info"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/multiqc-bcbio:0.2.9--pyh3252c3a_0
stdout: multiqc-bcbio.out
