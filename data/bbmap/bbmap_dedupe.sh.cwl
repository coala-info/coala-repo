cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dedupe.sh
label: bbmap_dedupe
doc: "Accepts one or more files containing sets of sequences (reads or scaffolds).
  Removes duplicate sequences, which may be specified to be exact matches, subsequences,
  or sequences within some percent identity. Can also find overlapping sequences and
  group them into clusters.\n\nTool homepage: https://sourceforge.net/projects/bbmap"
inputs:
  - id: absorbcontainment
    type:
      - 'null'
      - boolean
    doc: Absorb full containments of contigs.
    default: true
    inputBinding:
      position: 101
      prefix: absorbcontainment
  - id: absorbmatch
    type:
      - 'null'
      - boolean
    doc: Absorb exact matches of contigs.
    default: true
    inputBinding:
      position: 101
      prefix: absorbmatch
  - id: absorbrc
    type:
      - 'null'
      - boolean
    doc: Absorb reverse-complements as well as normal orientation.
    default: true
    inputBinding:
      position: 101
      prefix: absorbrc
  - id: amino
    type:
      - 'null'
      - boolean
    doc: Dedupe supports amino acid space via the 'amino' flag.
    inputBinding:
      position: 101
      prefix: amino
  - id: ascending
    type:
      - 'null'
      - boolean
    doc: Sort in ascending order.
    default: false
    inputBinding:
      position: 101
      prefix: ascending
  - id: cc
    type:
      - 'null'
      - boolean
    doc: Flip contigs so clusters have a single orientation.
    default: true
    inputBinding:
      position: 101
      prefix: cc
  - id: cluster
    type:
      - 'null'
      - boolean
    doc: Group overlapping contigs into clusters.
    default: false
    inputBinding:
      position: 101
      prefix: cluster
  - id: depthratio
    type:
      - 'null'
      - float
    doc: When non-zero, overlaps will only be formed between reads with a depth ratio
      of at most this.
    default: 0
    inputBinding:
      position: 101
      prefix: depthratio
  - id: exact
    type:
      - 'null'
      - boolean
    doc: Only allow exact symbol matches. When false, an 'N' will match any symbol.
    default: true
    inputBinding:
      position: 101
      prefix: exact
  - id: fcc
    type:
      - 'null'
      - boolean
    doc: Truncate graph at nodes with canonization disputes.
    default: false
    inputBinding:
      position: 101
      prefix: fcc
  - id: findoverlap
    type:
      - 'null'
      - boolean
    doc: Find overlaps between contigs (containments and non-containments). Necessary
      for clustering.
    default: false
    inputBinding:
      position: 101
      prefix: findoverlap
  - id: fixmultijoins
    type:
      - 'null'
      - boolean
    doc: Remove redundant overlaps between the same two contigs.
    default: true
    inputBinding:
      position: 101
      prefix: fixmultijoins
  - id: foc
    type:
      - 'null'
      - boolean
    doc: Truncate graph at nodes with offset disputes.
    default: false
    inputBinding:
      position: 101
      prefix: foc
  - id: forcetrimleft
    type:
      - 'null'
      - int
    doc: If positive, trim bases to the left of this position (exclusive, 0-based).
    default: -1
    inputBinding:
      position: 101
      prefix: forcetrimleft
  - id: forcetrimright
    type:
      - 'null'
      - int
    doc: If positive, trim bases to the right of this position (exclusive, 0-based).
    default: -1
    inputBinding:
      position: 101
      prefix: forcetrimright
  - id: hashns
    type:
      - 'null'
      - boolean
    doc: Set to true to search for matches using kmers containing Ns.
    default: false
    inputBinding:
      position: 101
      prefix: hashns
  - id: in
    type:
      type: array
      items: File
    doc: A single file or a comma-delimited list of files.
    inputBinding:
      position: 101
      prefix: in
  - id: interleaved
    type:
      - 'null'
      - string
    doc: If true, forces fastq input to be paired and interleaved.
    default: auto
    inputBinding:
      position: 101
      prefix: interleaved
  - id: k
    type:
      - 'null'
      - int
    doc: Seed length used for finding containments and overlaps.
    default: 31
    inputBinding:
      position: 101
      prefix: k
  - id: maxedits
    type:
      - 'null'
      - int
    doc: Allow up to this many edits (subs or indels).
    default: 0
    inputBinding:
      position: 101
      prefix: maxedits
  - id: maxsubs
    type:
      - 'null'
      - int
    doc: Allow up to this many mismatches (substitutions only, no indels).
    default: 0
    inputBinding:
      position: 101
      prefix: maxsubs
  - id: mergedelimiter
    type:
      - 'null'
      - string
    doc: Delimiter between merged headers.
    default: '>'
    inputBinding:
      position: 101
      prefix: mergedelimiter
  - id: mergenames
    type:
      - 'null'
      - boolean
    doc: When a sequence absorbs another, concatenate their headers.
    default: false
    inputBinding:
      position: 101
      prefix: mergenames
  - id: minclustersize
    type:
      - 'null'
      - int
    doc: Do not output clusters smaller than this.
    default: 1
    inputBinding:
      position: 101
      prefix: minclustersize
  - id: minidentity
    type:
      - 'null'
      - float
    doc: Absorb contained sequences with percent identity of at least this.
    default: 100
    inputBinding:
      position: 101
      prefix: minidentity
  - id: minlengthpercent
    type:
      - 'null'
      - float
    doc: Smaller contig must be at least this percent of larger contig's length to
      be absorbed.
    default: 0
    inputBinding:
      position: 101
      prefix: minlengthpercent
  - id: minoverlap
    type:
      - 'null'
      - int
    doc: Overlap must be at least this long to cluster and merge.
    default: 200
    inputBinding:
      position: 101
      prefix: minoverlap
  - id: minoverlappercent
    type:
      - 'null'
      - float
    doc: Overlap must be at least this percent of smaller contig's length to cluster
      and merge.
    default: 0
    inputBinding:
      position: 101
      prefix: minoverlappercent
  - id: minscaf
    type:
      - 'null'
      - int
    doc: Ignore contigs/scaffolds shorter than this.
    default: 0
    inputBinding:
      position: 101
      prefix: minscaf
  - id: mst
    type:
      - 'null'
      - boolean
    doc: Remove cyclic edges, leaving only the longest edges that form a tree.
    default: false
    inputBinding:
      position: 101
      prefix: mst
  - id: numaffixmaps
    type:
      - 'null'
      - int
    doc: Number of prefixes/suffixes to index per contig.
    default: 1
    inputBinding:
      position: 101
      prefix: numaffixmaps
  - id: numbergraphnodes
    type:
      - 'null'
      - boolean
    doc: Label dot graph nodes with read numbers rather than read names.
    default: true
    inputBinding:
      position: 101
      prefix: numbergraphnodes
  - id: ordered
    type:
      - 'null'
      - boolean
    doc: Output sequences in input order.
    default: false
    inputBinding:
      position: 101
      prefix: ordered
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Set to false to force the program to abort rather than overwrite an existing
      file.
    default: true
    inputBinding:
      position: 101
      prefix: overwrite
  - id: pbr
    type:
      - 'null'
      - boolean
    doc: Only output the single highest-quality read per cluster.
    default: false
    inputBinding:
      position: 101
      prefix: pbr
  - id: printlengthinedges
    type:
      - 'null'
      - boolean
    doc: Print the length of contigs in edges.
    default: false
    inputBinding:
      position: 101
      prefix: printlengthinedges
  - id: processclusters
    type:
      - 'null'
      - boolean
    doc: Run the cluster processing phase.
    default: false
    inputBinding:
      position: 101
      prefix: processclusters
  - id: pto
    type:
      - 'null'
      - boolean
    doc: Do not look for new edges between nodes in the same cluster.
    default: false
    inputBinding:
      position: 101
      prefix: pto
  - id: qtrim
    type:
      - 'null'
      - string
    doc: Set to qtrim=rl to trim leading and trailing Ns.
    default: f
    inputBinding:
      position: 101
      prefix: qtrim
  - id: removecycles
    type:
      - 'null'
      - boolean
    doc: Remove all cycles so clusters form trees.
    default: true
    inputBinding:
      position: 101
      prefix: removecycles
  - id: renameclusters
    type:
      - 'null'
      - boolean
    doc: Rename contigs to indicate which cluster they are in.
    default: false
    inputBinding:
      position: 101
      prefix: renameclusters
  - id: rmn
    type:
      - 'null'
      - boolean
    doc: If true, both names and sequence must match.
    default: false
    inputBinding:
      position: 101
      prefix: rmn
  - id: showspeed
    type:
      - 'null'
      - boolean
    doc: Set to 'f' to suppress display of processing speed.
    default: true
    inputBinding:
      position: 101
      prefix: showspeed
  - id: sort
    type:
      - 'null'
      - string
    doc: Sort output (length, quality, name, id).
    default: 'false'
    inputBinding:
      position: 101
      prefix: sort
  - id: storename
    type:
      - 'null'
      - boolean
    doc: Store scaffold names (set false to save memory).
    default: true
    inputBinding:
      position: 101
      prefix: storename
  - id: storequality
    type:
      - 'null'
      - boolean
    doc: Store quality values for fastq assemblies (set false to save memory).
    default: true
    inputBinding:
      position: 101
      prefix: storequality
  - id: subset
    type:
      - 'null'
      - int
    doc: Only process reads whose ((ID%subsetcount)==subset).
    default: 0
    inputBinding:
      position: 101
      prefix: subset
  - id: subsetcount
    type:
      - 'null'
      - int
    doc: Number of subsets used to process the data; higher uses less memory.
    default: 1
    inputBinding:
      position: 101
      prefix: subsetcount
  - id: threads
    type:
      - 'null'
      - int
    doc: Set number of threads to use; default is number of logical processors.
    inputBinding:
      position: 101
      prefix: threads
  - id: touppercase
    type:
      - 'null'
      - boolean
    doc: Convert input bases to upper-case.
    default: true
    inputBinding:
      position: 101
      prefix: touppercase
  - id: trimq
    type:
      - 'null'
      - int
    doc: Quality trim level.
    default: 6
    inputBinding:
      position: 101
      prefix: trimq
  - id: uniquenames
    type:
      - 'null'
      - boolean
    doc: Ensure all output scaffolds have unique names.
    default: true
    inputBinding:
      position: 101
      prefix: uniquenames
  - id: uniqueonly
    type:
      - 'null'
      - boolean
    doc: If true, all copies of duplicate reads will be discarded, rather than keeping
      1.
    default: false
    inputBinding:
      position: 101
      prefix: uniqueonly
  - id: usejni
    type:
      - 'null'
      - boolean
    doc: Do alignments in C code, which is faster, if an edit distance is allowed.
    default: false
    inputBinding:
      position: 101
      prefix: usejni
  - id: ziplevel
    type:
      - 'null'
      - int
    doc: Set to 1 (lowest) through 9 (max) to change compression level.
    default: 2
    inputBinding:
      position: 101
      prefix: ziplevel
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Destination for all output contigs.
    outputBinding:
      glob: $(inputs.out)
  - id: pattern
    type:
      - 'null'
      - File
    doc: Clusters will be written to individual files, where the '%' symbol in the
      pattern is replaced by cluster number.
    outputBinding:
      glob: $(inputs.pattern)
  - id: outd
    type:
      - 'null'
      - File
    doc: Optional; removed duplicates will go here.
    outputBinding:
      glob: $(inputs.outd)
  - id: csf
    type:
      - 'null'
      - File
    doc: (clusterstatsfile) Write a list of cluster names and sizes.
    outputBinding:
      glob: $(inputs.csf)
  - id: dot
    type:
      - 'null'
      - File
    doc: (graph) Write a graph in dot format. Requires 'fo' and 'pc' flags.
    outputBinding:
      glob: $(inputs.dot)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bbmap:39.52--he5f24ec_0
