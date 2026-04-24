cwlVersion: v1.2
class: CommandLineTool
baseCommand: BedCoverage
label: ngs-bits_BedCoverage
doc: "Annotates a BED file with the average coverage of the regions from one or several
  BAM/CRAM file(s).\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: bam_files
    type:
      type: array
      items: File
    doc: Input BAM/CRAM file(s).
    inputBinding:
      position: 101
      prefix: -bam
  - id: clear_annotation
    type:
      - 'null'
      - boolean
    doc: Clear previous annotation columns before annotating (starting from 4th 
      column).
    inputBinding:
      position: 101
      prefix: -clear
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable debug output.
    inputBinding:
      position: 101
      prefix: -debug
  - id: decimals
    type:
      - 'null'
      - int
    doc: Number of decimals used in output.
    inputBinding:
      position: 101
      prefix: -decimals
  - id: input_bed_file
    type:
      - 'null'
      - File
    doc: Input BED file. If unset, reads from STDIN.
    inputBinding:
      position: 101
      prefix: -in
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Minimum mapping quality.
    inputBinding:
      position: 101
      prefix: -min_mapq
  - id: random_access
    type:
      - 'null'
      - boolean
    doc: Use random access via index to get reads from BAM/CRAM instead of 
      chromosome-wise sweep. Random access is quite slow, especially on CRAM, so
      use it only if a small subset of the file needs to be accessed.
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
  - id: settings_file
    type:
      - 'null'
      - File
    doc: Settings override file (no other settings files are used).
    inputBinding:
      position: 101
      prefix: --settings
  - id: skip_mismapped
    type:
      - 'null'
      - boolean
    doc: Skip reads with mapping quality less than 20 that are not properly 
      paired (they are often mis-mapped).
    inputBinding:
      position: 101
      prefix: -skip_mismapped
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads used.
    inputBinding:
      position: 101
      prefix: -threads
  - id: tool_definition_xml
    type:
      - 'null'
      - boolean
    doc: Writes a Tool Definition Xml file. The file name is the application 
      name with the suffix '.tdx'.
    inputBinding:
      position: 101
      prefix: --tdx
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
