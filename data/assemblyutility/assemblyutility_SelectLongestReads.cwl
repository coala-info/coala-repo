cwlVersion: v1.2
class: CommandLineTool
baseCommand: assemblyutility_SelectLongestReads
label: assemblyutility_SelectLongestReads
doc: "A tool to select the longest reads from FASTA/FASTQ files until a specified
  total length is reached.\n\nTool homepage: https://github.com/yechengxi/AssemblyUtility"
inputs:
  - id: sum_mode
    type: string
    doc: Mode identifier (typically 'sum')
    inputBinding:
      position: 1
  - id: total_length
    type: int
    doc: The target total length of bases to select
    inputBinding:
      position: 2
  - id: selection_type
    type: string
    doc: Selection strategy (typically 'longest')
    inputBinding:
      position: 3
  - id: min_length
    type: int
    doc: Minimum length threshold for reads
    inputBinding:
      position: 4
  - id: input_files
    type:
      type: array
      items: File
    doc: Input FASTA or FASTQ files
    inputBinding:
      position: 105
      prefix: f
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: The output file path
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/assemblyutility:20160209--h077b44d_9
