cwlVersion: v1.2
class: CommandLineTool
baseCommand: fermi2_match
label: fermi2_match
doc: "Finds SMEMs (Maximal Exact Matches) in a sequence file against an index.\n\n\
  Tool homepage: https://github.com/lh3/fermi2"
inputs:
  - id: index_fmd
    type: File
    doc: Path to the FMD index file.
    inputBinding:
      position: 1
  - id: seq_fa
    type: File
    doc: Path to the input FASTA sequence file.
    inputBinding:
      position: 2
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Batch size.
    inputBinding:
      position: 103
      prefix: -b
  - id: discovery_novel_alleles
    type:
      - 'null'
      - boolean
    doc: Discovery novel alleles (forces -p).
    inputBinding:
      position: 103
      prefix: -d
  - id: find_smems
    type:
      - 'null'
      - boolean
    doc: Find SMEMs (requires both strands in one index).
    inputBinding:
      position: 103
      prefix: -p
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: k-mer length in the discovery mode (forces -d).
    inputBinding:
      position: 103
      prefix: -k
  - id: max_hits_for_coordinate
    type:
      - 'null'
      - int
    doc: Show coordinate if the number of hits is no more than INT.
    inputBinding:
      position: 103
      prefix: -m
  - id: min_occurrences
    type:
      - 'null'
      - int
    doc: Minimum occurrences.
    inputBinding:
      position: 103
      prefix: -s
  - id: sampled_suffix_array
    type:
      - 'null'
      - File
    doc: Sampled suffix array.
    inputBinding:
      position: 103
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads.
    inputBinding:
      position: 103
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermi2:r193--h577a1d6_10
stdout: fermi2_match.out
