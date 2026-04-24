cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sga
  - filter
label: sga_filter
doc: "Remove reads from a data set.\nThe currently available filters are removing
  exact-match duplicates\nand removing reads with low-frequency k-mers.\nAutomatically
  rebuilds the FM-index without the discarded reads.\n\nTool homepage: https://github.com/jts/sga"
inputs:
  - id: readsfile
    type: File
    doc: Input reads file
    inputBinding:
      position: 1
  - id: homopolymer_check
    type:
      - 'null'
      - boolean
    doc: check reads for hompolymer run length sequencing errors
    inputBinding:
      position: 102
      prefix: --homopolymer-check
  - id: kmer_both_strand
    type:
      - 'null'
      - boolean
    doc: mimimum kmer coverage is required for both strand
    inputBinding:
      position: 102
      prefix: --kmer-both-strand
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: 'The length of the kmer to use. (default: 27)'
    inputBinding:
      position: 102
      prefix: --kmer-size
  - id: kmer_threshold
    type:
      - 'null'
      - int
    doc: 'Require at least N kmer coverage for each kmer in a read. (default: 3)'
    inputBinding:
      position: 102
      prefix: --kmer-threshold
  - id: low_complexity_check
    type:
      - 'null'
      - boolean
    doc: filter out low complexity reads
    inputBinding:
      position: 102
      prefix: --low-complexity-check
  - id: no_duplicate_check
    type:
      - 'null'
      - boolean
    doc: turn off duplicate removal
    inputBinding:
      position: 102
      prefix: --no-duplicate-check
  - id: no_kmer_check
    type:
      - 'null'
      - boolean
    doc: turn off the kmer check
    inputBinding:
      position: 102
      prefix: --no-kmer-check
  - id: prefix
    type:
      - 'null'
      - string
    doc: 'use PREFIX for the names of the index files (default: prefix of the input
      file)'
    inputBinding:
      position: 102
      prefix: --prefix
  - id: sample_rate
    type:
      - 'null'
      - int
    doc: "use occurrence array sample rate of N in the FM-index. Higher values use
      significantly\nless memory at the cost of higher runtime. This value must be
      a power of 2 (default: 128)"
    inputBinding:
      position: 102
      prefix: --sample-rate
  - id: substring_only
    type:
      - 'null'
      - boolean
    doc: when removing duplicates, only remove substring sequences, not 
      full-length matches
    inputBinding:
      position: 102
      prefix: --substring-only
  - id: threads
    type:
      - 'null'
      - int
    doc: 'use NUM threads to compute the overlaps (default: 1)'
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: display verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: 'write the qc-passed reads to FILE (default: READSFILE.filter.pass.fa)'
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sga:v0.10.15-4-deb_cv1
