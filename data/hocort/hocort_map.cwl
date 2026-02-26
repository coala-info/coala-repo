cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hocort
  - map
label: hocort_map
doc: "map reads to a reference genome and output mapped/unmapped reads\n\nTool homepage:
  https://github.com/ignasrum/hocort"
inputs:
  - id: pipeline
    type: string
    doc: 'pipeline to run (available: bbmap, biobloom, bowtie2, bwamem2, hisat2, kraken2,
      kraken2bowtie2, kraken2hisat2, kraken2minimap2, minimap2)'
    inputBinding:
      position: 1
  - id: debug
    type:
      - 'null'
      - boolean
    doc: verbose output
    inputBinding:
      position: 102
      prefix: --debug
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: quiet output (overrides -d/--debug)
    inputBinding:
      position: 102
      prefix: --quiet
outputs:
  - id: log_file
    type:
      - 'null'
      - File
    doc: path to log file
    outputBinding:
      glob: $(inputs.log_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hocort:1.2.2--py39hdfd78af_0
