cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - blobtk
  - depth
label: blobtk_depth
doc: "Calculate sequencing coverage depth.\n\nTool homepage: https://github.com/genomehubs/blobtk"
inputs:
  - id: bam_file
    type:
      - 'null'
      - File
    doc: Path to BAM file
    inputBinding:
      position: 101
      prefix: --bam
  - id: bin_size
    type:
      - 'null'
      - int
    doc: Bin size for coverage calculations (use 0 for full contig length)
    inputBinding:
      position: 101
      prefix: --bin-size
  - id: cram_file
    type:
      - 'null'
      - File
    doc: Path to CRAM file
    inputBinding:
      position: 101
      prefix: --cram
  - id: fasta_file
    type:
      - 'null'
      - File
    doc: Path to assembly FASTA input file (required for CRAM)
    inputBinding:
      position: 101
      prefix: --fasta
  - id: list_file
    type:
      - 'null'
      - File
    doc: Path to input file containing a list of sequence IDs
    inputBinding:
      position: 101
      prefix: --list
outputs:
  - id: output_bed_file
    type:
      - 'null'
      - File
    doc: Output bed file name
    outputBinding:
      glob: $(inputs.output_bed_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blobtk:0.7.1--py39hf6b2c50_0
