cwlVersion: v1.2
class: CommandLineTool
baseCommand: multiqc
label: zavolan-multiqc-plugins_multiqc
doc: "MultiQC aggregates results from bioinformatics analyses across many samples
  into a single report. (Note: The provided text contains container runtime logs and
  a fatal error rather than help text; no arguments could be extracted.)\n\nTool homepage:
  https://github.com/zavolanlab/multiqc-plugins"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/zavolan-multiqc-plugins:1.3--pyh5e36f6f_0
stdout: zavolan-multiqc-plugins_multiqc.out
