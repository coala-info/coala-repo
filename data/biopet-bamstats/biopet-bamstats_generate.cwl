cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biopet
  - bamstats
  - generate
label: biopet-bamstats_generate
doc: "Generate statistics for a BAM file, including information about mapping quality,
  clipping, and region-specific stats.\n\nTool homepage: https://github.com/biopet/bamstats"
inputs:
  - id: bam
    type: File
    doc: Input bam file
    inputBinding:
      position: 101
      prefix: --bam
  - id: bed_file
    type:
      - 'null'
      - File
    doc: Extract information for the regions specified in the bedfile.
    inputBinding:
      position: 101
      prefix: --bedFile
  - id: log_level
    type:
      - 'null'
      - string
    doc: "Level of log information printed. Possible levels: 'debug', 'info', 'warn',
      'error'"
    inputBinding:
      position: 101
      prefix: --log_level
  - id: only_unmapped
    type:
      - 'null'
      - boolean
    doc: Only returns stats on unmapped reads. (This is excluding singletons.
    inputBinding:
      position: 101
      prefix: --onlyUnmapped
  - id: reference
    type:
      - 'null'
      - File
    doc: Fasta file of reference
    inputBinding:
      position: 101
      prefix: --reference
  - id: scatter_mode
    type:
      - 'null'
      - boolean
    doc: Exclude reads from which the start originates from another region. This is
      useful for running multiple instances of bamstats each on a different region.
      The files can be merged afterwards without duplicates.
    inputBinding:
      position: 101
      prefix: --scatterMode
  - id: tsv_outputs
    type:
      - 'null'
      - boolean
    doc: Also output tsv files, default there is only a json
    inputBinding:
      position: 101
      prefix: --tsvOutputs
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet-bamstats:1.0.1--0
