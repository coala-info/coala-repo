cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tooldistillator.py
  - deeparg
label: tooldistillator_deeparg
doc: "Extract information from output(s) of deeparg (report.txt)\n\nTool homepage:
  https://gitlab.com/ifb-elixirfr/abromics"
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
    doc: deeparg version for deeparg
    inputBinding:
      position: 102
      prefix: --analysis_software_version
  - id: bam_clean_file_hid
    type:
      - 'null'
      - string
    doc: Historic ID to clean alignment file from Galaxy for deeparg
    inputBinding:
      position: 102
      prefix: --bam_clean_file_hid
  - id: bam_clean_file_path
    type:
      - 'null'
      - File
    doc: Binary Alignment clean file from deeparg for deeparg
    inputBinding:
      position: 102
      prefix: --bam_clean_file_path
  - id: bam_clean_sorted_file_hid
    type:
      - 'null'
      - string
    doc: Historic ID to clean sorted alignment file from Galaxy for deeparg
    inputBinding:
      position: 102
      prefix: --bam_clean_sorted_file_hid
  - id: bam_clean_sorted_file_path
    type:
      - 'null'
      - File
    doc: Binary Alignment clean sorted file from deeparg for deeparg
    inputBinding:
      position: 102
      prefix: --bam_clean_sorted_file_path
  - id: daa_clean_align_file_hid
    type:
      - 'null'
      - string
    doc: Historic ID to daa sorted alignment file from Galaxy for deeparg
    inputBinding:
      position: 102
      prefix: --daa_clean_align_file_hid
  - id: daa_clean_align_file_path
    type:
      - 'null'
      - File
    doc: DAA clean align file from deeparg for deeparg
    inputBinding:
      position: 102
      prefix: --daa_clean_align_file_path
  - id: hid
    type:
      - 'null'
      - string
    doc: historic ID for deeparg file from galaxy for deeparg
    inputBinding:
      position: 102
      prefix: --hid
  - id: reference_database_version
    type:
      - 'null'
      - string
    doc: DB version for deeparg
    inputBinding:
      position: 102
      prefix: --reference_database_version
  - id: report_arg_merged_hid
    type:
      - 'null'
      - string
    doc: historic ID to ARG merged report file from Galaxy for deeparg
    inputBinding:
      position: 102
      prefix: --report_ARG_merged_hid
  - id: report_arg_merged_path
    type:
      - 'null'
      - File
    doc: DeepARG ARG merged report file for deeparg
    inputBinding:
      position: 102
      prefix: --report_ARG_merged_path
  - id: report_arg_merged_quant_subtype_hid
    type:
      - 'null'
      - string
    doc: historic ID to ARG merged quant subtype report file from Galaxy for 
      deeparg
    inputBinding:
      position: 102
      prefix: --report_ARG_merged_quant_subtype_hid
  - id: report_arg_merged_quant_subtype_path
    type:
      - 'null'
      - File
    doc: DeepARG ARG merged quant subtype report file for deeparg
    inputBinding:
      position: 102
      prefix: --report_ARG_merged_quant_subtype_path
  - id: report_arg_merged_quant_type_hid
    type:
      - 'null'
      - string
    doc: historic ID to ARG merged quant type report file from Galaxy for 
      deeparg
    inputBinding:
      position: 102
      prefix: --report_ARG_merged_quant_type_hid
  - id: report_arg_merged_quant_type_path
    type:
      - 'null'
      - File
    doc: DeepARG ARG merged quant type report file for deeparg
    inputBinding:
      position: 102
      prefix: --report_ARG_merged_quant_type_path
  - id: report_potential_arg_hid
    type:
      - 'null'
      - string
    doc: historic ID to potential ARG report file from Galaxy for deeparg
    inputBinding:
      position: 102
      prefix: --report_potential_ARG_hid
  - id: report_potential_arg_path
    type:
      - 'null'
      - File
    doc: DeepARG potential ARG report file for deeparg
    inputBinding:
      position: 102
      prefix: --report_potential_ARG_path
  - id: sam_clean_file_hid
    type:
      - 'null'
      - string
    doc: Historic ID to clean alignment file from Galaxy for deeparg
    inputBinding:
      position: 102
      prefix: --sam_clean_file_hid
  - id: sam_clean_file_path
    type:
      - 'null'
      - File
    doc: Sequence Alignment clean file from deeparg for deeparg
    inputBinding:
      position: 102
      prefix: --sam_clean_file_path
  - id: sequence_clean_file_hid
    type:
      - 'null'
      - string
    doc: Historic ID to sequence clean file from Galaxy for deeparg
    inputBinding:
      position: 102
      prefix: --sequence_clean_file_hid
  - id: sequence_clean_file_path
    type:
      - 'null'
      - File
    doc: Sequence clean file from deeparg for deeparg
    inputBinding:
      position: 102
      prefix: --sequence_clean_file_path
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
