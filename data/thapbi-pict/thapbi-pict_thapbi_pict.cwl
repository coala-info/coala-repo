cwlVersion: v1.2
class: CommandLineTool
baseCommand: thapbi-pict
label: thapbi-pict_thapbi_pict
doc: "THreat Assessment of Phytophthora BIdiversity - PIpeline for Comparison of Taxonomic
  markers (Note: The provided text appears to be a container build error log rather
  than CLI help text; no arguments could be extracted from the input).\n\nTool homepage:
  https://github.com/peterjc/thapbi-pict"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/thapbi-pict:1.0.21--pyhdfd78af_0
stdout: thapbi-pict_thapbi_pict.out
