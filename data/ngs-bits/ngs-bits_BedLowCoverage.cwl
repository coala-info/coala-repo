cwlVersion: v1.2
class: CommandLineTool
baseCommand: BedLowCoverage
label: ngs-bits_BedLowCoverage
doc: "Detects low-coverage regions from a BAM/CRAM file.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: cutoff
    type: int
    doc: Minimum depth to consider a base 'high coverage'.
    inputBinding:
      position: 101
      prefix: -cutoff
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable debug output.
    inputBinding:
      position: 101
      prefix: -debug
  - id: input_bam
    type: File
    doc: Input BAM/CRAM file.
    inputBinding:
      position: 101
      prefix: -bam
  - id: input_bed
    type:
      - 'null'
      - File
    doc: Input BED file containing the regions of interest. If unset, reads from
      STDIN.
    inputBinding:
      position: 101
      prefix: -in
  - id: min_baseq
    type:
      - 'null'
      - int
    doc: Minimum base quality to consider a base.
    inputBinding:
      position: 101
      prefix: -min_baseq
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Minimum mapping quality to consider a read.
    inputBinding:
      position: 101
      prefix: -min_mapq
  - id: random_access
    type:
      - 'null'
      - boolean
    doc: Use random access via index to get reads from BAM/CRAM instead of 
      chromosome-wise sweep. Random access is quite slow, so use it only if a 
      small subset of the file needs to be accessed.
    inputBinding:
      position: 101
      prefix: -random_access
  - id: reference_genome
    type:
      - 'null'
      - File
    doc: Reference genome for CRAM support (mandatory if CRAM is used).
    inputBinding:
      position: 101
      prefix: -ref
  - id: settings
    type:
      - 'null'
      - File
    doc: Settings override file (no other settings files are used).
    inputBinding:
      position: 101
      prefix: --settings
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads used.
    inputBinding:
      position: 101
      prefix: -threads
outputs:
  - id: output_bed
    type:
      - 'null'
      - File
    doc: Output BED file. If unset, writes to STDOUT.
    outputBinding:
      glob: $(inputs.output_bed)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
