cwlVersion: v1.2
class: CommandLineTool
baseCommand: BedHighCoverage
label: ngs-bits_BedHighCoverage
doc: "Detects high-coverage regions from a BAM/CRAM file.\nNote that only read start/end
  are used. Thus, deletions in the CIGAR string are treated as covered.\n\nTool homepage:
  https://github.com/imgag/ngs-bits"
inputs:
  - id: bam_file
    type: File
    doc: Input BAM/CRAM file.
    inputBinding:
      position: 101
      prefix: -bam
  - id: changelog
    type:
      - 'null'
      - boolean
    doc: Prints changeloge and exits.
    inputBinding:
      position: 101
      prefix: --changelog
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
    default: 'false'
    inputBinding:
      position: 101
      prefix: -debug
  - id: input_bed_file
    type:
      - 'null'
      - File
    doc: Input BED file containing the regions of interest. If unset, reads from
      STDIN.
    default: ''
    inputBinding:
      position: 101
      prefix: -in
  - id: min_baseq
    type:
      - 'null'
      - int
    doc: Minimum base quality to consider a base.
    default: '0'
    inputBinding:
      position: 101
      prefix: -min_baseq
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Minimum mapping quality to consider a read.
    default: '1'
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
    default: 'false'
    inputBinding:
      position: 101
      prefix: -random_access
  - id: reference_genome
    type:
      - 'null'
      - File
    doc: Reference genome for CRAM support (mandatory if CRAM is used).
    default: ''
    inputBinding:
      position: 101
      prefix: -ref
  - id: settings_override_file
    type:
      - 'null'
      - File
    doc: Settings override file (no other settings files are used).
    inputBinding:
      position: 101
      prefix: --settings
  - id: tdx
    type:
      - 'null'
      - boolean
    doc: Writes a Tool Definition Xml file. The file name is the application 
      name with the suffix '.tdx'.
    inputBinding:
      position: 101
      prefix: --tdx
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads used.
    default: '1'
    inputBinding:
      position: 101
      prefix: -threads
outputs:
  - id: output_bed_file
    type:
      - 'null'
      - File
    doc: Output BED file. If unset, writes to STDOUT.
    outputBinding:
      glob: $(inputs.output_bed_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
