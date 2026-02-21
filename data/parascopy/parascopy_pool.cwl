cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - parascopy
  - pool
label: parascopy_pool
doc: "Pool reads from various copies of a duplication.\n\nTool homepage: https://github.com/tprodanov/parascopy"
inputs:
  - id: bam
    type:
      - 'null'
      - boolean
    doc: Write BAM files to the output directory instead of CRAM.
    inputBinding:
      position: 101
      prefix: --bam
  - id: exclude
    type:
      - 'null'
      - string
    doc: Exclude duplications for which the expression is true
    default: length < 500 && seq_sim < 0.97
    inputBinding:
      position: 101
      prefix: --exclude
  - id: fasta_ref
    type: File
    doc: Input reference fasta file.
    inputBinding:
      position: 101
      prefix: --fasta-ref
  - id: input
    type:
      - 'null'
      - type: array
        items: File
    doc: Input indexed BAM/CRAM files. All entries should follow the format "filename[::sample]"
    inputBinding:
      position: 101
      prefix: --input
  - id: input_list
    type:
      - 'null'
      - File
    doc: A file containing a list of input BAM/CRAM files. All lines should follow
      the format "filename[ sample]"
    inputBinding:
      position: 101
      prefix: --input-list
  - id: mate_dist
    type:
      - 'null'
      - string
    doc: Output read mates even if they are outside of the duplication, if the distance
      between mates is less than <int>. Use 0 to skip all mates outside the duplicated
      regions. Use inf|infinity to write all mapped read mates.
    default: '5000'
    inputBinding:
      position: 101
      prefix: --mate-dist
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not write information to the stderr.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: region
    type: string
    doc: Single region in format "chr:start-end". Start and end are 1-based inclusive.
    inputBinding:
      position: 101
      prefix: --region
  - id: samtools
    type:
      - 'null'
      - string
    doc: Path to samtools executable. Use python wrapper if "none", can lead to errors.
    default: samtools
    inputBinding:
      position: 101
      prefix: --samtools
  - id: table
    type: File
    doc: Input indexed bed table with information about segmental duplications.
    inputBinding:
      position: 101
      prefix: --table
outputs:
  - id: output
    type: Directory
    doc: Output BAM/CRAM file if corresponding extension is used. Otherwise, write
      CRAM files in the output directory.
    outputBinding:
      glob: $(inputs.output)
  - id: only_regions
    type:
      - 'null'
      - File
    doc: Append regions, used for pooling and realigning, to this file, and stop.
    outputBinding:
      glob: $(inputs.only_regions)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parascopy:1.19.0--py312hc576ae5_0
