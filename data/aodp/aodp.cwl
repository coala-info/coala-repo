cwlVersion: v1.2
class: CommandLineTool
baseCommand: aodp
label: aodp
doc: "Automated Oligonucleotide Design Pipeline generates oligonucleotide signatures
  for sequences in FASTA format and for all groups in a phylogeny in the Newick tree
  format.\n\nTool homepage: https://github.com/peterk87/aodp"
inputs:
  - id: output
    type: string
    doc: Output specification (though the help text suggests output is handled via
      specific flags, the synopsis lists it as a positional argument).
    inputBinding:
      position: 1
  - id: fasta_sequence_files
    type:
      type: array
      items: File
    doc: Multiple input sequence files in the FASTA format.
    inputBinding:
      position: 2
  - id: ambiguous_oligos
    type:
      - 'null'
      - string
    doc: Whether oligos containing ambiguous bases will be sought (yes/no)
    inputBinding:
      position: 103
      prefix: --ambiguous-oligos
  - id: ambiguous_sources
    type:
      - 'null'
      - string
    doc: Whether sequences containing ambiguities are considered (yes/no)
    inputBinding:
      position: 103
      prefix: --ambiguous-sources
  - id: basename
    type:
      - 'null'
      - string
    doc: Base name for all output files; incompatible with individual output flags.
    inputBinding:
      position: 103
      prefix: --basename
  - id: clusters
    type:
      - 'null'
      - string
    doc: Generates a file of cluster nodes and a file of cluster oligonucleotide signatures
      using the provided name.
    inputBinding:
      position: 103
      prefix: --clusters
  - id: crowded
    type:
      - 'null'
      - string
    doc: Indicates whether an oligo range is populated with intermediary sites (yes/no)
    inputBinding:
      position: 103
      prefix: --crowded
  - id: database
    type:
      - 'null'
      - File
    doc: Validate the resulting oligos against a reference database in the FASTA format.
    inputBinding:
      position: 103
      prefix: --database
  - id: first_site_gap
    type:
      - 'null'
      - int
    doc: Size of the gap between the border of the range and the first interior site
    inputBinding:
      position: 103
      prefix: --first-site-gap
  - id: ignore_snp
    type:
      - 'null'
      - boolean
    doc: Single polymorphism sites (SNP) will be ignored
    inputBinding:
      position: 103
      prefix: --ignore-SNP
  - id: inter_site_gap
    type:
      - 'null'
      - int
    doc: Size of the gap between sites inside an oligo range
    inputBinding:
      position: 103
      prefix: --inter-site-gap
  - id: isolation_file
    type:
      - 'null'
      - File
    doc: A list of taxa or sequences to isolate
    inputBinding:
      position: 103
      prefix: --isolation-file
  - id: match
    type:
      - 'null'
      - File
    doc: Finds the closest matching source sequence for each sequence from the target-FASTA-file.
    inputBinding:
      position: 103
      prefix: --match
  - id: max_ambiguities
    type:
      - 'null'
      - int
    doc: Maximum number of ambiguous bases allowed in a sequence
    inputBinding:
      position: 103
      prefix: --max-ambiguities
  - id: max_crowded_ambiguities
    type:
      - 'null'
      - int
    doc: Maximum number of ambiguous bases within an oligo size window
    inputBinding:
      position: 103
      prefix: --max-crowded-ambiguities
  - id: max_homolo
    type:
      - 'null'
      - int
    doc: Maximum length of a homopolymer in any oligo
    inputBinding:
      position: 103
      prefix: --max-homolo
  - id: max_melting
    type:
      - 'null'
      - float
    doc: Maximum melting temperature (Celsius) for any discovered oligo
    inputBinding:
      position: 103
      prefix: --max-melting
  - id: oligo_size
    type:
      - 'null'
      - string
    doc: Look for oligonucleotide signatures of sizes within the specified range (e.g.,
      32 or 24-32)
    inputBinding:
      position: 103
      prefix: --oligo-size
  - id: outgroup_file
    type:
      - 'null'
      - File
    doc: List of species to be excluded from the final output
    inputBinding:
      position: 103
      prefix: --outgroup-file
  - id: reverse_complement
    type:
      - 'null'
      - boolean
    doc: Will take into account the reverse complement of all sequences
    inputBinding:
      position: 103
      prefix: --reverse-complement
  - id: salt
    type:
      - 'null'
      - string
    doc: Na+ concentration (e.g., 0.1M)
    inputBinding:
      position: 103
      prefix: --salt
  - id: strand
    type:
      - 'null'
      - float
    doc: Single strand concentration in mM
    inputBinding:
      position: 103
      prefix: --strand
  - id: taxonomy
    type:
      - 'null'
      - File
    doc: Taxonomy information associated with the sequences in the reference database.
    inputBinding:
      position: 103
      prefix: --taxonomy
  - id: threads
    type:
      - 'null'
      - int
    doc: The maximum number of threads for multiprocessor systems
    inputBinding:
      position: 103
      prefix: --threads
  - id: tree_file
    type:
      - 'null'
      - File
    doc: Use the phylogeny file in the Newick tree format
    inputBinding:
      position: 103
      prefix: --tree-file
outputs:
  - id: strings
    type:
      - 'null'
      - File
    doc: Writes all oligo strings grouped by sequence or group
    outputBinding:
      glob: $(inputs.strings)
  - id: positions
    type:
      - 'null'
      - File
    doc: Output for Array Designer (tab-separated list of oligo sites)
    outputBinding:
      glob: $(inputs.positions)
  - id: ranges
    type:
      - 'null'
      - File
    doc: All ranges of sites of oligos grouped by sequence or group
    outputBinding:
      glob: $(inputs.ranges)
  - id: fasta_out
    type:
      - 'null'
      - File
    doc: All oligos in FASTA format
    outputBinding:
      glob: $(inputs.fasta_out)
  - id: gff
    type:
      - 'null'
      - File
    doc: All oligos in GFF format
    outputBinding:
      glob: $(inputs.gff)
  - id: newick_out
    type:
      - 'null'
      - File
    doc: Writes a phylogeny (Newick tree format) with generated labels for internal
      nodes.
    outputBinding:
      glob: $(inputs.newick_out)
  - id: node_list
    type:
      - 'null'
      - File
    doc: List of sequences for every internal node in the phylogeny
    outputBinding:
      glob: $(inputs.node_list)
  - id: lineage
    type:
      - 'null'
      - File
    doc: Lineage of every sequence in the phylogeny
    outputBinding:
      glob: $(inputs.lineage)
  - id: fold
    type:
      - 'null'
      - File
    doc: Predicted secondary structure and calculated two-state melting temperature
      for discarded candidates
    outputBinding:
      glob: $(inputs.fold)
  - id: cladogram
    type:
      - 'null'
      - File
    doc: Printout in the eps format of a cladogram associated with the annotated phylogeny
      tree.
    outputBinding:
      glob: $(inputs.cladogram)
  - id: time
    type:
      - 'null'
      - File
    doc: Tab-separated time and memory usage for various phases of processing
    outputBinding:
      glob: $(inputs.time)
  - id: cluster_list
    type:
      - 'null'
      - File
    doc: Generates the list of clusters
    outputBinding:
      glob: $(inputs.cluster_list)
  - id: cluster_oligos
    type:
      - 'null'
      - File
    doc: Generates the list of all oligonucleotide signatures for all clusters identified
    outputBinding:
      glob: $(inputs.cluster_oligos)
  - id: match_output
    type:
      - 'null'
      - File
    doc: Redirect the output from --match to the output file
    outputBinding:
      glob: $(inputs.match_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aodp:2.5.0.2--pl5321h9f5acd7_1
