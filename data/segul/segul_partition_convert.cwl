cwlVersion: v1.2
class: CommandLineTool
baseCommand: [segul, partition, convert]
label: segul_partition_convert
doc: "Convert partition formats\n\nTool homepage: https://github.com/hhandika/segul"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input)
        writable: true
inputs:
  - id: input
    type: File
    doc: "Input path (alignment or partition file)"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
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
  - id: output
    type: string
    default: "Partition-Convert"
    doc: "Output path"
    inputBinding:
      position: 1
      prefix: "--output"
  - id: input_partition
    type: ['null', string]
    doc: "Input partition format: charset, nexus, raxml"
    inputBinding:
      position: 1
      prefix: "--input-partition"
  - id: codon
    type: ['null', boolean]
    doc: "Set codon model partition format"
    inputBinding:
      position: 1
      prefix: "--codon"
  - id: log
    type: string
    default: "segul.log"
    doc: "Log file path"
    inputBinding:
      position: 1
      prefix: "--log"
  - id: output_partition
    type: ['null', string]
    doc: "Output partition format: charset, nexus, raxml (default nexus)"
    inputBinding:
      position: 1
      prefix: "--output-partition"
  - id: force
    type: ['null', boolean]
    doc: "Force overwriting existing output files/directory"
    inputBinding:
      position: 1
      prefix: "--force"
  - id: skip_checking
    type: ['null', boolean]
    doc: "Skip checking partition formats"
    inputBinding:
      position: 1
      prefix: "--skip-checking"
outputs:
  - id: output_path
    type:
      type: array
      items: File
    doc: Converted partition file; segul ignores --output and writes <input name>_partition.<ext> beside the input
    outputBinding:
      glob: '*_partition.*'
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
stdout: segul_partition_convert.out
