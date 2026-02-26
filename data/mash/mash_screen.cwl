cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mash
  - screen
label: mash_screen
doc: "Determine how well query sequences are contained within a mixture of sequences.
  The queries must be formatted as a single Mash sketch file (.msh), created with
  the `mash sketch` command. The <mixture> files can be contigs or reads, in fasta
  or fastq, gzipped or not, and \"-\" can be given for <mixture> to read from standard
  input. The <mixture> sequences are assumed to be nucleotides, and will be 6-frame
  translated if the <queries> are amino acids. The output fields are [identity, shared-hashes,
  median-multiplicity, p-value, query-ID, query-comment], where median-multiplicity
  is computed for shared hashes, based on the number of observations of those hashes
  within the mixture.\n\nTool homepage: https://github.com/marbl/Mash"
inputs:
  - id: queries
    type: File
    doc: Query Mash sketch file (.msh)
    inputBinding:
      position: 1
  - id: mixture
    type:
      type: array
      items: File
    doc: Mixture files (contigs or reads, fasta or fastq, gzipped or not, or '-'
      for stdin)
    inputBinding:
      position: 2
  - id: max_pvalue
    type:
      - 'null'
      - float
    doc: Maximum p-value to report.
    default: 1.0
    inputBinding:
      position: 103
      prefix: -v
  - id: min_identity
    type:
      - 'null'
      - float
    doc: Minimum identity to report. Inclusive unless set to zero, in which case
      only identities greater than zero (i.e. with at least one shared hash) 
      will be reported. Set to -1 to output everything.
    default: 0
    inputBinding:
      position: 103
      prefix: -i
  - id: threads
    type:
      - 'null'
      - int
    doc: Parallelism. This many threads will be spawned for processing.
    default: 1
    inputBinding:
      position: 103
      prefix: -p
  - id: winner_takes_all
    type:
      - 'null'
      - boolean
    doc: Winner-takes-all strategy for identity estimates. After counting hashes
      for each query, hashes that appear in multiple queries will be removed 
      from all except the one with the best identity (ties broken by larger 
      query), and other identities will be reduced. This removes output 
      redundancy, providing a rough compositional outline.
    inputBinding:
      position: 103
      prefix: -w
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mash:2.3--hb105d93_10
stdout: mash_screen.out
