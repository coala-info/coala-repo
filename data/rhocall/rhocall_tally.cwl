cwlVersion: v1.2
class: CommandLineTool
baseCommand: rhocall tally
label: rhocall_tally
doc: "Tally runs of autozygosity from rhofile. Accepts a bcftools roh style TSV-file
  with CHR,POS,AZ,QUAL.\n\nTool homepage: https://github.com/dnil/rhocall"
inputs:
  - id: roh_file
    type: File
    doc: ROH file in bcftools roh style TSV format (CHR,POS,AZ,QUAL)
    inputBinding:
      position: 1
  - id: flag_upd_at_fraction
    type:
      - 'null'
      - float
    doc: Flag UPD if this fraction of chr quality positions called AZ.
    inputBinding:
      position: 102
      prefix: --flag_upd_at_fraction
  - id: quality_threshold
    type:
      - 'null'
      - float
    doc: Minimum quality that counts towards region totals.
    inputBinding:
      position: 102
      prefix: --quality_threshold
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_filename
    type:
      - 'null'
      - File
    doc: Output filename.
    outputBinding:
      glob: $(inputs.output_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rhocall:0.5.1--py312h0fa9677_5
