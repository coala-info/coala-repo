cwlVersion: v1.2
class: CommandLineTool
baseCommand: svviz
label: svviz
doc: "svviz version 1.6.2\n\nTool homepage: https://github.com/svviz/svviz"
inputs:
  - id: demo
    type:
      - 'null'
      - string
    doc: Run in demo mode
    inputBinding:
      position: 1
  - id: ref_fasta
    type:
      - 'null'
      - File
    doc: reference fasta file (a .faidx index file will be created if it doesn't
      exist so you need write permissions for this directory)
    inputBinding:
      position: 2
  - id: breakpoints
    type:
      - 'null'
      - type: array
        items: string
    doc: information about the breakpoint to be analyzed; see below for 
      information
    inputBinding:
      position: 3
  - id: aln_quality
    type:
      - 'null'
      - int
    doc: minimum score of the Smith-Waterman alignment against the ref or alt 
      allele in order to be considered (multiplied by 2)
    inputBinding:
      position: 104
      prefix: --aln-quality
  - id: aln_score_delta
    type:
      - 'null'
      - float
    doc: 'minimum difference in scores between ref alignment score and alt alignment
      score to be assigned to one allele (use an integer to specify a hard score difference
      threshold, or a float to specify a score difference relative to the read size;
    inputBinding:
      position: 104
      prefix: --aln-score-delta
  - id: annotations
    type:
      - 'null'
      - type: array
        items: File
    doc: bed or gtf file containing annotations to plot; will be compressed and 
      indexed using samtools tabix in place if needed (can specify multiple 
      annotations files)
    inputBinding:
      position: 104
      prefix: --annotations
  - id: bam_files
    type:
      - 'null'
      - type: array
        items: File
    doc: sorted, indexed bam file containing reads of interest to plot; can be 
      specified multiple times to load multiple samples
    inputBinding:
      position: 104
      prefix: --bam
  - id: context
    type:
      - 'null'
      - int
    doc: Number of additional nucleotides of genomic context to either side of 
      the visualization (useful for showing nearby annotations)
    inputBinding:
      position: 104
      prefix: --context
  - id: converter
    type:
      - 'null'
      - string
    doc: 'which program should be used to convert the output into PDF or PNG; choose
      from [webkitToPDF, librsvg, inkscape] (default: auto)'
    inputBinding:
      position: 104
      prefix: --converter
  - id: dotplots
    type:
      - 'null'
      - boolean
    doc: generate dotplots to show sequence homology within the aligned region; 
      requires some additional optional python libraries (scipy and PIL) and may
      take several minutes for longer variants
    inputBinding:
      position: 104
      prefix: --dotplots
  - id: event_type
    type:
      - 'null'
      - string
    doc: 'event type: either del[etion], ins[ertion], inv[ersion], mei (mobile element
      insertion), tra[nslocation], largedeletion (ldel), breakend (bkend) or batch
      (for reading variants from a VCF file in batch mode)'
    inputBinding:
      position: 104
      prefix: --type
  - id: export_insert_sizes
    type:
      - 'null'
      - boolean
    doc: plot the insert size distributions for each sample, for each event
    inputBinding:
      position: 104
      prefix: --export-insert-sizes
  - id: fast
    type:
      - 'null'
      - boolean
    doc: 'implements some optimizations designed to find exact sequence matches quickly;
      will substantially increase speed on Illumina data but may result in some inexact
      results; default: false'
    inputBinding:
      position: 104
      prefix: --fast
  - id: flanks
    type:
      - 'null'
      - boolean
    doc: 'Show reads in regions flanking the structural variant; these reads do not
      contribute to the ref or alt allele read counts (default: false)'
    inputBinding:
      position: 104
      prefix: --flanks
  - id: format
    type:
      - 'null'
      - string
    doc: file export format, either svg, png or pdf; by default, this is pdf 
      (batch mode) or automatically identified from the file extension of 
      --export
    inputBinding:
      position: 104
      prefix: --format
  - id: include_supplementary
    type:
      - 'null'
      - boolean
    doc: 'include supplementary alignments (ie, those with the 0x800 bit set in the
      bam flags); default: false'
    inputBinding:
      position: 104
      prefix: --include-supplementary
  - id: insertion_fasta
    type:
      - 'null'
      - File
    doc: An additional indexable fasta file specifying insertion sequences (eg 
      mobile element sequences)
    inputBinding:
      position: 104
      prefix: --fasta
  - id: lenient
    type:
      - 'null'
      - boolean
    doc: lowers the minimum alignment quality, showing reads even when 
      breakpoints are only approximately correct, or reads of lower quality (eg 
      PacBio); and requires a larger difference in alignment scores in order to 
      assign a read to an allele
    inputBinding:
      position: 104
      prefix: --lenient
  - id: max_deletion_size
    type:
      - 'null'
      - int
    doc: "deletion size above which the deletion is analyzed in breakend mode (default:
      don't convert to breakend mode)"
    inputBinding:
      position: 104
      prefix: --max-deletion-size
  - id: max_multimapping_similarity
    type:
      - 'null'
      - float
    doc: 'maximum ratio between best and second-best alignment scores within visualization
      region in order to retain read (default: 0.95)'
    inputBinding:
      position: 104
      prefix: --max-multimapping-similarity
  - id: max_reads
    type:
      - 'null'
      - int
    doc: 'maximum number of reads allowed, totaled across all samples, useful when
      running in batch mode (default: unlimited)'
    inputBinding:
      position: 104
      prefix: --max-reads
  - id: max_size
    type:
      - 'null'
      - int
    doc: 'maximum event size allowed, totaled across all chromosome parts in bp; if
      either the ref allele or alt allele exceeds this size, it will be skipped (default:
      unlimited)'
    inputBinding:
      position: 104
      prefix: --max-size
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: 'minimum mapping quality for reads (default: 0)'
    inputBinding:
      position: 104
      prefix: --min-mapq
  - id: no_web
    type:
      - 'null'
      - boolean
    doc: don't show the web interface
    inputBinding:
      position: 104
      prefix: --no-web
  - id: open_exported
    type:
      - 'null'
      - boolean
    doc: automatically open the exported file
    inputBinding:
      position: 104
      prefix: --open-exported
  - id: pair_min_mapq
    type:
      - 'null'
      - int
    doc: 'include only read pairs where at least one read end both exceeds PAIR_MAPQ
      and falls near the variant being analyzed (default: 0)'
    inputBinding:
      position: 104
      prefix: --pair-min-mapq
  - id: port
    type:
      - 'null'
      - int
    doc: 'define a port to use for the web browser (default: random port)'
    inputBinding:
      position: 104
      prefix: --port
  - id: processes
    type:
      - 'null'
      - int
    doc: 'how many processes to use for read realignment (default: use all available
      cores)'
    inputBinding:
      position: 104
      prefix: --processes
  - id: sample_reads
    type:
      - 'null'
      - int
    doc: 'use at most this many reads (pairs), sampling randomly if need be, useful
      when running in batch mode (default: use all reads)'
    inputBinding:
      position: 104
      prefix: --sample-reads
  - id: skip_cigar
    type:
      - 'null'
      - boolean
    doc: Don't color mismatches, insertions and deletions
    inputBinding:
      position: 104
      prefix: --skip-cigar
  - id: thicker_lines
    type:
      - 'null'
      - boolean
    doc: Reads are shown with thicker lines, potentially overlapping one 
      another, but increasing contrast when zoomed out
    inputBinding:
      position: 104
      prefix: --thicker-lines
  - id: verbose
    type:
      - 'null'
      - string
    doc: how verbose the progress and logging should be
    inputBinding:
      position: 104
      prefix: --verbose
outputs:
  - id: save_reads_path
    type:
      - 'null'
      - File
    doc: save relevant reads to this file (bam)
    outputBinding:
      glob: $(inputs.save_reads_path)
  - id: export
    type:
      - 'null'
      - File
    doc: export view to file; in single variant-mode, the exported file format 
      is determined from the filename extension unless --format is specified; in
      batch mode, this should be the name of a directory into which to save the 
      files (use --format to set format); setting --export automatically sets 
      --no-web
    outputBinding:
      glob: $(inputs.export)
  - id: summary_file
    type:
      - 'null'
      - File
    doc: save summary statistics to this (tab-delimited) file
    outputBinding:
      glob: $(inputs.summary_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svviz:1.6.2--py27h24bf2e0_0
