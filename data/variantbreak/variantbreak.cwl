cwlVersion: v1.2
class: CommandLineTool
baseCommand: variantbreak
label: variantbreak
doc: "VariantBreak is a structural variant (SV) breakend analyzer that intersects
  and merges SV breakends from NanoVar VCF files or variant BED files for visualization
  on VariantMap or summarized into a CSV file. It also annotates and filters all SVs
  across all samples according to user input GTF/GFF/BED files.\n\nTool homepage:
  https://github.com/cytham/variantbreak"
inputs:
  - id: variant_path
    type: File
    doc: 'path to single variant file or directory containing variant files of VCF
      (NanoVar-v1.3.6 or above) or BED formats. Formats: .vcf/.bed'
    inputBinding:
      position: 1
  - id: working_directory
    type: Directory
    doc: path to working directory. Directory will be created if it does not 
      exist.
    inputBinding:
      position: 2
  - id: annotation_file_dir
    type:
      - 'null'
      - File
    doc: 'path to single annotation file or directory containing annotation files
      of GTF/GFF or BED formats. Formats: .gtf/.gff/.gff3/.bed'
    inputBinding:
      position: 103
      prefix: --annotation_file_dir
  - id: auto_filter
    type:
      - 'null'
      - boolean
    doc: automatically removes variants that intersected with all filter BED 
      files
    inputBinding:
      position: 103
      prefix: --auto_filter
  - id: cluster_sample
    type:
      - 'null'
      - boolean
    doc: performs hierarchical clustering on samples
    inputBinding:
      position: 103
      prefix: --cluster_sample
  - id: del_annotate_size
    type:
      - 'null'
      - int
    doc: Deletions with sizes lower or equal to this value will have the entire 
      deleted region annotated. Any genes that intersect with the deleted region
      will be included as annotation. On the contrary, if deletion size is 
      greater than this value, only the deletion breakends will be annotated, 
      omitting any annotation of the middle deleted region. In other words, only
      genes intersecting with the deletion breakends will be included as 
      annotation. This is done to reduce false annotations due to false large 
      deletions. Note that the value to be set is an absolute deletion size, do 
      not use minus '-'. Use value '-1' to disable this threshold and annotate 
      all deleted regions despite of size.
    inputBinding:
      position: 103
      prefix: --del_annotate_size
  - id: filename
    type:
      - 'null'
      - string
    doc: File name prefix of output files
    inputBinding:
      position: 103
      prefix: --filename
  - id: filter_file_dir
    type:
      - 'null'
      - File
    doc: 'path to single filter file or directory containing filter files of BED format.
      Format: .bed'
    inputBinding:
      position: 103
      prefix: --filter_file_dir
  - id: max_annotation
    type:
      - 'null'
      - int
    doc: maximum number of annotation entries to be recorded in the dataframe 
      for each SV
    inputBinding:
      position: 103
      prefix: --max_annotation
  - id: merge_buffer
    type:
      - 'null'
      - int
    doc: nucleotide length buffer for SV breakend clustering
    inputBinding:
      position: 103
      prefix: --merge_buffer
  - id: promoter_size
    type:
      - 'null'
      - int
    doc: length in base-pairs upstream of TSS to define promoter region
    inputBinding:
      position: 103
      prefix: --promoter_size
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: hide verbose
    inputBinding:
      position: 103
      prefix: --quiet
  - id: sep
    type:
      - 'null'
      - string
    doc: single character field delimiter for output dataframe CSV file (e.g. 
      '\t' for tab or ',' for comma)
    inputBinding:
      position: 103
      prefix: --sep
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/variantbreak:1.0.4--py_0
stdout: variantbreak.out
