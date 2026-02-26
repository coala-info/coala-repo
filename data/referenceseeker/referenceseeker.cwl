cwlVersion: v1.2
class: CommandLineTool
baseCommand: referenceseeker
label: referenceseeker
doc: "Rapid determination of appropriate reference genomes.\n\nTool homepage: https://github.com/oschwengers/referenceseeker"
inputs:
  - id: database
    type: string
    doc: ReferenceSeeker database path
    inputBinding:
      position: 1
  - id: genome
    type: File
    doc: target draft genome in fasta format
    inputBinding:
      position: 2
  - id: ani
    type:
      - 'null'
      - float
    doc: ANI threshold
    default: 0.95
    inputBinding:
      position: 103
      prefix: --ani
  - id: bidirectional
    type:
      - 'null'
      - boolean
    doc: Compute bidirectional ANI/conserved DNA values
    default: false
    inputBinding:
      position: 103
      prefix: --bidirectional
  - id: conserved_dna
    type:
      - 'null'
      - float
    doc: Conserved DNA threshold
    default: 0.69
    inputBinding:
      position: 103
      prefix: --conserved-dna
  - id: crg
    type:
      - 'null'
      - int
    doc: "Max number of candidate reference genomes to pass kmer\n               \
      \         prefilter"
    default: 100
    inputBinding:
      position: 103
      prefix: --crg
  - id: sliding_window
    type:
      - 'null'
      - int
    doc: "Sliding window - the lower the more accurate but also\n                \
      \        slower"
    default: 400
    inputBinding:
      position: 103
      prefix: --sliding-window
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of used threads (default = number of available\n                \
      \        CPU cores)"
    inputBinding:
      position: 103
      prefix: --threads
  - id: unfiltered
    type:
      - 'null'
      - boolean
    doc: "Set kmer prefilter to extremely conservative values\n                  \
      \      and skip species level ANI cutoffs (ANI >= 0.95 and\n               \
      \         conserved DNA >= 0.69"
    inputBinding:
      position: 103
      prefix: --unfiltered
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print verbose information
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/referenceseeker:1.8.0--pyhdfd78af_0
stdout: referenceseeker.out
