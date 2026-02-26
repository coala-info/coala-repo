cwlVersion: v1.2
class: CommandLineTool
baseCommand: accusnv
label: accusnv
doc: "Apply filters and CNN to call SNVs for closely related bacterial isolates.\n\
  \nTool homepage: https://github.com/liaoherui/AccuSNV"
inputs:
  - id: exclude_samp
    type:
      - 'null'
      - string
    doc: The names of the samples you want to exclude (e.g. -e S1,S2,S3). If you
      specify a number, such as "-e 1000", any sample with more than 1,000 SNVs 
      will be automatically excluded.
    inputBinding:
      position: 101
      prefix: --excluse_samples
  - id: generate_rep
    type:
      - 'null'
      - int
    doc: If not generate html report and other related files, set to 0.
    default: 1
    inputBinding:
      position: 101
      prefix: --generate_report
  - id: input_cov
    type:
      - 'null'
      - File
    doc: The input coverage table in npz file
    inputBinding:
      position: 101
      prefix: --input_cov
  - id: input_mat
    type: File
    doc: The input mutation table in npz file
    inputBinding:
      position: 101
      prefix: --input_mat
  - id: min_cov
    type:
      - 'null'
      - int
    doc: 'For the filter module: on individual samples, calls must have at least this
      many reads on the fwd/rev strands individually. If many samples have low coverage
      (e.g. <5), then you can set this parameter to smaller value. (e.g. -v 2).'
    default: 5
    inputBinding:
      position: 101
      prefix: --min_cov_for_filter_pos
  - id: min_cov_samp
    type:
      - 'null'
      - int
    doc: Before running the CNN model, low-quality samples with more than 45% of
      positions having zero aligned reads will be filtered out. You can adjust 
      this threshold with this parameter; to include all samples, set "-s 100".
    default: 45
    inputBinding:
      position: 101
      prefix: --min_cov_for_filter_sample
  - id: ref_genome
    type:
      - 'null'
      - File
    doc: The reference genome
    inputBinding:
      position: 101
      prefix: --rer
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: The output dir
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/accusnv:1.0.0.5--pyhdfd78af_0
