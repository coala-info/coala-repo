cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - flair
  - transcriptome
label: flair_transcriptome
doc: "Defines isoforms from genomic alignments and optional short-read junction support.\n
  \nTool homepage: https://github.com/BrooksLabUCSC/flair"
inputs:
  - id: check_splice
    type:
      - 'null'
      - boolean
    doc: enforce coverage of 4 out of 6 bp around each splice site and no insertions
      greater than 3 bp at the splice site
    inputBinding:
      position: 101
      prefix: --check_splice
  - id: end_window
    type:
      - 'null'
      - int
    doc: window size for comparing TSS/TES
    inputBinding:
      position: 101
      prefix: --end_window
  - id: filter
    type:
      - 'null'
      - string
    doc: 'Report options include: nosubset, default, comprehensive, ginormous'
    inputBinding:
      position: 101
      prefix: --filter
  - id: genome
    type:
      - 'null'
      - File
    doc: FastA of reference genome, can be minimap2 indexed
    inputBinding:
      position: 101
      prefix: --genome
  - id: genome_aligned_bam
    type:
      - 'null'
      - File
    doc: Sorted and indexed bam file aligned to the genome
    inputBinding:
      position: 101
      prefix: --genomealignedbam
  - id: gtf
    type:
      - 'null'
      - File
    doc: GTF annotation file, used for renaming FLAIR isoforms to annotated isoforms
      and adjusting TSS/TESs
    inputBinding:
      position: 101
      prefix: --gtf
  - id: junction_bed
    type:
      - 'null'
      - File
    doc: short-read junctions in bed format (can be generated from short-read alignment
      with junctions_from_sam)
    inputBinding:
      position: 101
      prefix: --junction_bed
  - id: junction_support
    type:
      - 'null'
      - int
    doc: if providing short-read junctions, minimum junction support required to keep
      junction. If your junctions file is in bed format, the score field will be used
      for read support.
    inputBinding:
      position: 101
      prefix: --junction_support
  - id: junction_tab
    type:
      - 'null'
      - File
    doc: short-read junctions in SJ.out.tab format. Use this option if you aligned
      your short-reads with STAR, STAR will automatically output this file
    inputBinding:
      position: 101
      prefix: --junction_tab
  - id: keep_intermediate
    type:
      - 'null'
      - boolean
    doc: specify if intermediate and temporary files are to be kept for debugging
    inputBinding:
      position: 101
      prefix: --keep_intermediate
  - id: keep_sup
    type:
      - 'null'
      - boolean
    doc: specify if you want to keep supplementary alignments to define isoforms
    inputBinding:
      position: 101
      prefix: --keep_sup
  - id: max_ends
    type:
      - 'null'
      - int
    doc: maximum number of TSS/TES picked per isoform
    inputBinding:
      position: 101
      prefix: --max_ends
  - id: no_align_to_annot
    type:
      - 'null'
      - boolean
    doc: specify if you don't want an initial alignment to the annotated sequences
      and only want transcript detection from the genomic alignment
    inputBinding:
      position: 101
      prefix: --noaligntoannot
  - id: no_redundant
    type:
      - 'null'
      - string
    doc: 'For each unique splice junction chain, report options include: none, longest,
      best_only'
    inputBinding:
      position: 101
      prefix: --no_redundant
  - id: parallel_mode
    type:
      - 'null'
      - string
    doc: 'parallelization mode. Options: bychrom, byregion, auto:xGB'
    inputBinding:
      position: 101
      prefix: --parallelmode
  - id: predict_cds
    type:
      - 'null'
      - boolean
    doc: specify if you want to predict the CDS of the final isoforms
    inputBinding:
      position: 101
      prefix: --predictCDS
  - id: ss_window
    type:
      - 'null'
      - int
    doc: window size for correcting splice sites
    inputBinding:
      position: 101
      prefix: --ss_window
  - id: stringent
    type:
      - 'null'
      - boolean
    doc: specify if all supporting reads need to be full-length (spanning 25 bp of
      the first and last exons)
    inputBinding:
      position: 101
      prefix: --stringent
  - id: support
    type:
      - 'null'
      - int
    doc: minimum number of supporting reads for an isoform
    inputBinding:
      position: 101
      prefix: --support
  - id: threads
    type:
      - 'null'
      - int
    doc: minimap2 number of threads
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output file name base for FLAIR isoforms
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flair:3.0.0--pyhdfd78af_0
