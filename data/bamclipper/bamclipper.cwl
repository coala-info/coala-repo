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
    default: 0
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
    doc: Input BAM file to be clipped
    inputBinding:
      position: 101
      prefix: -b
  - id: primer_bed
    type: File
    doc: BED file containing primer locations
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
    default: 1
    inputBinding:
      position: 101
      prefix: -n
  - id: upstream_clipping
    type:
      - 'null'
      - int
    doc: Number of additional bases to clip upstream
    default: 0
    inputBinding:
      position: 101
      prefix: -u
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamclipper:1.0.0--pl526_0
stdout: bamclipper.out
