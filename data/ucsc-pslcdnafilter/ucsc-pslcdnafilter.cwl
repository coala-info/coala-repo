cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslCDnaFilter
label: ucsc-pslcdnafilter
doc: "Filter cDNA alignments in psl format.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_psl
    type: File
    doc: "Input PSL file of cDNA alignments (sorted by query name for the comparative filters)."
    inputBinding:
      position: 1
  - id: out_psl
    type: string
    doc: "Output PSL file name."
    inputBinding:
      position: 2
  - id: local_near_best
    type:
      - 'null'
      - float
    doc: "Local near best in genome filtering: keep alignments within this fraction of the top score for each aligned portion of the mRNA. 0 keeps only the best for each fragment, -1.0 disables (default)."
    inputBinding:
      position: 0
      prefix: "-localNearBest="
      separate: false
  - id: global_near_best
    type:
      - 'null'
      - float
    doc: "Global near best in genome filtering: keep alignments within this fraction of the top score. 0 keeps only the best alignment, -1.0 disables (default)."
    inputBinding:
      position: 0
      prefix: "-globalNearBest="
      separate: false
  - id: ignore_ns
    type:
      - 'null'
      - boolean
    doc: "Do not include Ns (repeat masked) while calculating the score and coverage; treat them as unaligned."
    inputBinding:
      position: 0
      prefix: "-ignoreNs"
  - id: ignore_introns
    type:
      - 'null'
      - boolean
    doc: "Do not favor apparent introns when scoring."
    inputBinding:
      position: 0
      prefix: "-ignoreIntrons"
  - id: min_id
    type:
      - 'null'
      - float
    doc: "Only keep alignments with at least this fraction identity (default 0.0)."
    inputBinding:
      position: 0
      prefix: "-minId="
      separate: false
  - id: min_cover
    type:
      - 'null'
      - float
    doc: "Minimum fraction of query that must be aligned (default 0.0)."
    inputBinding:
      position: 0
      prefix: "-minCover="
      separate: false
  - id: decay_min_cover
    type:
      - 'null'
      - boolean
    doc: "Calculate the minimum coverage per alignment from the query size: minCoverage = 1.0 - qSize / 250.0, bounded between 0.25 and 0.9."
    inputBinding:
      position: 0
      prefix: "-decayMinCover"
  - id: min_span
    type:
      - 'null'
      - float
    doc: "Keep only alignments whose target length is at least this fraction of the longest alignment passing the other filters (default 0.0)."
    inputBinding:
      position: 0
      prefix: "-minSpan="
      separate: false
  - id: min_q_size
    type:
      - 'null'
      - int
    doc: "Drop queries shorter than this size (default 0)."
    inputBinding:
      position: 0
      prefix: "-minQSize="
      separate: false
  - id: min_aln_size
    type:
      - 'null'
      - int
    doc: "Minimum number of aligned bases, excluding poly-A/poly-T bases if available (default 0)."
    inputBinding:
      position: 0
      prefix: "-minAlnSize="
      separate: false
  - id: min_non_rep_size
    type:
      - 'null'
      - int
    doc: "Minimum number of matching bases that are not repeats (default 0)."
    inputBinding:
      position: 0
      prefix: "-minNonRepSize="
      separate: false
  - id: max_rep_match
    type:
      - 'null'
      - float
    doc: "Maximum fraction of matching bases that are repeats (default 1.0)."
    inputBinding:
      position: 0
      prefix: "-maxRepMatch="
      separate: false
  - id: reps_as_match
    type:
      - 'null'
      - boolean
    doc: "Treat matches in repeats just like other matches."
    inputBinding:
      position: 0
      prefix: "-repsAsMatch"
  - id: max_aligns_drop
    type:
      - 'null'
      - int
    doc: "Maximum number of alignments for a given query; if exceeded, all alignments of the query are dropped (-1 disables, default)."
    inputBinding:
      position: 0
      prefix: "-maxAlignsDrop="
      separate: false
  - id: max_aligns
    type:
      - 'null'
      - int
    doc: "Maximum number of alignments for a given query; if exceeded, the best-scoring ones are kept (-1 disables, default)."
    inputBinding:
      position: 0
      prefix: "-maxAligns="
      separate: false
  - id: poly_a_sizes
    type:
      - 'null'
      - File
    doc: "Tab separated file with poly-A tail and poly-T head sizes, as written by faPolyASizes (id seqSize tailPolyASize headPolyTSize)."
    inputBinding:
      position: 0
      prefix: "-polyASizes="
      separate: false
  - id: use_poly_t_head
    type:
      - 'null'
      - boolean
    doc: "If a poly-T head is longer than the poly-A tail, use it when calculating coverage."
    inputBinding:
      position: 0
      prefix: "-usePolyTHead"
  - id: best_overlap
    type:
      - 'null'
      - boolean
    doc: "Filter overlapping alignments, keeping the best of alignments that are similar (for windowed alignments)."
    inputBinding:
      position: 0
      prefix: "-bestOverlap"
  - id: hap_regions
    type:
      - 'null'
      - File
    doc: "PSL alignments of each haplotype pseudo-chromosome to the corresponding reference chromosome region."
    inputBinding:
      position: 0
      prefix: "-hapRegions="
      separate: false
  - id: dropped
    type:
      - 'null'
      - string
    doc: "Save PSLs that were dropped to this file."
    inputBinding:
      position: 0
      prefix: "-dropped="
      separate: false
  - id: weird_overlapped
    type:
      - 'null'
      - string
    doc: "Output weirdly overlapping PSLs to this file."
    inputBinding:
      position: 0
      prefix: "-weirdOverlapped="
      separate: false
  - id: filter_weird_overlapped
    type:
      - 'null'
      - boolean
    doc: "Filter weirdly overlapped alignments, keeping the single highest scoring one."
    inputBinding:
      position: 0
      prefix: "-filterWeirdOverlapped"
  - id: align_stats
    type:
      - 'null'
      - string
    doc: "Output the per-alignment statistics to this file."
    inputBinding:
      position: 0
      prefix: "-alignStats="
      separate: false
  - id: unique_mapped
    type:
      - 'null'
      - boolean
    doc: "Keep only cDNAs that are uniquely aligned after all other filters have been applied."
    inputBinding:
      position: 0
      prefix: "-uniqueMapped"
  - id: no_validate
    type:
      - 'null'
      - boolean
    doc: "Do not run pslCheck validation."
    inputBinding:
      position: 0
      prefix: "-noValidate"
  - id: stats_out
    type:
      - 'null'
      - string
    doc: "Write filtering stats to this file, overrides -verbose=1."
    inputBinding:
      position: 0
      prefix: "-statsOut="
      separate: false
  - id: verbose
    type:
      - 'null'
      - int
    doc: "Verbosity: 0 quiet, 1 stats (default), 2 problem alignments, 3 dropped alignments, 4 kept psl, 5 all PSLs."
    inputBinding:
      position: 0
      prefix: "-verbose="
      separate: false
  - id: hap_ref_mapped
    type:
      - 'null'
      - string
    doc: "Output PSLs of haplotype to reference chromosome cDNA alignment mappings (debugging)."
    inputBinding:
      position: 0
      prefix: "-hapRefMapped="
      separate: false
  - id: hap_ref_cdna_alns
    type:
      - 'null'
      - string
    doc: "Output PSLs of haplotype cDNA to reference cDNA alignments (debugging)."
    inputBinding:
      position: 0
      prefix: "-hapRefCDnaAlns="
      separate: false
  - id: hap_loci_alns
    type:
      - 'null'
      - string
    doc: "Output grouping of final alignments created by the haplotype mapping process."
    inputBinding:
      position: 0
      prefix: "-hapLociAlns="
      separate: false
  - id: aln_id_qname_mode
    type:
      - 'null'
      - boolean
    doc: "Add internal alignment numbers to cDNA names on output (debugging)."
    inputBinding:
      position: 0
      prefix: "-alnIdQNameMode"
  - id: black_list
    type:
      - 'null'
      - File
    doc: "File of accession ranges (two columns, first and last accession, inclusive) to drop."
    inputBinding:
      position: 0
      prefix: "-blackList="
      separate: false
outputs:
  - id: filtered_psl
    type: File
    doc: "Filtered PSL file."
    outputBinding:
      glob: $(inputs.out_psl)
  - id: dropped_psl
    type:
      - 'null'
      - File
    doc: "PSLs that were dropped."
    outputBinding:
      glob: $(inputs.dropped)
  - id: weird_overlapped_psl
    type:
      - 'null'
      - File
    doc: "Weirdly overlapping PSLs."
    outputBinding:
      glob: $(inputs.weird_overlapped)
  - id: align_stats_file
    type:
      - 'null'
      - File
    doc: "Per-alignment statistics."
    outputBinding:
      glob: $(inputs.align_stats)
  - id: stats_out_file
    type:
      - 'null'
      - File
    doc: "Filtering statistics."
    outputBinding:
      glob: $(inputs.stats_out)
  - id: hap_ref_mapped_psl
    type:
      - 'null'
      - File
    doc: "Haplotype to reference mappings."
    outputBinding:
      glob: $(inputs.hap_ref_mapped)
  - id: hap_ref_cdna_alns_psl
    type:
      - 'null'
      - File
    doc: "Haplotype cDNA to reference cDNA alignments."
    outputBinding:
      glob: $(inputs.hap_ref_cdna_alns)
  - id: hap_loci_alns_file
    type:
      - 'null'
      - File
    doc: "Haplotype loci groupings."
    outputBinding:
      glob: $(inputs.hap_loci_alns)
  - id: stderr
    type: stderr
    doc: "Standard error (verbose statistics)."
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslcdnafilter:482--h0b57e2e_0
stderr: ucsc-pslcdnafilter.err
