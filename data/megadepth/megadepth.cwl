cwlVersion: v1.2
class: CommandLineTool
baseCommand: megadepth
label: megadepth
doc: "BAM and BigWig utility.\n\nTool homepage: https://github.com/ChristopherWilks/megadepth"
inputs:
  - id: input_file
    type: string
    doc: Input BAM, BigWig, or '-' for STDIN
    inputBinding:
      position: 1
  - id: add_chr_prefix
    type:
      - 'null'
      - string
    doc: 'Adds "chr" prefix to relevant chromosomes for BAMs w/o it, pass "human"
      or "mouse". Only works for human/mouse references (default: off).'
    inputBinding:
      position: 102
      prefix: --add-chr-prefix
  - id: all_junctions
    type:
      - 'null'
      - boolean
    doc: Extract all jx coordinates, strand, and anchor length, per read for any
      jx. Writes to a TSV file <prefix>.all_jxs.tsv
    inputBinding:
      position: 102
      prefix: --all-junctions
  - id: alts
    type:
      - 'null'
      - boolean
    doc: Print differing from ref per-base coverages. Writes to a CSV file 
      <prefix>.alts.tsv
    inputBinding:
      position: 102
      prefix: --alts
  - id: annotation
    type:
      - 'null'
      - File
    doc: Only output the regions in this BED file, applying the argument to --op
      to them. Can also specify a contiguous region size in bp.
    inputBinding:
      position: 102
      prefix: --annotation
  - id: auc
    type:
      - 'null'
      - boolean
    doc: Print per-base area-under-coverage, will generate it for the genome and
      for the annotation if --annotation is also passed in. Defaults to STDOUT, 
      unless other params are passed in as well, then if writes to a TSV file 
      <prefix>.auc.tsv
    inputBinding:
      position: 102
      prefix: --auc
  - id: bwbuffer
    type:
      - 'null'
      - string
    doc: Size of buffer for reading BigWig files, critical to use a large value 
      (~1GB) for remote BigWigs. Default setting should be fine for most uses, 
      but raise if very slow on a remote BigWig.
    default: 1GB
    inputBinding:
      position: 102
      prefix: --bwbuffer
  - id: coverage
    type:
      - 'null'
      - boolean
    doc: Print per-base coverage (slow but totally worth it)
    inputBinding:
      position: 102
      prefix: --coverage
  - id: delta
    type:
      - 'null'
      - boolean
    doc: Print POS field as +/- delta from previous
    inputBinding:
      position: 102
      prefix: --delta
  - id: distance
    type:
      - 'null'
      - int
    doc: Number of base pairs between end of last annotation and start of new to
      consider in the same BigWig query window (a form of binning) for 
      performance. This determines the number of times the BigWig index is 
      queried.
    default: 2200
    inputBinding:
      position: 102
      prefix: --distance
  - id: double_count
    type:
      - 'null'
      - boolean
    doc: Allow overlapping ends of PE read to count twice toward coverage
    inputBinding:
      position: 102
      prefix: --double-count
  - id: echo_sam
    type:
      - 'null'
      - boolean
    doc: Print a SAM record for each aligned read
    inputBinding:
      position: 102
      prefix: --echo-sam
  - id: ends
    type:
      - 'null'
      - boolean
    doc: Report end coordinate for each read (useful for debugging)
    inputBinding:
      position: 102
      prefix: --ends
  - id: fasta
    type:
      - 'null'
      - File
    doc: Path to the reference FASTA file if a CRAM file is passed as the input 
      file (ignored otherwise). If not passed, references will be downloaded 
      using the CRAM header.
    inputBinding:
      position: 102
      prefix: --fasta
  - id: filter_in
    type:
      - 'null'
      - int
    doc: Integer bitmask, any bits of which alignments need to have to be kept 
      (similar to samtools view -f).
    inputBinding:
      position: 102
      prefix: --filter-in
  - id: filter_out
    type:
      - 'null'
      - int
    doc: Integer bitmask, any bits of which alignments need to have to be 
      skipped (similar to samtools view -F).
    inputBinding:
      position: 102
      prefix: --filter-out
  - id: frag_dist
    type:
      - 'null'
      - boolean
    doc: Print fragment length distribution across the genome. Writes to a TSV 
      file <prefix>.frags.tsv
    inputBinding:
      position: 102
      prefix: --frag-dist
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: Turns on gzipping of coverage output (no effect if --bigwig is passed),
      this will also enable --no-coverage-stdout.
    inputBinding:
      position: 102
      prefix: --gzip
  - id: head
    type:
      - 'null'
      - boolean
    doc: Print sequence names and lengths in SAM/BAM header
    inputBinding:
      position: 102
      prefix: --head
  - id: include_n
    type:
      - 'null'
      - boolean
    doc: Print mismatch records when mismatched read base is N
    inputBinding:
      position: 102
      prefix: --include-n
  - id: include_softclip
    type:
      - 'null'
      - boolean
    doc: Print a record to the alts CSV for soft-clipped bases. Writes total 
      counts to a separate TSV file <prefix>.softclip.tsv
    inputBinding:
      position: 102
      prefix: --include-softclip
  - id: junctions
    type:
      - 'null'
      - boolean
    doc: Extract co-occurring jx coordinates, strand, and anchor length, per 
      read. Writes to a TSV file <prefix>.jxs.tsv
    inputBinding:
      position: 102
      prefix: --junctions
  - id: keep_order
    type:
      - 'null'
      - boolean
    doc: Output annotation coverage in the order chromosomes appear in the 
      BAM/BigWig file. The default is to output annotation coverage in the order
      chromosomes appear in the annotation BED file. This is only applicable if 
      --annotation is used for either BAM or BigWig input.
    inputBinding:
      position: 102
      prefix: --keep-order
  - id: longreads
    type:
      - 'null'
      - boolean
    doc: Modifies certain buffer sizes to accommodate longer reads such as 
      PB/Oxford.
    inputBinding:
      position: 102
      prefix: --longreads
  - id: min_unique_qual
    type:
      - 'null'
      - int
    doc: Output second bigWig consisting built only from alignments with at 
      least this mapping quality. --bigwig must be specified. Also produces 
      second set of annotation sums based on this coverage if --annotation is 
      enabled
    inputBinding:
      position: 102
      prefix: --min-unique-qual
  - id: no_annotation_stdout
    type:
      - 'null'
      - boolean
    doc: Force summarized annotation regions to be written to 
      <prefix>.annotation.tsv rather than STDOUT
    inputBinding:
      position: 102
      prefix: --no-annotation-stdout
  - id: no_auc_stdout
    type:
      - 'null'
      - boolean
    doc: Force all AUC(s) to be written to <prefix>.auc.tsv rather than STDOUT
    inputBinding:
      position: 102
      prefix: --no-auc-stdout
  - id: no_coverage_stdout
    type:
      - 'null'
      - boolean
    doc: Force covered regions to be written to <prefix>.coverage.tsv rather 
      than STDOUT
    inputBinding:
      position: 102
      prefix: --no-coverage-stdout
  - id: no_index
    type:
      - 'null'
      - boolean
    doc: If using --annotation, skip the use of the BAM index (BAI) for pulling 
      out regions. Setting this can be faster if doing windows across the whole 
      genome. This will be turned on automatically if a window size is passed to
      --annotation.
    inputBinding:
      position: 102
      prefix: --no-index
  - id: num_bases
    type:
      - 'null'
      - boolean
    doc: Report total sum of bases in alignments processed (that pass filters)
    inputBinding:
      position: 102
      prefix: --num-bases
  - id: only_polya
    type:
      - 'null'
      - boolean
    doc: If --include-softclip, only print softclips which are mostly A's or T's
    inputBinding:
      position: 102
      prefix: --only-polya
  - id: op
    type:
      - 'null'
      - string
    doc: Statistic to run on the intervals provided by --annotation
    default: sum
    inputBinding:
      position: 102
      prefix: --op
  - id: prefix
    type:
      - 'null'
      - string
    doc: String to use to prefix all output files.
    inputBinding:
      position: 102
      prefix: --prefix
  - id: print_qual
    type:
      - 'null'
      - boolean
    doc: Print quality values for mismatched bases
    inputBinding:
      position: 102
      prefix: --print-qual
  - id: read_ends
    type:
      - 'null'
      - boolean
    doc: 'Print counts of read starts/ends, if --min-unique-qual is set then only
      the alignments that pass that filter will be counted here. Writes to 2 TSV files:
      <prefix>.starts.tsv, <prefix>.ends.tsv'
    inputBinding:
      position: 102
      prefix: --read-ends
  - id: require_mdz
    type:
      - 'null'
      - boolean
    doc: Quit with error unless MD:Z field exists everywhere it's expected
    inputBinding:
      position: 102
      prefix: --require-mdz
  - id: sums_only
    type:
      - 'null'
      - boolean
    doc: Discard coordinates from output of summarized regions
    inputBinding:
      position: 102
      prefix: --sums-only
  - id: test_polya
    type:
      - 'null'
      - boolean
    doc: Lower Poly-A filter minimums for testing (only useful for 
      debugging/testing)
    inputBinding:
      position: 102
      prefix: --test-polya
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for BAM decompression or parallel BigWig sum 
      computation. If computing sums over multiple BigWigs in parallel, a TXT 
      file listing the paths to the BigWigs should be passed as the main input 
      file.
    inputBinding:
      position: 102
      prefix: --threads
  - id: unsorted
    type:
      - 'null'
      - boolean
    doc: There's a performance improvement if BED file passed to --annotation is
      sorted by sort -k1,1 -k2,2n. Default is to assume sorted and check for 
      unsorted positions, if unsorted positions are found, will fall back to 
      slower version.
    default: false
    inputBinding:
      position: 102
      prefix: --unsorted
outputs:
  - id: bigwig_output
    type:
      - 'null'
      - File
    doc: Output coverage as BigWig file(s). Writes to <prefix>.bw (also 
      <prefix>.unique.bw when --min-unique-qual is specified). Requires 
      libBigWig.
    outputBinding:
      glob: $(inputs.bigwig_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/megadepth:1.2.0--h5ca1c30_7
