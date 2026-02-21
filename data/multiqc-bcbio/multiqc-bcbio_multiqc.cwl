cwlVersion: v1.2
class: CommandLineTool
baseCommand: multiqc
label: multiqc-bcbio_multiqc
doc: "MultiQC aggregates results from bioinformatics analyses across many samples
  into a single report. (Note: The provided help text contains only container runtime
  error messages and no argument definitions.)\n\nTool homepage: http://multiqc.info"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/multiqc-bcbio:0.2.9--pyh3252c3a_0
stdout: multiqc-bcbio_multiqc.out
