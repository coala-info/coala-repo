cwlVersion: v1.2
class: CommandLineTool
baseCommand: dr-disco classify
label: dr-disco_classify
doc: "Classify junctions based on alignment data.\n\nTool homepage: https://github.com/yhoogstrate/dr-disco"
inputs:
  - id: table_input_file
    type: File
    doc: Input table file containing junction data.
    inputBinding:
      position: 1
  - id: blacklist_junctions
    type:
      - 'null'
      - string
    doc: Blacklist these region-to-region junctions (custom format, see files in
      ./share/)
    inputBinding:
      position: 102
      prefix: --blacklist-junctions
  - id: blacklist_regions
    type:
      - 'null'
      - File
    doc: Blacklist these regions (BED file)
    inputBinding:
      position: 102
      prefix: --blacklist-regions
  - id: ffpe
    type:
      - 'null'
      - boolean
    doc: Lowers the threshold for the relative amount of mismatches, as often 
      found in FFPE material. Note that enabling this option will consequently 
      result in more false positives.
    inputBinding:
      position: 102
      prefix: --ffpe
  - id: min_chim_overhang
    type:
      - 'null'
      - int
    doc: Minimum alignment length on each side of the junction. May need to be 
      set to smaller values for read lengths smaller than 75bp. Larger values 
      are more stringent.
    inputBinding:
      position: 102
      prefix: --min-chim-overhang
  - id: only_valid
    type:
      - 'null'
      - boolean
    doc: Only return results marked as 'valid'
    inputBinding:
      position: 102
      prefix: --only-valid
outputs:
  - id: table_output_file
    type: File
    doc: Output table file for classified junctions.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dr-disco:0.18.3--pyh086e186_0
