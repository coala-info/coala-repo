cwlVersion: v1.2
class: CommandLineTool
baseCommand: dbg2olc_SelectLongestReads
label: dbg2olc_SelectLongestReads
doc: "Selects the longest reads from a FASTA/FASTQ file based on total length.\n\n\
  Tool homepage: https://github.com/yechengxi/DBG2OLC"
inputs:
  - id: ProgramFile
    type: string
    doc: Program file name
    inputBinding:
      position: 1
  - id: sum
    type: string
    doc: Sum parameter
    inputBinding:
      position: 2
  - id: total_length
    type: string
    doc: Total length parameter
    inputBinding:
      position: 3
  - id: longest
    type: string
    doc: Longest parameter
    inputBinding:
      position: 4
  - id: initial_total_bases
    type: int
    doc: Initial total bases
    default: 0
    inputBinding:
      position: 5
  - id: input_file1
    type: File
    doc: First input FASTA/FASTQ file
    inputBinding:
      position: 6
  - id: input_file2
    type: File
    doc: Second input FASTA/FASTQ file
    inputBinding:
      position: 7
outputs:
  - id: outfile
    type: File
    doc: Output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dbg2olc:20200723--h077b44d_4
