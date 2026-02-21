cwlVersion: v1.2
class: CommandLineTool
baseCommand: multiqc
label: multiqc_sav_multiqc
doc: "MultiQC aggregates results from bioinformatics analyses across many samples
  into a single report. (Note: The provided text appears to be a container execution
  error log rather than help text, so no arguments could be extracted.)\n\nTool homepage:
  http://multiqc.info"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/multiqc:1.33--pyhdfd78af_0
stdout: multiqc_sav_multiqc.out
