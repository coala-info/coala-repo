cwlVersion: v1.2
class: CommandLineTool
baseCommand: famli
label: famli_align
doc: "Align a set of reads with DIAMOND, filter alignments with FAMLI, and return
  the results\n\nTool homepage: https://github.com/FredHutch/FAMLI"
inputs:
  - id: batchsize
    type:
      - 'null'
      - int
    doc: Number of reads to process at a time.
    inputBinding:
      position: 101
      prefix: --batchsize
  - id: blocks
    type:
      - 'null'
      - int
    doc: Number of blocks used when aligning. Value relates to the amount of 
      memory used. Roughly 6Gb RAM used by DIAMOND per block.
    inputBinding:
      position: 101
      prefix: --blocks
  - id: input
    type: string
    doc: 'Location for input file(s). Combine multiple files with +. (Supported: sra://,
      s3://, or ftp://).'
    inputBinding:
      position: 101
      prefix: --input
  - id: min_qual
    type:
      - 'null'
      - int
    doc: Trim reads to a minimum Q score.
    inputBinding:
      position: 101
      prefix: --min-qual
  - id: min_score
    type:
      - 'null'
      - float
    doc: Minimum alignment score to report.
    inputBinding:
      position: 101
      prefix: --min-score
  - id: query_gencode
    type:
      - 'null'
      - int
    doc: Genetic code used to translate nucleotides.
    inputBinding:
      position: 101
      prefix: --query-gencode
  - id: ref_db
    type: Directory
    doc: 'Folder containing reference database. (Supported: s3://, ftp://, or local
      path).'
    inputBinding:
      position: 101
      prefix: --ref-db
  - id: sample_name
    type: string
    doc: Name of sample, sets output filename.
    inputBinding:
      position: 101
      prefix: --sample-name
  - id: temp_folder
    type:
      - 'null'
      - Directory
    doc: Folder used for temporary files.
    inputBinding:
      position: 101
      prefix: --temp-folder
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use aligning.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_folder
    type: Directory
    doc: 'Folder to place results. (Supported: s3://, or local path).'
    outputBinding:
      glob: $(inputs.output_folder)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/famli:v1.0_cv2
