cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamclipper.sh
label: bamclipper
doc: "A tool to soft-clip gene-specific primers from BAM files using a primer BED
  file.\n\nTool homepage: https://github.com/tommyau/bamclipper"
inputs:
  - id: downstream_clipping
    type:
      - 'null'
      - int
    doc: Number of additional bases to clip downstream
    inputBinding:
      position: 101
      prefix: -d
  - id: gnu_parallel_path
    type:
      - 'null'
      - string
    doc: Path to the GNU parallel executable
    inputBinding:
      position: 101
      prefix: -g
  - id: input_bam
    type: File
    doc: Input BAM file to be clipped (indexed; the .bai must sit beside it)
    secondaryFiles:
      - .bai
    inputBinding:
      position: 101
      prefix: -b
  - id: primer_bed
    type: File
    doc: BEDPE file containing primer pair locations
    inputBinding:
      position: 101
      prefix: -p
  - id: samtools_path
    type:
      - 'null'
      - string
    doc: Path to the samtools executable
    inputBinding:
      position: 101
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads for parallel processing
    inputBinding:
      position: 101
      prefix: -n
  - id: upstream_clipping
    type:
      - 'null'
      - int
    doc: Number of additional bases to clip upstream
    inputBinding:
      position: 101
      prefix: -u
outputs:
  - id: clipped_bam
    type: File
    doc: Primer-clipped, coordinate-sorted BAM (<input>.primerclipped.bam) with
      its index
    secondaryFiles:
      - .bai
    outputBinding:
      glob: $(inputs.input_bam.basename.replace(/\.bam$/, '')).primerclipped.bam
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamclipper:1.0.0--pl526_0
