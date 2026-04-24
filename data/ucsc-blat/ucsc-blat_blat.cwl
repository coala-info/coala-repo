cwlVersion: v1.2
class: CommandLineTool
baseCommand: blat
label: ucsc-blat_blat
doc: "Standalone BLAT v. 39x1 fast sequence search command line tool\n\nTool homepage:
  http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: database
    type:
      type: array
      items: File
    doc: Database file(s) (.fa, .nib, or .2bit)
    inputBinding:
      position: 1
  - id: query
    type:
      type: array
      items: File
    doc: Query file(s) (.fa, .nib, or .2bit)
    inputBinding:
      position: 2
  - id: database_type
    type:
      - 'null'
      - string
    doc: 'Database type: dna, prot, dnax'
    inputBinding:
      position: 103
      prefix: -t
  - id: dots
    type:
      - 'null'
      - int
    doc: Output dot every N sequences to show program's progress.
    inputBinding:
      position: 103
      prefix: -dots
  - id: extend_through_n
    type:
      - 'null'
      - boolean
    doc: Allows extension of alignment through large blocks of Ns.
    inputBinding:
      position: 103
      prefix: -extendThroughN
  - id: fast_map
    type:
      - 'null'
      - boolean
    doc: Run for fast DNA/DNA remapping - not allowing introns, requiring high 
      %ID. Query sizes must not exceed 5000.
    inputBinding:
      position: 103
      prefix: -fastMap
  - id: fine
    type:
      - 'null'
      - boolean
    doc: For high-quality mRNAs, look harder for small initial and terminal 
      exons. Not recommended for ESTs.
    inputBinding:
      position: 103
      prefix: -fine
  - id: make_ooc
    type:
      - 'null'
      - File
    doc: Make overused tile file. Target needs to be complete genome.
    inputBinding:
      position: 103
      prefix: -makeOoc
  - id: mask
    type:
      - 'null'
      - string
    doc: 'Mask out repeats. Types are: lower, upper, out, file.out'
    inputBinding:
      position: 103
      prefix: -mask
  - id: max_gap
    type:
      - 'null'
      - int
    doc: Sets the size of maximum gap between tiles in a clump. Default is 2. 
      Only relevant for minMatch > 1.
    inputBinding:
      position: 103
      prefix: -maxGap
  - id: max_intron
    type:
      - 'null'
      - int
    doc: Sets maximum intron size.
    inputBinding:
      position: 103
      prefix: -maxIntron
  - id: min_identity
    type:
      - 'null'
      - float
    doc: Sets minimum sequence identity (in percent). Default is 90 for 
      nucleotide searches, 25 for protein or translated protein searches.
    inputBinding:
      position: 103
      prefix: -minIdentity
  - id: min_match
    type:
      - 'null'
      - int
    doc: Sets the number of tile matches. Default is 2 for nucleotide, 1 for 
      protein.
    inputBinding:
      position: 103
      prefix: -minMatch
  - id: min_rep_divergence
    type:
      - 'null'
      - float
    doc: Minimum percent divergence of repeats to allow them to be unmasked. 
      Default is 15.
    inputBinding:
      position: 103
      prefix: -minRepDivergence
  - id: min_score
    type:
      - 'null'
      - int
    doc: Sets minimum score.
    inputBinding:
      position: 103
      prefix: -minScore
  - id: no_head
    type:
      - 'null'
      - boolean
    doc: Suppresses .psl header (so it's just a tab-separated file).
    inputBinding:
      position: 103
      prefix: -noHead
  - id: no_simp_rep_mask
    type:
      - 'null'
      - boolean
    doc: Suppresses simple repeat masking.
    inputBinding:
      position: 103
      prefix: -noSimpRepMask
  - id: no_trim_a
    type:
      - 'null'
      - boolean
    doc: Don't trim trailing poly-A.
    inputBinding:
      position: 103
      prefix: -noTrimA
  - id: one_off
    type:
      - 'null'
      - int
    doc: Allows one mismatch in tile and still triggers an alignment. Default is
      0.
    inputBinding:
      position: 103
      prefix: -oneOff
  - id: ooc_file
    type:
      - 'null'
      - File
    doc: Load over-occurring k-mers from an external file
    inputBinding:
      position: 103
      prefix: -ooc
  - id: ooc_tile_file
    type:
      - 'null'
      - File
    doc: Use overused tile file N.ooc
    inputBinding:
      position: 103
      prefix: -ooc
  - id: output_format
    type:
      - 'null'
      - string
    doc: 'Controls output file format. Type is one of: psl, pslx, axt, maf, sim4,
      wublast, blast, blast8, blast9'
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
    doc: Mask out repeats in query sequence. Similar to -mask above, but for 
      query rather than target sequence.
    inputBinding:
      position: 103
      prefix: -qMask
  - id: query_type
    type:
      - 'null'
      - string
    doc: 'Query type: dna, rna, prot, dnax, rnax'
    inputBinding:
      position: 103
      prefix: -q
  - id: rep_match
    type:
      - 'null'
      - int
    doc: Sets the number of repetitions of a tile allowed before it is marked as
      overused. Default is 1024.
    inputBinding:
      position: 103
      prefix: -repMatch
  - id: repeats
    type:
      - 'null'
      - string
    doc: Type is same as mask types above. Repeat bases will not be masked in 
      any way, but matches in repeat areas will be reported separately.
    inputBinding:
      position: 103
      prefix: -repeats
  - id: step_size
    type:
      - 'null'
      - int
    doc: Spacing between tiles. Default is tileSize.
    inputBinding:
      position: 103
      prefix: -stepSize
  - id: tile_size
    type:
      - 'null'
      - int
    doc: Sets the size of match that triggers an alignment. Default is 11 for 
      DNA and 5 for protein.
    inputBinding:
      position: 103
      prefix: -tileSize
  - id: trim_hard_a
    type:
      - 'null'
      - boolean
    doc: Remove poly-A tail from qSize as well as alignments in psl output.
    inputBinding:
      position: 103
      prefix: -trimHardA
  - id: trim_t
    type:
      - 'null'
      - boolean
    doc: Trim leading poly-T.
    inputBinding:
      position: 103
      prefix: -trimT
outputs:
  - id: output_psl
    type: File
    doc: Name of the output PSL file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-blat:482--hdc0a859_0
