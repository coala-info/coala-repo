cwlVersion: v1.2
class: CommandLineTool
baseCommand: multiqc
label: multiqc-xenium-extra_multiqc
doc: "MultiQC aggregates results from bioinformatics analyses across many samples
  into a single report. (Note: The provided help text contains only system error logs
  and no argument definitions).\n\nTool homepage: https://seqera.io/multiqc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/multiqc-xenium-extra:1.0.2--pyhdfd78af_0
stdout: multiqc-xenium-extra_multiqc.out
