cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deepsvr
  - prepare_data
label: deepsvr_prepare_data
doc: "Prepare data for training or classification.\n\nTool homepage: https://github.com/griffithlab/deepsvr"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: '$(inputs.sample_files ? inputs.sample_files : [])'
inputs:
  - id: header
    type:
      - 'null'
      - boolean
    doc: "Specify whether header is present in sample file"
    inputBinding:
      position: 101
      prefix: --header
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: "Specify that no header is present in sample file (default)"
    inputBinding:
      position: 101
      prefix: --no-header
  - id: skip_bam_readcount
    type:
      - 'null'
      - boolean
    doc: "If bam readcount files already exist in output directory as a result of a prior run of the prepare_data command, skip the bam-readcount step"
    inputBinding:
      position: 101
      prefix: --skip_bam_readcount
  - id: no_skip_bam_readcount
    type:
      - 'null'
      - boolean
    doc: "Do not skip the bam-readcount step (default)"
    inputBinding:
      position: 101
      prefix: --no-skip_bam_readcount
  - id: samples_file_path
    type: File
    doc: "File path of tsv file with sample information. Columns in order: sample_name, tumor_bam_path, normal_bam_path, manual_review_file_path, reviewer, solid_tumor, reference_genome_fasta_file_path."
    inputBinding:
      position: 101
      prefix: --samples-file-path
  - id: sample_files
    type:
      - 'null'
      - File[]
    doc: "BAM (with .bai), manual review and reference FASTA (with .fai) files named in the samples file; staged into the working directory so relative names resolve (not passed on the command line)"
    inputBinding:
      position: 101
      valueFrom: $(null)
  - id: output_dir_path
    type: string
    doc: "Specify output directory: Readcount files and compressed pandas dataframe will be output here (default:~/training_data)"
    inputBinding:
      position: 101
      prefix: --output-dir-path
outputs:
  - id: output_dir
    type: Directory
    doc: readcount files and prepared pandas dataframes (train.pkl, call.pkl)
    outputBinding:
      glob: $(inputs.output_dir_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepsvr:0.1.0--py_0
