cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tooldistillator.py
  - bwa
label: tooldistillator_bwa
doc: "Extract information from output(s) of bwa (input.bam)\n\nTool homepage: https://gitlab.com/ifb-elixirfr/abromics"
inputs:
  - id: report
    type: File
    doc: Path to report(s)
    inputBinding:
      position: 1
  - id: analysis_software_version
    type:
      - 'null'
      - string
    doc: bwa version number for bwa
    inputBinding:
      position: 102
      prefix: --analysis_software_version
  - id: hid
    type:
      - 'null'
      - string
    doc: Historic ID to bwa contigs file from Galaxy for bwa
    inputBinding:
      position: 102
      prefix: --hid
  - id: paired_second_file_hid
    type:
      - 'null'
      - string
    doc: Galaxy HID to the paired file for bwa
    inputBinding:
      position: 102
      prefix: --paired_second_file_hid
  - id: paired_second_file_path
    type:
      - 'null'
      - File
    doc: if paired inputs are uses for bwa
    inputBinding:
      position: 102
      prefix: --paired_second_file_path
  - id: reference_database_version
    type:
      - 'null'
      - string
    doc: bwa reference genome for bwa
    inputBinding:
      position: 102
      prefix: --reference_database_version
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output location
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
