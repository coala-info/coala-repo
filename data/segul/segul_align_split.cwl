cwlVersion: v1.2
class: CommandLineTool
baseCommand: [segul, align, split]
label: segul_align_split
doc: "Split alignment by partitions\n\nTool homepage: https://github.com/hhandika/segul"
inputs:
  - id: input
    type: File
    doc: "Input alignment to split"
    inputBinding:
      position: 1
      prefix: "--input"
  - id: input_format
    type: ['null', string]
    doc: "Input format: auto, fasta, nexus, phylip (default auto)"
    inputBinding:
      position: 1
      prefix: "--input-format"
  - id: datatype
    type: ['null', string]
    doc: "Sequence datatype: dna, aa, ignore (default dna)"
    inputBinding:
      position: 1
      prefix: "--datatype"
  - id: output_format
    type: ['null', string]
    doc: "Output format: fasta, nexus, phylip, fasta-int, nexus-int, phylip-int (default nexus)"
    inputBinding:
      position: 1
      prefix: "--output-format"
  - id: log
    type: string
    default: "segul.log"
    doc: "Log file path"
    inputBinding:
      position: 1
      prefix: "--log"
  - id: output
    type: string
    default: "Align-Split"
    doc: "Output path"
    inputBinding:
      position: 1
      prefix: "--output"
  - id: input_partition
    type: ['null', File]
    doc: "Input partition file (the help describes it as the partition format, but it takes the partition file path)"
    inputBinding:
      position: 1
      prefix: "--input-partition"
  - id: skip_checking
    type: ['null', boolean]
    doc: "Skip checking partition format"
    inputBinding:
      position: 1
      prefix: "--skip-checking"
  - id: force
    type: ['null', boolean]
    doc: "Force overwriting existing output files/directory"
    inputBinding:
      position: 1
      prefix: "--force"
  - id: prefix
    type: ['null', string]
    doc: "Specify prefix for output files"
    inputBinding:
      position: 1
      prefix: "--prefix"
  - id: partition_format
    type: ['null', string]
    doc: "Specify partition format: nexus, raxml"
    inputBinding:
      position: 1
      prefix: "--partition-format"
outputs:
  - id: output_path
    type: [File, Directory]
    doc: Output file or directory
    outputBinding:
      glob: $(inputs.output)
  - id: log_file
    type: ['null', File]
    doc: Log file
    outputBinding:
      glob: $(inputs.log)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/segul:0.23.2--hc1c3326_0
stdout: segul_align_split.out
