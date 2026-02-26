cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sqt
  - cutvect
label: sqt_cutvect
doc: "Remove vector sequence\n\nTool homepage: https://github.com/tdjsnelling/sqtracker"
inputs:
  - id: vector
    type: File
    doc: FASTA with vector sequence(s)
    inputBinding:
      position: 1
  - id: reads
    type: File
    doc: FASTA/FASTQ with read
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sqt:v0.8.0-3-deb-py3_cv1
stdout: sqt_cutvect.out
