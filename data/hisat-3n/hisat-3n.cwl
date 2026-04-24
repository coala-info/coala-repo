cwlVersion: v1.2
class: CommandLineTool
baseCommand: hisat2
label: hisat-3n
doc: "HISAT2 version 2.2.1-3n-0.0.3 by Daehwan Kim (infphilo@gmail.com, www.ccb.jhu.edu/people/infphilo)\n\
  \nTool homepage: https://github.com/fulcrumgenomics/hisat-3n"
inputs:
  - id: index_prefix
    type: string
    doc: Index filename prefix (minus trailing .X.ht2)
    inputBinding:
      position: 1
  - id: add_chrname
    type:
      - 'null'
      - boolean
    doc: add 'chr' to reference names in alignment
    inputBinding:
      position: 102
      prefix: --add-chrname
  - id: aligned_pairs
    type:
      - 'null'
      - File
    doc: write pairs that aligned concordantly at least once to <path>
    inputBinding:
      position: 102
      prefix: --al-conc
  - id: aligned_pairs_bz2
    type:
      - 'null'
      - File
    doc: write pairs that aligned concordantly at least once to <path> (bzip2 
      compressed)
    inputBinding:
      position: 102
      prefix: --al-conc-bz2
  - id: aligned_pairs_gz
    type:
      - 'null'
      - File
    doc: write pairs that aligned concordantly at least once to <path> (gzipped)
    inputBinding:
      position: 102
      prefix: --al-conc-gz
  - id: aligned_reads
    type:
      - 'null'
      - File
    doc: write unpaired reads that aligned at least once to <path>
    inputBinding:
      position: 102
      prefix: --al
  - id: aligned_reads_bz2
    type:
      - 'null'
      - File
    doc: write unpaired reads that aligned at least once to <path> (bzip2 
      compressed)
    inputBinding:
      position: 102
      prefix: --al-bz2
  - id: aligned_reads_gz
    type:
      - 'null'
      - File
    doc: write unpaired reads that aligned at least once to <path> (gzipped)
    inputBinding:
      position: 102
      prefix: --al-gz
  - id: all_alignments
    type:
      - 'null'
      - boolean
    doc: "HISAT2 reports all alignments it can find. Using the option is equivalent
      to using both --max-seeds \n                     and -k with the maximum value
      that a 64-bit signed integer can represent (9,223,372,036,854,775,807)."
    inputBinding:
      position: 102
      prefix: --all
  - id: avoid_pseudogene
    type:
      - 'null'
      - boolean
    doc: tries to avoid aligning reads to pseudogenes (experimental option)
    inputBinding:
      position: 102
      prefix: --avoid-pseudogene
  - id: base_change
    type:
      - 'null'
      - string
    doc: the converted nucleotide and converted to nucleotide (C,T)
    inputBinding:
      position: 102
      prefix: --base-change
  - id: bowtie2_dp
    type:
      - 'null'
      - int
    doc: "use Bowtie2's dynamic programming alignment algorithm (0) - 0: no dynamic
      programming, 1: conditional dynamic programming, and 2: unconditional dynamic
      programming (slowest)"
    inputBinding:
      position: 102
      prefix: --bowtie2-dp
  - id: directional_mapping
    type:
      - 'null'
      - boolean
    doc: make directional mapping, please use this option only if your reads are
      prepared with a strand specific library (off)
    inputBinding:
      position: 102
      prefix: --directional-mapping
  - id: dta
    type:
      - 'null'
      - boolean
    doc: reports alignments tailored for transcript assemblers
    inputBinding:
      position: 102
      prefix: --dta
  - id: dta_cufflinks
    type:
      - 'null'
      - boolean
    doc: reports alignments tailored specifically for cufflinks
    inputBinding:
      position: 102
      prefix: --dta-cufflinks
  - id: fast
    type:
      - 'null'
      - boolean
    doc: 'Same as: --no-repeat-index'
    inputBinding:
      position: 102
  - id: ff_mates
    type:
      - 'null'
      - boolean
    doc: -1, -2 mates align fw/rev, rev/fw, fw/fw (--fr)
    inputBinding:
      position: 102
      prefix: --ff
  - id: fr_mates
    type:
      - 'null'
      - boolean
    doc: -1, -2 mates align fw/rev, rev/fw, fw/fw (--fr)
    inputBinding:
      position: 102
      prefix: --fr
  - id: ignore_quals
    type:
      - 'null'
      - boolean
    doc: treat all quality values as 30 on Phred scale (off)
    inputBinding:
      position: 102
      prefix: --ignore-quals
  - id: int_quals
    type:
      - 'null'
      - boolean
    doc: qualities encoded as space-delimited integers
    inputBinding:
      position: 102
  - id: known_splicesite_infile
    type:
      - 'null'
      - File
    doc: provide a list of known splice sites
    inputBinding:
      position: 102
      prefix: --known-splicesite-infile
  - id: mates1
    type:
      type: array
      items: File
    doc: "Files with #1 mates, paired with files in <m2>.\n             Could be gzip'ed
      (extension: .gz) or bzip2'ed (extension: .bz2)."
    inputBinding:
      position: 102
      prefix: '-1'
  - id: mates2
    type:
      type: array
      items: File
    doc: "Files with #2 mates, paired with files in <m1>.\n             Could be gzip'ed
      (extension: .gz) or bzip2'ed (extension: .bz2)."
    inputBinding:
      position: 102
      prefix: '-2'
  - id: max_alignments
    type:
      - 'null'
      - int
    doc: "It searches for at most <int> distinct, primary alignments for each read.
      Primary alignments mean \n                     alignments whose alignment score
      is equal to or higher than any other alignments. The search terminates \n  \
      \                   when it cannot find more distinct valid alignments, or when
      it finds <int>, whichever happens first. \n                     The alignment
      score for a paired-end alignment equals the sum of the alignment scores of \n\
      \                     the individual mates. Each reported read or pair alignment
      beyond the first has the SAM ‘secondary’ bit \n                     (which equals
      256) set in its FLAGS field. For reads that have more than <int> distinct, \n\
      \                     valid alignments, hisat2 does not guarantee that the <int>
      alignments reported are the best possible \n                     in terms of
      alignment score. Default: 5 (linear index) or 10 (graph index).\n          \
      \           Note: HISAT2 is not designed with large values for -k in mind, and
      when aligning reads to long, \n                     repetitive genomes, large
      -k could make alignment much slower."
    inputBinding:
      position: 102
      prefix: -k
  - id: max_insert_size
    type:
      - 'null'
      - int
    doc: maximum fragment length (500), only valid with --no-spliced-alignment
    inputBinding:
      position: 102
      prefix: --maxins
  - id: max_intronlen
    type:
      - 'null'
      - int
    doc: maximum intron length (500000)
    inputBinding:
      position: 102
      prefix: --max-intronlen
  - id: max_seeds
    type:
      - 'null'
      - int
    doc: "HISAT2, like other aligners, uses seed-and-extend approaches. HISAT2 tries
      to extend seeds to \n                     full-length alignments. In HISAT2,
      --max-seeds is used to control the maximum number of seeds that \n         \
      \            will be extended. For DNA-read alignment (--no-spliced-alignment),
      HISAT2 extends up to these many seeds\n                     and skips the rest
      of the seeds. For RNA-read alignment, HISAT2 skips extending seeds and reports\
      \ \n                     no alignments if the number of seeds is larger than
      the number specified with the option, \n                     to be compatible
      with previous versions of HISAT2. Large values for --max-seeds may improve alignment\
      \ \n                     sensitivity, but HISAT2 is not designed with large
      values for --max-seeds in mind, and when aligning \n                     reads
      to long, repetitive genomes, large --max-seeds could make alignment much slower.\
      \ \n                     The default value is the maximum of 5 and the value
      that comes with -k times 2."
    inputBinding:
      position: 102
      prefix: --max-seeds
  - id: memory_mapped_io
    type:
      - 'null'
      - boolean
    doc: use memory-mapped I/O for index; many 'hisat2's can share
    inputBinding:
      position: 102
      prefix: --mm
  - id: met_file
    type:
      - 'null'
      - File
    doc: send metrics to file at <path> (off)
    inputBinding:
      position: 102
      prefix: --met-file
  - id: met_interval
    type:
      - 'null'
      - int
    doc: report internal counters & metrics every <int> secs (1)
    inputBinding:
      position: 102
      prefix: --met
  - id: met_stderr
    type:
      - 'null'
      - boolean
    doc: send metrics to stderr (off)
    inputBinding:
      position: 102
      prefix: --met-stderr
  - id: min_insert_size
    type:
      - 'null'
      - int
    doc: minimum fragment length (0), only valid with --no-spliced-alignment
    inputBinding:
      position: 102
      prefix: --minins
  - id: min_intronlen
    type:
      - 'null'
      - int
    doc: minimum intron length (20)
    inputBinding:
      position: 102
      prefix: --min-intronlen
  - id: mp
    type:
      - 'null'
      - string
    doc: max and min penalties for mismatch; lower qual = lower penalty <6,2>
    inputBinding:
      position: 102
      prefix: --mp
  - id: n_ceil
    type:
      - 'null'
      - string
    doc: 'func for max # non-A/C/G/Ts permitted in aln (L,0,0.15)'
    inputBinding:
      position: 102
      prefix: --n-ceil
  - id: new_summary
    type:
      - 'null'
      - boolean
    doc: print alignment summary in a new style, which is more machine-friendly.
    inputBinding:
      position: 102
      prefix: --new-summary
  - id: no_discordant
    type:
      - 'null'
      - boolean
    doc: suppress discordant alignments for paired reads
    inputBinding:
      position: 102
      prefix: --no-discordant
  - id: no_head
    type:
      - 'null'
      - boolean
    doc: suppress header lines, i.e. lines starting with @
    inputBinding:
      position: 102
      prefix: --no-head
  - id: no_mixed
    type:
      - 'null'
      - boolean
    doc: suppress unpaired alignments for paired reads
    inputBinding:
      position: 102
      prefix: --no-mixed
  - id: no_repeat_index
    type:
      - 'null'
      - boolean
    doc: do not use repeat index
    inputBinding:
      position: 102
      prefix: --no-repeat-index
  - id: no_softclip
    type:
      - 'null'
      - boolean
    doc: no soft-clipping
    inputBinding:
      position: 102
      prefix: --no-softclip
  - id: no_spliced_alignment
    type:
      - 'null'
      - boolean
    doc: disable spliced alignment
    inputBinding:
      position: 102
      prefix: --no-spliced-alignment
  - id: no_sq
    type:
      - 'null'
      - boolean
    doc: suppress @SQ header lines
    inputBinding:
      position: 102
      prefix: --no-sq
  - id: no_temp_splicesite
    type:
      - 'null'
      - boolean
    doc: disable the use of splice sites found
    inputBinding:
      position: 102
      prefix: --no-temp-splicesite
  - id: no_templatelen_adjustment
    type:
      - 'null'
      - boolean
    doc: disables template length adjustment for RNA-seq reads
    inputBinding:
      position: 102
      prefix: --no-templatelen-adjustment
  - id: nofw
    type:
      - 'null'
      - boolean
    doc: do not align forward (original) version of read (off)
    inputBinding:
      position: 102
      prefix: --nofw
  - id: non_deterministic
    type:
      - 'null'
      - boolean
    doc: seed rand. gen. arbitrarily instead of using read attributes
    inputBinding:
      position: 102
      prefix: --non-deterministic
  - id: norc
    type:
      - 'null'
      - boolean
    doc: do not align reverse-complement version of read (off)
    inputBinding:
      position: 102
      prefix: --norc
  - id: novel_splicesite_infile
    type:
      - 'null'
      - File
    doc: provide a list of novel splice sites
    inputBinding:
      position: 102
      prefix: --novel-splicesite-infile
  - id: np
    type:
      - 'null'
      - int
    doc: penalty for non-A/C/G/Ts in read/ref (1)
    inputBinding:
      position: 102
      prefix: --np
  - id: offrate
    type:
      - 'null'
      - int
    doc: override offrate of index; must be >= index's offrate
    inputBinding:
      position: 102
      prefix: --offrate
  - id: omit_sec_seq
    type:
      - 'null'
      - boolean
    doc: put '*' in SEQ and QUAL fields for secondary alignments.
    inputBinding:
      position: 102
      prefix: --omit-sec-seq
  - id: pen_canintronlen
    type:
      - 'null'
      - string
    doc: penalty for long introns (G,-8,1) with canonical splice sites
    inputBinding:
      position: 102
      prefix: --pen-canintronlen
  - id: pen_cansplice
    type:
      - 'null'
      - int
    doc: penalty for a canonical splice site (0)
    inputBinding:
      position: 102
      prefix: --pen-cansplice
  - id: pen_noncanintronlen
    type:
      - 'null'
      - string
    doc: penalty for long introns (G,-8,1) with noncanonical splice sites
    inputBinding:
      position: 102
      prefix: --pen-noncanintronlen
  - id: pen_noncansplice
    type:
      - 'null'
      - int
    doc: penalty for a non-canonical splice site (12)
    inputBinding:
      position: 102
      prefix: --pen-noncansplice
  - id: phred33
    type:
      - 'null'
      - boolean
    doc: qualities are Phred+33 (default)
    inputBinding:
      position: 102
  - id: phred64
    type:
      - 'null'
      - boolean
    doc: qualities are Phred+64
    inputBinding:
      position: 102
  - id: qc_filter
    type:
      - 'null'
      - boolean
    doc: filter out reads that are bad according to QSEQ filter
    inputBinding:
      position: 102
      prefix: --qc-filter
  - id: query_fasta
    type:
      - 'null'
      - boolean
    doc: query input files are (multi-)FASTA .fa/.mfa
    inputBinding:
      position: 102
      prefix: -f
  - id: query_fastq
    type:
      - 'null'
      - boolean
    doc: query input files are FASTQ .fq/.fastq (default)
    inputBinding:
      position: 102
      prefix: -q
  - id: query_qseq
    type:
      - 'null'
      - boolean
    doc: query input files are in Illumina's qseq format
    inputBinding:
      position: 102
      prefix: --qseq
  - id: query_raw
    type:
      - 'null'
      - boolean
    doc: query input files are raw one-sequence-per-line
    inputBinding:
      position: 102
      prefix: -r
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: print nothing to stderr except serious errors
    inputBinding:
      position: 102
      prefix: --quiet
  - id: rdg
    type:
      - 'null'
      - string
    doc: read gap open, extend penalties (5,3)
    inputBinding:
      position: 102
      prefix: --rdg
  - id: reads
    type:
      type: array
      items: File
    doc: "Files with unpaired reads.\n             Could be gzip'ed (extension: .gz)
      or bzip2'ed (extension: .bz2)."
    inputBinding:
      position: 102
      prefix: -U
  - id: remove_chrname
    type:
      - 'null'
      - boolean
    doc: remove 'chr' from reference names in alignment
    inputBinding:
      position: 102
      prefix: --remove-chrname
  - id: reorder
    type:
      - 'null'
      - boolean
    doc: force SAM output order to match order of input reads
    inputBinding:
      position: 102
      prefix: --reorder
  - id: repeat_limit
    type:
      - 'null'
      - int
    doc: maximum number of repeat will be expanded for repeat alignment (1000)
    inputBinding:
      position: 102
      prefix: --repeat-limit
  - id: report_repeats
    type:
      - 'null'
      - boolean
    doc: report alignments to repeat sequences directly
    inputBinding:
      position: 102
      prefix: --repeat
  - id: rf_mates
    type:
      - 'null'
      - boolean
    doc: -1, -2 mates align fw/rev, rev/fw, fw/fw (--fr)
    inputBinding:
      position: 102
      prefix: --rf
  - id: rfg
    type:
      - 'null'
      - string
    doc: reference gap open, extend penalties (5,3)
    inputBinding:
      position: 102
      prefix: --rfg
  - id: rg_id
    type:
      - 'null'
      - string
    doc: 'set read group id, reflected in @RG line and RG:Z: opt field'
    inputBinding:
      position: 102
      prefix: --rg-id
  - id: rg_text
    type:
      - 'null'
      - string
    doc: "add <text> (\"lab:value\") to @RG line of SAM header.\n                \
      \        Note: @RG line only printed when --rg-id is set."
    inputBinding:
      position: 102
      prefix: --rg
  - id: rna_strandness
    type:
      - 'null'
      - string
    doc: specify strand-specific information (unstranded)
    inputBinding:
      position: 102
      prefix: --rna-strandness
  - id: score_min
    type:
      - 'null'
      - string
    doc: "min acceptable alignment score w/r/t read length\n                     (L,0.0,-0.2)"
    inputBinding:
      position: 102
      prefix: --score-min
  - id: seed
    type:
      - 'null'
      - int
    doc: seed for random number generator (0)
    inputBinding:
      position: 102
      prefix: --seed
  - id: sensitive
    type:
      - 'null'
      - boolean
    doc: 'Same as: --bowtie2-dp 1 -k 30 --score-min L,0,-0.5'
    inputBinding:
      position: 102
  - id: sequences_as_strings
    type:
      - 'null'
      - boolean
    doc: <m1>, <m2>, <r> are sequences themselves, not files
    inputBinding:
      position: 102
      prefix: -c
  - id: skip_reads
    type:
      - 'null'
      - int
    doc: skip the first <int> reads/pairs in the input (none)
    inputBinding:
      position: 102
      prefix: --skip
  - id: sp
    type:
      - 'null'
      - string
    doc: max and min penalties for soft-clipping; lower qual = lower penalty 
      <2,1>
    inputBinding:
      position: 102
      prefix: --sp
  - id: summary_file
    type:
      - 'null'
      - File
    doc: print alignment summary to this file.
    inputBinding:
      position: 102
      prefix: --summary-file
  - id: threads
    type:
      - 'null'
      - int
    doc: number of alignment threads to launch (1)
    inputBinding:
      position: 102
      prefix: --threads
  - id: time
    type:
      - 'null'
      - boolean
    doc: print wall-clock time taken by search phases
    inputBinding:
      position: 102
      prefix: --time
  - id: tmo
    type:
      - 'null'
      - boolean
    doc: reports only those alignments within known transcriptome
    inputBinding:
      position: 102
      prefix: --tmo
  - id: trim3
    type:
      - 'null'
      - int
    doc: trim <int> bases from 3'/right end of reads (0)
    inputBinding:
      position: 102
      prefix: --trim3
  - id: trim5
    type:
      - 'null'
      - int
    doc: trim <int> bases from 5'/left end of reads (0)
    inputBinding:
      position: 102
      prefix: --trim5
  - id: unaligned_pairs
    type:
      - 'null'
      - File
    doc: write pairs that didn't align concordantly to <path>
    inputBinding:
      position: 102
      prefix: --un-conc
  - id: unaligned_pairs_bz2
    type:
      - 'null'
      - File
    doc: write pairs that didn't align concordantly to <path> (bzip2 compressed)
    inputBinding:
      position: 102
      prefix: --un-conc-bz2
  - id: unaligned_pairs_gz
    type:
      - 'null'
      - File
    doc: write pairs that didn't align concordantly to <path> (gzipped)
    inputBinding:
      position: 102
      prefix: --un-conc-gz
  - id: unaligned_reads
    type:
      - 'null'
      - File
    doc: write unpaired reads that didn't align to <path>
    inputBinding:
      position: 102
      prefix: --un
  - id: unaligned_reads_bz2
    type:
      - 'null'
      - File
    doc: write unpaired reads that didn't align to <path> (bzip2 compressed)
    inputBinding:
      position: 102
      prefix: --un-bz2
  - id: unaligned_reads_gz
    type:
      - 'null'
      - File
    doc: write unpaired reads that didn't align to <path> (gzipped)
    inputBinding:
      position: 102
      prefix: --un-gz
  - id: unique_only
    type:
      - 'null'
      - boolean
    doc: only output the reads have unique alignment (off)
    inputBinding:
      position: 102
      prefix: --unique-only
  - id: upto_reads
    type:
      - 'null'
      - int
    doc: stop after first <int> reads/pairs (no limit)
    inputBinding:
      position: 102
      prefix: --upto
  - id: very_sensitive
    type:
      - 'null'
      - boolean
    doc: 'Same as: --bowtie2-dp 2 -k 50 --score-min L,0,-1'
    inputBinding:
      position: 102
outputs:
  - id: sam_output
    type:
      - 'null'
      - File
    doc: 'File for SAM output (default: stdout)'
    outputBinding:
      glob: $(inputs.sam_output)
  - id: novel_splicesite_outfile
    type:
      - 'null'
      - File
    doc: report a list of splice sites
    outputBinding:
      glob: $(inputs.novel_splicesite_outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hisat-3n:0.0.3--h503566f_0
