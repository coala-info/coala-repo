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
    inputBinding:
      position: 101
      prefix: --exclude
  - id: fasta_ref
    type: File
    secondaryFiles:
      - .fai
    doc: Input reference fasta file.
    inputBinding:
      position: 101
      prefix: --fasta-ref
  - id: input
    type:
      - 'null'
      - type: array
        items: File
    secondaryFiles:
      - .bai
      - pattern: .crai
        required: false
    doc: Input indexed BAM/CRAM files. All entries should follow the format 
      "filename[::sample]"
    inputBinding:
      position: 101
      prefix: --input
  - id: input_list
    type:
      - 'null'
      - File
    doc: A file containing a list of input BAM/CRAM files. All lines should 
      follow the format "filename[ sample]"
    inputBinding:
      position: 101
      prefix: --input-list
  - id: mate_dist
    type:
      - 'null'
      - string
    doc: Output read mates even if they are outside of the duplication, if the 
      distance between mates is less than <int>. Use 0 to skip all mates outside
      the duplicated regions. Use inf|infinity to write all mapped read mates.
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
    doc: Single region in format "chr:start-end". Start and end are 1-based 
      inclusive.
    inputBinding:
      position: 101
      prefix: --region
  - id: samtools
    type:
      - 'null'
      - string
    doc: Path to samtools executable. Use python wrapper if "none", can lead to 
      errors.
    inputBinding:
      position: 101
      prefix: --samtools
  - id: table
    type: File
    secondaryFiles:
      - .tbi
    doc: Input indexed bed table with information about segmental duplications.
    inputBinding:
      position: 101
      prefix: --table
  - id: only_regions_path
    type:
      - 'null'
      - string
    inputBinding:
      position: 102
      prefix: --only-regions
  - id: output_path
    type: string
    doc: Output BAM/CRAM file if the name has a .bam/.cram extension; otherwise
      an output directory that receives CRAM (or BAM with --bam) files.
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory with the pooled CRAM/BAM files (when --output is a directory).
    outputBinding:
      glob: '$(inputs.output_path.match(/[.](bam|cram)$/) ? "__none__" : inputs.output_path)'
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output BAM/CRAM file (when --output has a .bam/.cram extension).
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: .crai
        required: false
    outputBinding:
      glob: '$(inputs.output_path.match(/[.](bam|cram)$/) ? inputs.output_path : "__none__")'
  - id: only_regions
    type:
      - 'null'
      - File
    doc: Append regions, used for pooling and realigning, to this file, and 
      stop.
    outputBinding:
      glob: $(inputs.only_regions_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parascopy:1.19.0--py312hc576ae5_0
