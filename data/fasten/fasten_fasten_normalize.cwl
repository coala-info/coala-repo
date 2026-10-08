cwlVersion: v1.2
class: CommandLineTool
baseCommand: fasten_normalize
label: fasten_fasten_normalize
doc: "Normalizes reads based on kmer coverage.\n\nTool homepage: https://github.com/lskatz/fasten"
inputs:
  - id: reads
    type: File
    doc: Output of fasten_kmer run with --remember-reads (kmer, count, then the reads that begin with the kmer), read from standard input
  - id: target_depth
    type:
      - 'null'
      - int
    doc: The target depth of kmer.
    inputBinding:
      position: 101
      prefix: --target-depth
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
stdout: fasten_fasten_normalize.out
