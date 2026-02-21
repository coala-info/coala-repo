cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tb_variant_filter
  - tb_region_list_to_bed
label: tb_variant_filter_tb_region_list_to_bed
doc: "Convert TB region list to BED format. (Note: The provided text contains container
  execution errors rather than help documentation; no arguments could be extracted.)\n
  \nTool homepage: http://github.com/pvanheus/tb_variant_filter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tb_variant_filter:0.4.0--pyhdfd78af_0
stdout: tb_variant_filter_tb_region_list_to_bed.out
