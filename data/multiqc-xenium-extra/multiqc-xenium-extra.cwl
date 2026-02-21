cwlVersion: v1.2
class: CommandLineTool
baseCommand: multiqc-xenium-extra
label: multiqc-xenium-extra
doc: "A tool for aggregating bioinformatics results, specifically with extras for
  Xenium data. (Note: The provided text is a system error message regarding container
  image creation and does not contain usage instructions or argument definitions.)\n
  \nTool homepage: https://seqera.io/multiqc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/multiqc-xenium-extra:1.0.2--pyhdfd78af_0
stdout: multiqc-xenium-extra.out
