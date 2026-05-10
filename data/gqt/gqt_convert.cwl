cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gqt
  - convert
label: gqt_convert
doc: "Convert VCF/BCF to GQT index or sample phenotype database\n\nTool homepage:
  https://github.com/ryanlayer/gqt"
inputs:
  - id: type
    type: string
    doc: 'Type of conversion: bcf (create GQT index) or ped (create sample phenotype
      database)'
    inputBinding:
      position: 1
  - id: input_file
    type: File
    doc: Input VCF/VCF.GZ/BCF file
    inputBinding:
      position: 102
      prefix: -i
  - id: num_samples
    type:
      - 'null'
      - int
    doc: Number of samples (opt. with index)
    inputBinding:
      position: 102
      prefix: -f
  - id: num_variants
    type:
      - 'null'
      - int
    doc: Number of variants (opt. with index)
    inputBinding:
      position: 102
      prefix: -r
  - id: ped_file
    type:
      - 'null'
      - File
    doc: PED file name
    inputBinding:
      position: 102
      prefix: -p
  - id: ped_sample_name_column
    type:
      - 'null'
      - int
    doc: Sample name column in PED
    inputBinding:
      position: 102
      prefix: -c
  - id: tmp_working_directory
    type:
      - 'null'
      - Directory
    doc: Tmp working directory
    inputBinding:
      position: 102
      prefix: -t
  - id: bim_output_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `bim_output_file_path`
    inputBinding:
      position: 103
      prefix: --bim-output-file
  - id: gqt_output_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `gqt_output_file_path`
    inputBinding:
      position: 104
      prefix: --gqt-output-file
  - id: off_output_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `off_output_file_path`
    inputBinding:
      position: 105
      prefix: --off-output-file
  - id: ped_db_output_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `ped_db_output_file_path`
    inputBinding:
      position: 106
      prefix: --ped-db-output-file
  - id: vid_output_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `vid_output_file_path`
    inputBinding:
      position: 107
      prefix: --vid-output-file
outputs:
  - id: gqt_output_file
    type:
      - 'null'
      - File
    doc: GQT output file name
    outputBinding:
      glob: $(inputs.gqt_output_file_path)
  - id: vid_output_file
    type:
      - 'null'
      - File
    doc: VID output file name
    outputBinding:
      glob: $(inputs.vid_output_file_path)
  - id: off_output_file
    type:
      - 'null'
      - File
    doc: OFF output file name
    outputBinding:
      glob: $(inputs.off_output_file_path)
  - id: bim_output_file
    type:
      - 'null'
      - File
    doc: BIM output file name
    outputBinding:
      glob: $(inputs.bim_output_file_path)
  - id: ped_db_output_file
    type:
      - 'null'
      - File
    doc: PED DB output file name
    outputBinding:
      glob: $(inputs.ped_db_output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gqt:1.1.3--h0263287_3
