cwlVersion: v1.2
class: CommandLineTool
baseCommand: arcs-make
label: arcs_arcs-make
doc: "A pipeline to run ARCS/ARKS with or without Tigmint for scaffolding genomic
  drafts using linked or long reads.\n\nTool homepage: https://github.com/bcgsc/arcs"
inputs:
  - id: command
    type: string
    doc: 'The command to run: arcs, arcs-tigmint, arcs-long, arks, arks-tigmint, arks-long,
      or clean'
    inputBinding:
      position: 1
  - id: as_ratio
    type:
      - 'null'
      - float
    doc: Minimum AS/read length ratio for Tigmint
    inputBinding:
      position: 102
      prefix: as
  - id: barcode_multiplicity
    type:
      - 'null'
      - string
    doc: Barcode multiplicity range
    inputBinding:
      position: 102
      prefix: m
  - id: cut_length
    type:
      - 'null'
      - int
    doc: Cut length for long reads (for arcs-long and arks-long only)
    inputBinding:
      position: 102
      prefix: cut
  - id: dist
    type:
      - 'null'
      - int
    doc: Max dist between reads to be considered the same molecule for Tigmint
    inputBinding:
      position: 102
      prefix: dist
  - id: dist_upper
    type:
      - 'null'
      - boolean
    doc: Use upper bound distance over median distance
    inputBinding:
      position: 102
      prefix: dist_upper
  - id: draft
    type:
      - 'null'
      - File
    doc: Draft name. File must have .fasta or .fa extension
    inputBinding:
      position: 102
      prefix: draft
  - id: enable_distance_estimation
    type:
      - 'null'
      - boolean
    doc: Enable distance estimation
    inputBinding:
      position: 102
      prefix: D
  - id: gap_size
    type:
      - 'null'
      - int
    doc: Fixed gap size for dist.gv file
    inputBinding:
      position: 102
      prefix: gap
  - id: jaccard_closest
    type:
      - 'null'
      - int
    doc: Estimate distance using N closest Jaccard scores
    inputBinding:
      position: 102
      prefix: B
  - id: kmer_fraction
    type:
      - 'null'
      - float
    doc: Minimum fraction of read kmers matching a contigId (ARKS specific)
    inputBinding:
      position: 102
      prefix: j
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: Size of a k-mer (ARKS specific)
    inputBinding:
      position: 102
      prefix: k
  - id: mapq
    type:
      - 'null'
      - int
    doc: Mapping quality threshold for Tigmint
    inputBinding:
      position: 102
      prefix: mapq
  - id: masking_length
    type:
      - 'null'
      - int
    doc: Contig head/tail length for masking alignments
    inputBinding:
      position: 102
      prefix: e
  - id: max_link_ratio
    type:
      - 'null'
      - float
    doc: Maximum link ratio between two best contig pairs (LINKS specific)
    inputBinding:
      position: 102
      prefix: a
  - id: max_node_degree
    type:
      - 'null'
      - int
    doc: Max node degree in scaffold graph
    inputBinding:
      position: 102
      prefix: d
  - id: min_aligned_pairs
    type:
      - 'null'
      - int
    doc: Minimum aligned read pairs per barcode mapping
    inputBinding:
      position: 102
      prefix: c
  - id: min_contig_length
    type:
      - 'null'
      - int
    doc: Minimum contig length
    inputBinding:
      position: 102
      prefix: z
  - id: min_links
    type:
      - 'null'
      - int
    doc: Minimum number of links to compute scaffold (LINKS specific)
    inputBinding:
      position: 102
      prefix: l
  - id: min_sequence_identity
    type:
      - 'null'
      - int
    doc: Minimum sequence identity (ARCS specific)
    inputBinding:
      position: 102
      prefix: s
  - id: minsize
    type:
      - 'null'
      - int
    doc: Minimum molecule size for Tigmint
    inputBinding:
      position: 102
      prefix: minsize
  - id: nm
    type:
      - 'null'
      - int
    doc: Maximum number of mismatches for Tigmint
    inputBinding:
      position: 102
      prefix: nm
  - id: p_value
    type:
      - 'null'
      - float
    doc: p-value for head/tail assignment and link orientation
    inputBinding:
      position: 102
      prefix: r
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for soft-link to final output scaffolds
    inputBinding:
      position: 102
      prefix: prefix
  - id: reads
    type:
      - 'null'
      - File
    doc: Read name. File must have .fastq.gz or .fq.gz extension (or .fastq, .fq for
      long modes)
    inputBinding:
      position: 102
      prefix: reads
  - id: span
    type:
      - 'null'
      - int
    doc: Min number of spanning molecules to be considered assembled for Tigmint
    inputBinding:
      position: 102
      prefix: span
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads used for BWA or ARKS
    inputBinding:
      position: 102
      prefix: t
  - id: time
    type:
      - 'null'
      - int
    doc: Logs time and memory usage to file for main steps (Set to 1 to enable logging)
    inputBinding:
      position: 102
      prefix: time
  - id: trim
    type:
      - 'null'
      - int
    doc: bp of contigs to trim after cutting at error for Tigmint
    inputBinding:
      position: 102
      prefix: trim
  - id: window
    type:
      - 'null'
      - int
    doc: Window size for checking spanning molecules for Tigmint
    inputBinding:
      position: 102
      prefix: window
outputs:
  - id: barcode_counts_file
    type:
      - 'null'
      - File
    doc: Name of output barcode multiplicity TSV file
    outputBinding:
      glob: $(inputs.barcode_counts_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/arcs:1.2.8--hdcf5f25_0
