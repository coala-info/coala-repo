cwlVersion: v1.2
class: CommandLineTool
baseCommand: interleave-fastqgz-MITOBIM.py
label: mitobim_interleave-fastqgz-MITOBIM.py
doc: "Takes two FASTQ or FASTQ.gz files (read 1 and read 2) and interleaves them
  to standard output, with /1 and /2 read name endings as used by MITObim.\n\nTool
  homepage: https://github.com/chrishah/MITObim"
inputs:
  - id: fastq_1
    type: File
    doc: FASTQ (or FASTQ.gz) file with read 1
    inputBinding:
      position: 1
  - id: fastq_2
    type: File
    doc: FASTQ (or FASTQ.gz) file with read 2
    inputBinding:
      position: 2
outputs:
  - id: interleaved
    type: stdout
    doc: Interleaved reads in FASTQ format
stdout: mitobim_interleaved.fastq
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mitobim:1.9.1--hdfd78af_1
