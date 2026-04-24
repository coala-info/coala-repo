cwlVersion: v1.2
class: CommandLineTool
baseCommand: VcfAnnotateFromBed
label: ngs-bits_VcfAnnotateFromBed
doc: "Annotates the INFO column of a VCF with data from a BED file.\n\nTool homepage:
  https://github.com/imgag/ngs-bits"
inputs:
  - id: annotation_name
    type: string
    doc: Annotation name in INFO column of output VCF file.
    inputBinding:
      position: 101
      prefix: -name
  - id: bed_file
    type: File
    doc: BED file used as source of annotations (name column).
    inputBinding:
      position: 101
      prefix: -bed
  - id: block_size
    type:
      - 'null'
      - int
    doc: Number of lines processed in one chunk.
    inputBinding:
      position: 101
      prefix: -block_size
  - id: debug
    type:
      - 'null'
      - int
    doc: Enables debug output at the given interval in milliseconds (disabled by
      default, cannot be combined with writing to STDOUT).
    inputBinding:
      position: 101
      prefix: -debug
  - id: input_vcf
    type:
      - 'null'
      - File
    doc: Input VCF file. If unset, reads from STDIN.
    inputBinding:
      position: 101
      prefix: -in
  - id: prefetch
    type:
      - 'null'
      - int
    doc: Maximum number of chunks that may be pre-fetched into memory.
    inputBinding:
      position: 101
      prefix: -prefetch
  - id: separator
    type:
      - 'null'
      - string
    doc: Separator used if there are several matches for one variant.
    inputBinding:
      position: 101
      prefix: -sep
  - id: settings_file
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
    doc: The number of threads used to read, process and write files.
    inputBinding:
      position: 101
      prefix: -threads
outputs:
  - id: output_vcf
    type:
      - 'null'
      - File
    doc: Output VCF list. If unset, writes to STDOUT.
    outputBinding:
      glob: $(inputs.output_vcf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
