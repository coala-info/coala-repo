cwlVersion: v1.2
class: CommandLineTool
baseCommand: prophex query
label: prophex_query
doc: "Query a prophex index\n\nTool homepage: https://github.com/prophyle/prophex"
inputs:
  - id: idxbase
    type: string
    doc: Base name of the prophex index files
    inputBinding:
      position: 1
  - id: input_fq
    type: File
    doc: Input FASTQ file
    inputBinding:
      position: 2
  - id: check_contig_border
    type:
      - 'null'
      - boolean
    doc: do not check whether k-mer is on border of two contigs, and show such 
      k-mers in output
    inputBinding:
      position: 103
      prefix: -p
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: length of k-mer
    inputBinding:
      position: 103
      prefix: -k
  - id: log_file
    type:
      - 'null'
      - File
    doc: log file name to output statistics
    inputBinding:
      position: 103
      prefix: -l
  - id: output_chromosomes
    type:
      - 'null'
      - boolean
    doc: output set of chromosomes for every k-mer
    inputBinding:
      position: 103
      prefix: -v
  - id: print_sequences_and_qualities
    type:
      - 'null'
      - boolean
    doc: print sequences and base qualities
    inputBinding:
      position: 103
      prefix: -b
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    default: 1
    inputBinding:
      position: 103
      prefix: -t
  - id: use_k_lcp
    type:
      - 'null'
      - boolean
    doc: use k-LCP for querying
    inputBinding:
      position: 103
      prefix: -u
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prophex:0.1.1--h5bf99c6_2
stdout: prophex_query.out
