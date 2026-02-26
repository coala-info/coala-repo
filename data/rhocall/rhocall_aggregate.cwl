cwlVersion: v1.2
class: CommandLineTool
baseCommand: rhocall aggregate
label: rhocall_aggregate
doc: "Aggregate runs of autozygosity from rhofile into windowed rho BED file.\nAccepts
  a bcftools roh style TSV-file with CHR,POS,AZ,QUAL.\n\nTool homepage: https://github.com/dnil/rhocall"
inputs:
  - id: roh_file
    type: File
    doc: ROH file (bcftools roh style TSV)
    inputBinding:
      position: 1
  - id: quality_threshold
    type:
      - 'null'
      - float
    doc: Minimum quality trusted to start or end ROH-windows.
    inputBinding:
      position: 102
      prefix: --quality_threshold
  - id: verbose
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_filename
    type:
      - 'null'
      - File
    doc: Output FILENAME
    outputBinding:
      glob: $(inputs.output_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rhocall:0.5.1--py312h0fa9677_5
