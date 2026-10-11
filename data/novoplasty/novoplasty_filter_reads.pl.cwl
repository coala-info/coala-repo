cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - filter_reads.pl
label: novoplasty_filter_reads.pl
doc: "Filter paired-end reads (fastq) that share k-mers with a reference sequence,
  for use with NOVOPlasty.\n\nTool homepage: https://github.com/ndierckx/NOVOPlasty"
inputs:
  - id: reads_forward
    type: File
    doc: Forward reads (fastq, optionally gzip or bzip2 compressed).
    inputBinding:
      position: 1
      prefix: '-1'
  - id: reads_reverse
    type: File
    doc: Reverse reads (fastq, optionally gzip or bzip2 compressed).
    inputBinding:
      position: 2
      prefix: '-2'
  - id: reference
    type: File
    doc: Reference sequence in fasta format.
    inputBinding:
      position: 3
      prefix: -ref
  - id: project_name
    type: string
    doc: Project name, used in the output file names.
    inputBinding:
      position: 4
      prefix: -out
outputs:
  - id: filtered_reads
    type: File[]
    doc: Filtered forward and reverse reads
    outputBinding:
      glob: Filtered_reads_$(inputs.project_name)_R*.fastq
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/novoplasty:4.3.5--pl5321hdfd78af_0
stdout: novoplasty_filter_reads.pl.out
