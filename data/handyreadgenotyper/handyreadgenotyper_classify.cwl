cwlVersion: v1.2
class: CommandLineTool
baseCommand: classify
label: handyreadgenotyper_classify
doc: "Classify reads in BAM file using existing model or train a model from bam files\n\
  \nTool homepage: https://github.com/AntonS-bio/HandyReadGenotyper"
inputs:
  - id: bams
    type: File
    doc: Directory with, list of, or individual BAM and corresponding BAM index 
      files (.bai)
    inputBinding:
      position: 101
      prefix: --bams
  - id: column_separator
    type:
      - 'null'
      - string
    doc: The column separator for the sample descriptions file
    inputBinding:
      position: 101
      prefix: --column_separator
  - id: cpus
    type:
      - 'null'
      - int
    doc: Number of CPU cores to use
    inputBinding:
      position: 101
      prefix: --cpus
  - id: description_column
    type:
      - 'null'
      - string
    doc: Column in sample description file to use to augmnet samples 
      descriptions
    inputBinding:
      position: 101
      prefix: --description_column
  - id: fastqs
    type:
      - 'null'
      - File
    doc: Directory with ONT run results or individual FASTQ file
    inputBinding:
      position: 101
      prefix: --fastqs
  - id: max_read_len_diff
    type:
      - 'null'
      - int
    doc: Specifies maximum nucleotide difference between mapped portion of read 
      and target amplicon
    inputBinding:
      position: 101
      prefix: --max_read_len_diff
  - id: max_soft_clip
    type:
      - 'null'
      - int
    doc: Specifies maximum permitted soft-clip (length of read before first and 
      last mapped bases) of mapped read
    inputBinding:
      position: 101
      prefix: --max_soft_clip
  - id: model
    type: File
    doc: Pickle (.pkl) file containing pretrained model. Model must be trained 
      on same reference
    inputBinding:
      position: 101
      prefix: --model
  - id: organism_presence_cutoff
    type:
      - 'null'
      - float
    doc: Sample is reported as having target organism if at least this 
      percentage of non-transient amplicons have >10 reads. Values 0-100.
    inputBinding:
      position: 101
      prefix: --organism_presence_cutoff
  - id: sample_descriptions
    type:
      - 'null'
      - File
    doc: File with sample descriptions (tab delimited), first column must be the
      BAM file name without .bam
    inputBinding:
      position: 101
      prefix: --sample_descriptions
outputs:
  - id: output_file
    type: File
    doc: File to store classification results
    outputBinding:
      glob: $(inputs.output_file)
  - id: target_reads_bams
    type:
      - 'null'
      - Directory
    doc: Directory to which to write reads classified as target organism
    outputBinding:
      glob: $(inputs.target_reads_bams)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/handyreadgenotyper:0.1.24--pyhdfd78af_0
