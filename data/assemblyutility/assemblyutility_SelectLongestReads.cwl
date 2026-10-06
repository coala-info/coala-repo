cwlVersion: v1.2
class: CommandLineTool
baseCommand: SelectLongestReads
label: assemblyutility_SelectLongestReads
doc: "Select reads from FASTA/FASTQ files until a total number of bases is reached, either the
  first reads (longest 0) or the longest reads (longest 1). Writes FASTA.\n\nTool homepage:
  https://github.com/yechengxi/AssemblyUtility"
inputs:
  - id: total_length
    type: long
    doc: The target total number of bases to select
    inputBinding:
      position: 1
      prefix: sum
  - id: longest
    type:
      - 'null'
      - int
    doc: '0: select the first reads that sum to total_length bases; 1: select the longest
      reads that sum to total_length bases (default 0)'
    inputBinding:
      position: 2
      prefix: longest
  - id: output_file_path
    type: string
    doc: Output FASTA file name
    inputBinding:
      position: 3
      prefix: o
  - id: input_files
    type:
      type: array
      items: File
      inputBinding:
        prefix: f
    doc: Input FASTA or FASTQ files
    inputBinding:
      position: 4
outputs:
  - id: output_file
    type: File
    doc: Selected reads in FASTA format
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: log_file
    type: File
    doc: Selection log
    outputBinding:
      glob: LongReadSelection_log.txt
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/assemblyutility:20160209--h077b44d_9
stdout: assemblyutility_SelectLongestReads.out
