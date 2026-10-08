cwlVersion: v1.2
class: CommandLineTool
baseCommand: fasten_mutate
label: fasten_fasten_mutate
doc: "Introduces point mutations randomly. There is no evolutionary model; multiple hits are allowed. Therefore, the number of SNPs through --snps is an upper limit.\n\nTool homepage: https://github.com/lskatz/fasten"
inputs:
  - id: reads
    type: File
    doc: Reads in FASTQ format, read from standard input
  - id: snps
    type:
      - 'null'
      - int
    doc: Maximum number of SNPs (point mutations) to include per read.
    inputBinding:
      position: 101
      prefix: --snps
  - id: mark
    type:
      - 'null'
      - boolean
    doc: lowercase all reads but uppercase the SNPs (not yet implemented)
    inputBinding:
      position: 101
      prefix: --mark
  - id: numcpus
    type:
      - 'null'
      - int
    doc: 'Number of CPUs (default: 1)'
    inputBinding:
      position: 101
      prefix: --numcpus
  - id: paired_end
    type:
      - 'null'
      - boolean
    doc: The input reads are interleaved paired-end
    inputBinding:
      position: 101
      prefix: --paired-end
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print more status messages
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fasten:0.9.0--hc1c3326_0
stdin: $(inputs.reads.path)
stdout: fasten_fasten_mutate.out
