cwlVersion: v1.2
class: CommandLineTool
baseCommand: fasten_sort
label: fasten_fasten_sort
doc: "Sort reads. This can be useful for many things including checksums and reducing gzip file sizes. Remember to use --paired-end if applicable.\n\nTool homepage: https://github.com/lskatz/fasten"
inputs:
  - id: reads
    type: File
    doc: Reads in FASTQ format, read from standard input
  - id: sort_by
    type:
      - 'null'
      - string
    doc: 'Sort by either SEQ, MINIMIZER, GC, or ID. If GC, then the entries are sorted by GC percentage. SEQ and ID are alphabetically sorted.'
    inputBinding:
      position: 101
      prefix: --sort-by
  - id: kmer_length
    type:
      - 'null'
      - string
    doc: Length of kmer if using minimizers
    inputBinding:
      position: 101
      prefix: --kmer-length
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: Reverse sort
    inputBinding:
      position: 101
      prefix: --reverse
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: 'If > 0, then chunks of reads or pairs will be sorted instead of the whole set. This is useful for streaming large files. Default: 0'
    inputBinding:
      position: 101
      prefix: --chunk-size
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
stdout: fasten_fasten_sort.out
