cwlVersion: v1.2
class: CommandLineTool
baseCommand: SelectLongestReads
label: dbg2olc_SelectLongestReads
doc: "Select reads from FASTA/FASTQ files up to a total number of bases (the longest
  reads first when longest is 1), and write them to one FASTA file.\n\nTool homepage:
  https://github.com/yechengxi/DBG2OLC"
inputs:
  - id: total_length
    type: long
    doc: Total number of bases to select
    inputBinding:
      position: 101
      prefix: sum
  - id: longest
    type:
      - 'null'
      - int
    doc: 1 to select the longest reads first, 0 to keep the input order
    inputBinding:
      position: 101
      prefix: longest
  - id: outfile
    type: string
    doc: Output file
    inputBinding:
      position: 101
      prefix: o
  - id: input_files
    type:
      type: array
      items: File
      inputBinding:
        prefix: f
    doc: Input FASTA/FASTQ files
    inputBinding:
      position: 102
outputs:
  - id: selected_reads
    type: File
    doc: Selected reads
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dbg2olc:20200723--h077b44d_4
