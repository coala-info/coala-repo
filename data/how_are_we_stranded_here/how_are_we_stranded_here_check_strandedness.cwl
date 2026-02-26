cwlVersion: v1.2
class: CommandLineTool
baseCommand: check_strandedness
label: how_are_we_stranded_here_check_strandedness
doc: "Check if fastq files are stranded\n\nTool homepage: https://github.com/betsig/how_are_we_stranded_here"
inputs:
  - id: gtf
    type: File
    doc: Genome annotation GTF file
    inputBinding:
      position: 101
      prefix: --gtf
  - id: kallisto_index
    type:
      - 'null'
      - File
    doc: name of kallisto index (will build under this name if file not found)
    inputBinding:
      position: 101
      prefix: --kallisto_index
  - id: nreads
    type:
      - 'null'
      - int
    doc: number of reads to sample
    inputBinding:
      position: 101
      prefix: --nreads
  - id: print_commands
    type:
      - 'null'
      - boolean
    doc: Print bash commands as they occur?
    inputBinding:
      position: 101
      prefix: --print_commands
  - id: reads_1
    type: File
    doc: fastq.gz file (R1)
    inputBinding:
      position: 101
      prefix: --reads_1
  - id: reads_2
    type: File
    doc: fastq.gz file (R2)
    inputBinding:
      position: 101
      prefix: --reads_2
  - id: transcripts
    type:
      - 'null'
      - File
    doc: .fasta file with transcript sequences
    inputBinding:
      position: 101
      prefix: --transcripts
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/how_are_we_stranded_here:1.0.1--pyhfa5458b_0
stdout: how_are_we_stranded_here_check_strandedness.out
