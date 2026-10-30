cwlVersion: v1.2
class: CommandLineTool
baseCommand: VcfAnnotateFromBigWig
label: ngs-bits_VcfAnnotateFromBigWig
doc: "Annotates the INFO column of a VCF with data from a bigWig file. The annotation is decided according the following rules: Insertions are not annotated. SNPs are annotated according to the corresponding value in the bigWig file. If the file has no corresponding value no annotation is written. MNPs, complex INDELs and Deletions the annotated value is choosen according to the given mode: max - maximum; min - minimum; avg - average; of the values in the affected reference region. none - regions that affect multiple reference bases are not annotated.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: block_size
    type:
      - 'null'
      - int
    doc: "Number of lines processed in one chunk."
    inputBinding:
      position: 1
      prefix: -block_size
  - id: bw
    type: File
    doc: "BigWig file containen the data to be used in the annotation."
    inputBinding:
      position: 2
      prefix: -bw
  - id: debug
    type:
      - 'null'
      - int
    doc: "Enables debug output at the given interval in milliseconds (disabled by default, cannot be combined with writing to STDOUT)."
    inputBinding:
      position: 3
      prefix: -debug
  - id: input_file
    type: File
    doc: "Input VCF file. If unset, reads from STDIN."
    inputBinding:
      position: 4
      prefix: -in
  - id: mode
    type: string
    doc: "Annotate mode: How the annotation is chosen when multiple bases are affected. Valid: 'max,min,avg,none'"
    inputBinding:
      position: 5
      prefix: -mode
  - id: name
    type: string
    doc: "Name of the new INFO column."
    inputBinding:
      position: 6
      prefix: -name
  - id: output_path
    type:
      - 'null'
      - string
    doc: "Output VCF or VCF or VCF.GZ file. If unset, writes to STDOUT."
    inputBinding:
      position: 7
      prefix: -out
  - id: prefetch
    type:
      - 'null'
      - int
    doc: "Maximum number of blocks that may be pre-fetched into memory."
    inputBinding:
      position: 8
      prefix: -prefetch
  - id: settings_file
    type:
      - 'null'
      - File
    doc: "Settings override file (no other settings files are used)."
    inputBinding:
      position: 9
      prefix: --settings
  - id: threads
    type:
      - 'null'
      - int
    doc: "The number of threads used to read, process and write files."
    inputBinding:
      position: 10
      prefix: -threads
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Output VCF or VCF or VCF.GZ file. If unset, writes to STDOUT."
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
