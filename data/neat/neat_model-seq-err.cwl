cwlVersion: v1.2
class: CommandLineTool
baseCommand: neat model-seq-err
label: neat_model-seq-err
doc: "Generate sequencing error model from a FASTQ, BAM, or SAM file_list.\n\nTool
  homepage: https://github.com/ncsa/NEAT/"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: fastq(.gz) to process. Entering 1 fastqs will set the modeler to 
      single-ended mode. Use -i2 for paired ended models.To use a sam/bam input 
      first convert to fastq using an external tool, such as samtools.
    inputBinding:
      position: 1
  - id: max_reads
    type:
      - 'null'
      - int
    doc: Max number of reads to process
    inputBinding:
      position: 102
      prefix: -m
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite previous output files. Default is to throw an error if the 
      file_list already exists.
    inputBinding:
      position: 102
      prefix: --overwrite
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix to use to name files
    inputBinding:
      position: 102
      prefix: --prefix
  - id: quality_offset
    type:
      - 'null'
      - int
    doc: quality score offset
    default: 33
    inputBinding:
      position: 102
      prefix: -q
  - id: quality_scores
    type:
      - 'null'
      - type: array
        items: int
    doc: Quality score max. The default 42. The lowest possible score is 1. To 
      used binnedscoring, enter a space separated list of scores, e.g., -Q 2 15 
      23 37
    default: 42
    inputBinding:
      position: 102
      prefix: -Q
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Path to the output directory. Will create if not present.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neat:4.3.5--pyhdfd78af_0
