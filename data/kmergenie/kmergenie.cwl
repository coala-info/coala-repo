cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmergenie
label: kmergenie
doc: "KmerGenie 1.7051\n\nTool homepage: http://kmergenie.bx.psu.edu"
inputs:
  - id: read_file
    type: File
    doc: Input read file
    inputBinding:
      position: 1
  - id: debug
    type:
      - 'null'
      - boolean
    doc: developer output of R scripts
    inputBinding:
      position: 102
      prefix: --debug
  - id: diploid
    type:
      - 'null'
      - boolean
    doc: 'use the diploid model (default: haploid model)'
    inputBinding:
      position: 102
      prefix: --diploid
  - id: kmer_interval
    type:
      - 'null'
      - int
    doc: interval between consecutive kmer sizes
    inputBinding:
      position: 102
      prefix: -s
  - id: kmer_sampling_value
    type:
      - 'null'
      - string
    doc: 'k-mer sampling value (default: auto-detected to use ~200 MB memory/thread)'
    inputBinding:
      position: 102
      prefix: -e
  - id: largest_kmer_size
    type:
      - 'null'
      - int
    doc: largest k-mer size to consider
    inputBinding:
      position: 102
      prefix: -k
  - id: one_pass
    type:
      - 'null'
      - boolean
    doc: 'skip the second pass to estimate k at 2 bp resolution (default: two passes)'
    inputBinding:
      position: 102
      prefix: --one-pass
  - id: orig_hist
    type:
      - 'null'
      - boolean
    doc: legacy histogram estimation method (slower, less accurate)
    inputBinding:
      position: 102
      prefix: --orig-hist
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: prefix of the output files
    inputBinding:
      position: 102
      prefix: -o
  - id: smallest_kmer_size
    type:
      - 'null'
      - int
    doc: smallest k-mer size to consider
    inputBinding:
      position: 102
      prefix: -l
  - id: threads
    type:
      - 'null'
      - int
    doc: 'number of threads (default: number of cores minus one)'
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmergenie:1.7051--py27r40h077b44d_11
stdout: kmergenie.out
