cwlVersion: v1.2
class: CommandLineTool
baseCommand: gs-tama_tama_cds_regions_bed_add.py
label: gs-tama_tama_cds_regions_bed_add.py
doc: "A tool from the TAMA suite, likely used for adding CDS regions to BED files.
  Note: The provided help text contains only system error messages regarding container
  execution and does not list specific arguments.\n\nTool homepage: https://github.com/sguizard/gs-tama"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
stdout: gs-tama_tama_cds_regions_bed_add.py.out
