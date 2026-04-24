cwlVersion: v1.2
class: CommandLineTool
baseCommand: blat
label: blat
doc: "Standalone BLAT v. 36 fast sequence search command line tool\n\nTool homepage:
  https://genome.ucsc.edu/FAQ/FAQblat.html"
inputs:
  - id: database
    type: File
    doc: Database file (.fa, .nib, or .2bit) or a list of these files
    inputBinding:
      position: 1
  - id: query
    type: File
    doc: Query file (.fa, .nib, or .2bit) or a list of these files
    inputBinding:
      position: 2
  - id: database_type
    type:
      - 'null'
      - string
    doc: 'Database type: dna, prot, or dnax'
    inputBinding:
      position: 103
      prefix: -t
  - id: dots
    type:
      - 'null'
      - int
    doc: Output dot every N sequences to show program's progress
    inputBinding:
      position: 103
      prefix: -dots
  - id: extend_through_n
    type:
      - 'null'
      - boolean
    doc: Allows extension of alignment through large blocks of Ns
    inputBinding:
      position: 103
      prefix: -extendThroughN
  - id: fast_map
    type:
      - 'null'
      - boolean
    doc: Run for fast DNA/DNA remapping - not allowing introns, requiring high %ID
    inputBinding:
      position: 103
      prefix: -fastMap
  - id: fine
    type:
      - 'null'
      - boolean
    doc: For high-quality mRNAs, look harder for small initial and terminal exons
    inputBinding:
      position: 103
      prefix: -fine
  - id: mask
    type:
      - 'null'
      - string
    doc: 'Mask out repeats. Types: lower, upper, out, file.out'
    inputBinding:
      position: 103
      prefix: -mask
  - id: max_gap
    type:
      - 'null'
      - int
    doc: Sets the size of maximum gap between tiles in a clump
    inputBinding:
      position: 103
      prefix: -maxGap
  - id: max_intron
    type:
      - 'null'
      - int
    doc: Sets maximum intron size
    inputBinding:
      position: 103
      prefix: -maxIntron
  - id: min_identity
    type:
      - 'null'
      - int
    doc: Sets minimum sequence identity (in percent). Default is 90 for nucleotide,
      25 for protein
    inputBinding:
      position: 103
      prefix: -minIdentity
  - id: min_match
    type:
      - 'null'
      - int
    doc: Sets the number of tile matches. Default is 2 for nucleotide, 1 for protein
    inputBinding:
      position: 103
      prefix: -minMatch
  - id: min_rep_divergence
    type:
      - 'null'
      - int
    doc: Minimum percent divergence of repeats to allow them to be unmasked
    inputBinding:
      position: 103
      prefix: -minRepDivergence
  - id: min_score
    type:
      - 'null'
      - int
    doc: Sets minimum score
    inputBinding:
      position: 103
      prefix: -minScore
  - id: no_head
    type:
      - 'null'
      - boolean
    doc: Suppresses .psl header
    inputBinding:
      position: 103
      prefix: -noHead
  - id: no_trim_a
    type:
      - 'null'
      - boolean
    doc: Don't trim trailing poly-A
    inputBinding:
      position: 103
      prefix: -noTrimA
  - id: one_off
    type:
      - 'null'
      - int
    doc: If set to 1, this allows one mismatch in tile and still triggers an alignment
    inputBinding:
      position: 103
      prefix: -oneOff
  - id: ooc
    type:
      - 'null'
      - File
    doc: Use overused tile file N.ooc. N should correspond to the tileSize
    inputBinding:
      position: 103
      prefix: -ooc
  - id: out_format
    type:
      - 'null'
      - string
    doc: Controls output file format (psl, pslx, axt, maf, sim4, wublast, blast, blast8,
      blast9)
    inputBinding:
      position: 103
      prefix: -out
  - id: prot
    type:
      - 'null'
      - boolean
    doc: Synonymous with -t=prot -q=prot
    inputBinding:
      position: 103
      prefix: -prot
  - id: q_mask
    type:
      - 'null'
      - string
    doc: Mask out repeats in query sequence
    inputBinding:
      position: 103
      prefix: -qMask
  - id: query_type
    type:
      - 'null'
      - string
    doc: 'Query type: dna, rna, prot, dnax, or rnax'
    inputBinding:
      position: 103
      prefix: -q
  - id: rep_match
    type:
      - 'null'
      - int
    doc: Sets the number of repetitions of a tile allowed before it is marked as overused
    inputBinding:
      position: 103
      prefix: -repMatch
  - id: repeats
    type:
      - 'null'
      - string
    doc: Type is same as mask types. Repeat bases will not be masked but reported
      separately
    inputBinding:
      position: 103
      prefix: -repeats
  - id: step_size
    type:
      - 'null'
      - int
    doc: Spacing between tiles. Default is tileSize
    inputBinding:
      position: 103
      prefix: -stepSize
  - id: tile_size
    type:
      - 'null'
      - int
    doc: Sets the size of match that triggers an alignment. Default is 11 for DNA
      and 5 for protein
    inputBinding:
      position: 103
      prefix: -tileSize
  - id: trim_hard_a
    type:
      - 'null'
      - boolean
    doc: Remove poly-A tail from qSize as well as alignments in psl output
    inputBinding:
      position: 103
      prefix: -trimHardA
  - id: trim_t
    type:
      - 'null'
      - boolean
    doc: Trim leading poly-T
    inputBinding:
      position: 103
      prefix: -trimT
outputs:
  - id: output
    type: File
    doc: Name of the output file
    outputBinding:
      glob: '*.out'
  - id: make_ooc
    type:
      - 'null'
      - File
    doc: Make overused tile file. Target needs to be complete genome
    outputBinding:
      glob: $(inputs.make_ooc)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blat:36--0
