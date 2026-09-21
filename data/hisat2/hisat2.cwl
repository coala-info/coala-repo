cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hisat2
label: hisat2
doc: HISAT2 is a fast and sensitive alignment program for mapping 
  next-generation sequencing reads (both DNA and RNA) to a population of human 
  genomes as well as to a single reference genome.
inputs:
  - id: index
    type: string
    doc: Index filename prefix (minus trailing .X.ht2).
    inputBinding:
      position: 101
      prefix: -x
  - id: mate1
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files with #1 mates, paired with files in <m2>. Could be gzip'ed (extension:
      .gz) or bzip2'ed (extension: .bz2)."
    inputBinding:
      position: 101
      prefix: '-1'
      itemSeparator: ','
  - id: mate2
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files with #2 mates, paired with files in <m1>. Could be gzip'ed (extension:
      .gz) or bzip2'ed (extension: .bz2)."
    inputBinding:
      position: 101
      prefix: '-2'
      itemSeparator: ','
  - id: unpaired_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files with unpaired reads. Could be gzip'ed (extension: .gz) or bzip2'ed
      (extension: .bz2)."
    inputBinding:
      position: 101
      prefix: -U
      itemSeparator: ','
  - id: output_sam
    type:
      - 'null'
      - string
    doc: 'File for SAM output (default: stdout)'
    inputBinding:
      position: 101
      prefix: -S
  - id: fastq_input
    type:
      - 'null'
      - boolean
    doc: query input files are FASTQ .fq/.fastq (default)
    inputBinding:
      position: 101
      prefix: -q
  - id: qseq_input
    type:
      - 'null'
      - boolean
    doc: query input files are in Illumina's qseq format
    inputBinding:
      position: 101
      prefix: --qseq
  - id: fasta_input
    type:
      - 'null'
      - boolean
    doc: query input files are (multi-)FASTA .fa/.mfa
    inputBinding:
      position: 101
      prefix: -f
  - id: raw_input
    type:
      - 'null'
      - boolean
    doc: query input files are raw one-sequence-per-line
    inputBinding:
      position: 101
      prefix: -r
  - id: sequence_input
    type:
      - 'null'
      - boolean
    doc: <m1>, <m2>, <r> are sequences themselves, not files
    inputBinding:
      position: 101
      prefix: -c
  - id: skip
    type:
      - 'null'
      - int
    doc: skip the first <int> reads/pairs in the input (none)
    inputBinding:
      position: 101
      prefix: --skip
  - id: upto
    type:
      - 'null'
      - int
    doc: stop after first <int> reads/pairs (no limit)
    inputBinding:
      position: 101
      prefix: --upto
  - id: trim5
    type:
      - 'null'
      - int
    doc: trim <int> bases from 5'/left end of reads (0)
    inputBinding:
      position: 101
      prefix: --trim5
  - id: trim3
    type:
      - 'null'
      - int
    doc: trim <int> bases from 3'/right end of reads (0)
    inputBinding:
      position: 101
      prefix: --trim3
  - id: phred33
    type:
      - 'null'
      - boolean
    doc: qualities are Phred+33 (default)
    inputBinding:
      position: 101
      prefix: --phred33
  - id: phred64
    type:
      - 'null'
      - boolean
    doc: qualities are Phred+64
    inputBinding:
      position: 101
      prefix: --phred64
  - id: int_quals
    type:
      - 'null'
      - boolean
    doc: qualities encoded as space-delimited integers
    inputBinding:
      position: 101
      prefix: --int-quals
  - id: fast
    type:
      - 'null'
      - boolean
    doc: 'Preset: same as --no-repeat-index'
    inputBinding:
      position: 101
      prefix: --fast
  - id: sensitive
    type:
      - 'null'
      - boolean
    doc: 'Preset: same as --bowtie2-dp 1 -k 30 --score-min L,0,-0.5'
    inputBinding:
      position: 101
      prefix: --sensitive
  - id: very_sensitive
    type:
      - 'null'
      - boolean
    doc: 'Preset: same as --bowtie2-dp 2 -k 50 --score-min L,0,-1'
    inputBinding:
      position: 101
      prefix: --very-sensitive
  - id: bowtie2_dp
    type:
      - 'null'
      - int
    doc: "use Bowtie2's dynamic programming alignment algorithm (0) - 0: no dynamic
      programming, 1: conditional dynamic programming, and 2: unconditional dynamic
      programming (slowest)"
    inputBinding:
      position: 101
      prefix: --bowtie2-dp
  - id: n_ceil
    type:
      - 'null'
      - string
    doc: 'func for max # non-A/C/G/Ts permitted in aln (L,0,0.15)'
    inputBinding:
      position: 101
      prefix: --n-ceil
  - id: ignore_quals
    type:
      - 'null'
      - boolean
    doc: treat all quality values as 30 on Phred scale (off)
    inputBinding:
      position: 101
      prefix: --ignore-quals
  - id: nofw
    type:
      - 'null'
      - boolean
    doc: do not align forward (original) version of read (off)
    inputBinding:
      position: 101
      prefix: --nofw
  - id: norc
    type:
      - 'null'
      - boolean
    doc: do not align reverse-complement version of read (off)
    inputBinding:
      position: 101
      prefix: --norc
  - id: no_repeat_index
    type:
      - 'null'
      - boolean
    doc: do not use repeat index
    inputBinding:
      position: 101
      prefix: --no-repeat-index
  - id: pen_cansplice
    type:
      - 'null'
      - int
    doc: penalty for a canonical splice site (0)
    inputBinding:
      position: 101
      prefix: --pen-cansplice
  - id: pen_noncansplice
    type:
      - 'null'
      - int
    doc: penalty for a non-canonical splice site (12)
    inputBinding:
      position: 101
      prefix: --pen-noncansplice
  - id: pen_canintronlen
    type:
      - 'null'
      - string
    doc: penalty for long introns (G,-8,1) with canonical splice sites
    inputBinding:
      position: 101
      prefix: --pen-canintronlen
  - id: pen_noncanintronlen
    type:
      - 'null'
      - string
    doc: penalty for long introns (G,-8,1) with noncanonical splice sites
    inputBinding:
      position: 101
      prefix: --pen-noncanintronlen
  - id: min_intronlen
    type:
      - 'null'
      - int
    doc: minimum intron length (20)
    inputBinding:
      position: 101
      prefix: --min-intronlen
  - id: max_intronlen
    type:
      - 'null'
      - int
    doc: maximum intron length (500000)
    inputBinding:
      position: 101
      prefix: --max-intronlen
  - id: known_splicesite_infile
    type:
      - 'null'
      - File
    doc: provide a list of known splice sites
    inputBinding:
      position: 101
      prefix: --known-splicesite-infile
  - id: novel_splicesite_outfile
    type:
      - 'null'
      - string
    doc: report a list of splice sites
    inputBinding:
      position: 101
      prefix: --novel-splicesite-outfile
  - id: novel_splicesite_infile
    type:
      - 'null'
      - File
    doc: provide a list of novel splice sites
    inputBinding:
      position: 101
      prefix: --novel-splicesite-infile
  - id: no_temp_splicesite
    type:
      - 'null'
      - boolean
    doc: disable the use of splice sites found
    inputBinding:
      position: 101
      prefix: --no-temp-splicesite
  - id: no_spliced_alignment
    type:
      - 'null'
      - boolean
    doc: disable spliced alignment
    inputBinding:
      position: 101
      prefix: --no-spliced-alignment
  - id: rna_strandness
    type:
      - 'null'
      - string
    doc: specify strand-specific information (unstranded)
    inputBinding:
      position: 101
      prefix: --rna-strandness
  - id: tmo
    type:
      - 'null'
      - boolean
    doc: reports only those alignments within known transcriptome
    inputBinding:
      position: 101
      prefix: --tmo
  - id: dta
    type:
      - 'null'
      - boolean
    doc: reports alignments tailored for transcript assemblers
    inputBinding:
      position: 101
      prefix: --dta
  - id: dta_cufflinks
    type:
      - 'null'
      - boolean
    doc: reports alignments tailored specifically for cufflinks
    inputBinding:
      position: 101
      prefix: --dta-cufflinks
  - id: avoid_pseudogene
    type:
      - 'null'
      - boolean
    doc: tries to avoid aligning reads to pseudogenes (experimental option)
    inputBinding:
      position: 101
      prefix: --avoid-pseudogene
  - id: no_templatelen_adjustment
    type:
      - 'null'
      - boolean
    doc: disables template length adjustment for RNA-seq reads
    inputBinding:
      position: 101
      prefix: --no-templatelen-adjustment
  - id: mp
    type:
      - 'null'
      - string
    doc: max and min penalties for mismatch; lower qual = lower penalty <6,2>
    inputBinding:
      position: 101
      prefix: --mp
  - id: sp
    type:
      - 'null'
      - string
    doc: max and min penalties for soft-clipping; lower qual = lower penalty 
      <2,1>
    inputBinding:
      position: 101
      prefix: --sp
  - id: no_softclip
    type:
      - 'null'
      - boolean
    doc: no soft-clipping
    inputBinding:
      position: 101
      prefix: --no-softclip
  - id: np
    type:
      - 'null'
      - int
    doc: penalty for non-A/C/G/Ts in read/ref (1)
    inputBinding:
      position: 101
      prefix: --np
  - id: rdg
    type:
      - 'null'
      - string
    doc: read gap open, extend penalties (5,3)
    inputBinding:
      position: 101
      prefix: --rdg
  - id: rfg
    type:
      - 'null'
      - string
    doc: reference gap open, extend penalties (5,3)
    inputBinding:
      position: 101
      prefix: --rfg
  - id: score_min
    type:
      - 'null'
      - string
    doc: min acceptable alignment score w/r/t read length (L,0.0,-0.2)
    inputBinding:
      position: 101
      prefix: --score-min
  - id: k
    type:
      - 'null'
      - int
    doc: 'It searches for at most <int> distinct, primary alignments for each read.
      Primary alignments mean alignments whose alignment score is equal to or higher
      than any other alignments. Default: 5 (linear index) or 10 (graph index).'
    inputBinding:
      position: 101
      prefix: -k
  - id: max_seeds
    type:
      - 'null'
      - int
    doc: HISAT2 tries to extend seeds to full-length alignments. In HISAT2, 
      --max-seeds is used to control the maximum number of seeds that will be 
      extended. The default value is the maximum of 5 and the value that comes 
      with -k times 2.
    inputBinding:
      position: 101
      prefix: --max-seeds
  - id: all
    type:
      - 'null'
      - boolean
    doc: HISAT2 reports all alignments it can find. Using the option is 
      equivalent to using both --max-seeds and -k with the maximum value that a 
      64-bit signed integer can represent.
    inputBinding:
      position: 101
      prefix: --all
  - id: repeat
    type:
      - 'null'
      - boolean
    doc: report alignments to repeat sequences directly
    inputBinding:
      position: 101
      prefix: --repeat
  - id: minins
    type:
      - 'null'
      - int
    doc: minimum fragment length (0), only valid with --no-spliced-alignment
    inputBinding:
      position: 101
      prefix: --minins
  - id: maxins
    type:
      - 'null'
      - int
    doc: maximum fragment length (500), only valid with --no-spliced-alignment
    inputBinding:
      position: 101
      prefix: --maxins
  - id: fr
    type:
      - 'null'
      - boolean
    doc: -1, -2 mates align fw/rev (--fr)
    inputBinding:
      position: 101
      prefix: --fr
  - id: rf
    type:
      - 'null'
      - boolean
    doc: -1, -2 mates align rev/fw
    inputBinding:
      position: 101
      prefix: --rf
  - id: ff
    type:
      - 'null'
      - boolean
    doc: -1, -2 mates align fw/fw
    inputBinding:
      position: 101
      prefix: --ff
  - id: no_mixed
    type:
      - 'null'
      - boolean
    doc: suppress unpaired alignments for paired reads
    inputBinding:
      position: 101
      prefix: --no-mixed
  - id: no_discordant
    type:
      - 'null'
      - boolean
    doc: suppress discordant alignments for paired reads
    inputBinding:
      position: 101
      prefix: --no-discordant
  - id: time
    type:
      - 'null'
      - boolean
    doc: print wall-clock time taken by search phases
    inputBinding:
      position: 101
      prefix: --time
  - id: un
    type:
      - 'null'
      - string
    doc: write unpaired reads that didn't align to <path>
    inputBinding:
      position: 101
      prefix: --un
  - id: al
    type:
      - 'null'
      - string
    doc: write unpaired reads that aligned at least once to <path>
    inputBinding:
      position: 101
      prefix: --al
  - id: un_conc
    type:
      - 'null'
      - string
    doc: write pairs that didn't align concordantly to <path>
    inputBinding:
      position: 101
      prefix: --un-conc
  - id: al_conc
    type:
      - 'null'
      - string
    doc: write pairs that aligned concordantly at least once to <path>
    inputBinding:
      position: 101
      prefix: --al-conc
  - id: un_gz
    type:
      - 'null'
      - string
    doc: gzip compress output and write unpaired reads that didn't align to 
      <path>
    inputBinding:
      position: 101
      prefix: --un-gz
  - id: al_gz
    type:
      - 'null'
      - string
    doc: gzip compress output and write unpaired reads that aligned at least 
      once to <path>
    inputBinding:
      position: 101
      prefix: --al-gz
  - id: un_conc_gz
    type:
      - 'null'
      - string
    doc: gzip compress output and write pairs that didn't align concordantly to 
      <path>
    inputBinding:
      position: 101
      prefix: --un-conc-gz
  - id: al_conc_gz
    type:
      - 'null'
      - string
    doc: gzip compress output and write pairs that aligned concordantly at least
      once to <path>
    inputBinding:
      position: 101
      prefix: --al-conc-gz
  - id: un_bz2
    type:
      - 'null'
      - string
    doc: bzip2 compress output and write unpaired reads that didn't align to 
      <path>
    inputBinding:
      position: 101
      prefix: --un-bz2
  - id: al_bz2
    type:
      - 'null'
      - string
    doc: bzip2 compress output and write unpaired reads that aligned at least 
      once to <path>
    inputBinding:
      position: 101
      prefix: --al-bz2
  - id: un_conc_bz2
    type:
      - 'null'
      - string
    doc: bzip2 compress output and write pairs that didn't align concordantly to
      <path>
    inputBinding:
      position: 101
      prefix: --un-conc-bz2
  - id: al_conc_bz2
    type:
      - 'null'
      - string
    doc: bzip2 compress output and write pairs that aligned concordantly at 
      least once to <path>
    inputBinding:
      position: 101
      prefix: --al-conc-bz2
  - id: summary_file
    type:
      - 'null'
      - string
    doc: print alignment summary to this file.
    inputBinding:
      position: 101
      prefix: --summary-file
  - id: new_summary
    type:
      - 'null'
      - boolean
    doc: print alignment summary in a new style, which is more machine-friendly.
    inputBinding:
      position: 101
      prefix: --new-summary
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: print nothing to stderr except serious errors
    inputBinding:
      position: 101
      prefix: --quiet
  - id: met_file
    type:
      - 'null'
      - string
    doc: send metrics to file at <path> (off)
    inputBinding:
      position: 101
      prefix: --met-file
  - id: met_stderr
    type:
      - 'null'
      - boolean
    doc: send metrics to stderr (off)
    inputBinding:
      position: 101
      prefix: --met-stderr
  - id: met
    type:
      - 'null'
      - int
    doc: report internal counters & metrics every <int> secs (1)
    inputBinding:
      position: 101
      prefix: --met
  - id: no_head
    type:
      - 'null'
      - boolean
    doc: suppress header lines, i.e. lines starting with @
    inputBinding:
      position: 101
      prefix: --no-head
  - id: no_sq
    type:
      - 'null'
      - boolean
    doc: suppress @SQ header lines
    inputBinding:
      position: 101
      prefix: --no-sq
  - id: rg_id
    type:
      - 'null'
      - string
    doc: 'set read group id, reflected in @RG line and RG:Z: opt field'
    inputBinding:
      position: 101
      prefix: --rg-id
  - id: rg
    type:
      - 'null'
      - type: array
        items: string
    doc: 'add <text> ("lab:value") to @RG line of SAM header. Note: @RG line only
      printed when --rg-id is set.'
    inputBinding:
      position: 101
      prefix: --rg
  - id: omit_sec_seq
    type:
      - 'null'
      - boolean
    doc: put '*' in SEQ and QUAL fields for secondary alignments.
    inputBinding:
      position: 101
      prefix: --omit-sec-seq
  - id: offrate
    type:
      - 'null'
      - int
    doc: override offrate of index; must be >= index's offrate
    inputBinding:
      position: 101
      prefix: --offrate
  - id: threads
    type:
      - 'null'
      - int
    doc: number of alignment threads to launch (1)
    inputBinding:
      position: 101
      prefix: --threads
  - id: reorder
    type:
      - 'null'
      - boolean
    doc: force SAM output order to match order of input reads
    inputBinding:
      position: 101
      prefix: --reorder
  - id: mm
    type:
      - 'null'
      - boolean
    doc: use memory-mapped I/O for index; many 'hisat2's can share
    inputBinding:
      position: 101
      prefix: --mm
  - id: temp_directory
    type:
      - 'null'
      - string
    doc: set the directory for holding temporary files (/tmp)
    inputBinding:
      position: 101
      prefix: --temp-directory
  - id: qc_filter
    type:
      - 'null'
      - boolean
    doc: filter out reads that are bad according to QSEQ filter
    inputBinding:
      position: 101
      prefix: --qc-filter
  - id: seed
    type:
      - 'null'
      - int
    doc: seed for random number generator (0)
    inputBinding:
      position: 101
      prefix: --seed
  - id: non_deterministic
    type:
      - 'null'
      - boolean
    doc: seed rand. gen. arbitrarily instead of using read attributes
    inputBinding:
      position: 101
      prefix: --non-deterministic
  - id: remove_chrname
    type:
      - 'null'
      - boolean
    doc: remove 'chr' from reference names in alignment
    inputBinding:
      position: 101
      prefix: --remove-chrname
  - id: add_chrname
    type:
      - 'null'
      - boolean
    doc: add 'chr' to reference names in alignment
    inputBinding:
      position: 101
      prefix: --add-chrname
outputs:
  - id: output_output_sam
    type:
      - 'null'
      - File
    doc: 'File for SAM output (default: stdout)'
    outputBinding:
      glob: $(inputs.output_sam)
  - id: output_novel_splicesite_outfile
    type:
      - 'null'
      - File
    doc: report a list of splice sites
    outputBinding:
      glob: $(inputs.novel_splicesite_outfile)
  - id: output_un
    type:
      - 'null'
      - File
    doc: write unpaired reads that didn't align to <path>
    outputBinding:
      glob: $(inputs.un)
  - id: output_al
    type:
      - 'null'
      - File
    doc: write unpaired reads that aligned at least once to <path>
    outputBinding:
      glob: $(inputs.al)
  - id: output_un_conc
    type:
      - 'null'
      - File
    doc: write pairs that didn't align concordantly to <path>
    outputBinding:
      glob: $(inputs.un_conc)
  - id: output_al_conc
    type:
      - 'null'
      - File
    doc: write pairs that aligned concordantly at least once to <path>
    outputBinding:
      glob: $(inputs.al_conc)
  - id: output_un_gz
    type:
      - 'null'
      - File
    doc: gzip compress output and write unpaired reads that didn't align to 
      <path>
    outputBinding:
      glob: $(inputs.un_gz)
  - id: output_al_gz
    type:
      - 'null'
      - File
    doc: gzip compress output and write unpaired reads that aligned at least 
      once to <path>
    outputBinding:
      glob: $(inputs.al_gz)
  - id: output_un_conc_gz
    type:
      - 'null'
      - File
    doc: gzip compress output and write pairs that didn't align concordantly to 
      <path>
    outputBinding:
      glob: $(inputs.un_conc_gz)
  - id: output_al_conc_gz
    type:
      - 'null'
      - File
    doc: gzip compress output and write pairs that aligned concordantly at least
      once to <path>
    outputBinding:
      glob: $(inputs.al_conc_gz)
  - id: output_un_bz2
    type:
      - 'null'
      - File
    doc: bzip2 compress output and write unpaired reads that didn't align to 
      <path>
    outputBinding:
      glob: $(inputs.un_bz2)
  - id: output_al_bz2
    type:
      - 'null'
      - File
    doc: bzip2 compress output and write unpaired reads that aligned at least 
      once to <path>
    outputBinding:
      glob: $(inputs.al_bz2)
  - id: output_un_conc_bz2
    type:
      - 'null'
      - File
    doc: bzip2 compress output and write pairs that didn't align concordantly to
      <path>
    outputBinding:
      glob: $(inputs.un_conc_bz2)
  - id: output_al_conc_bz2
    type:
      - 'null'
      - File
    doc: bzip2 compress output and write pairs that aligned concordantly at 
      least once to <path>
    outputBinding:
      glob: $(inputs.al_conc_bz2)
  - id: output_summary_file
    type:
      - 'null'
      - File
    doc: print alignment summary to this file.
    outputBinding:
      glob: $(inputs.summary_file)
  - id: output_met_file
    type:
      - 'null'
      - File
    doc: send metrics to file at <path> (off)
    outputBinding:
      glob: $(inputs.met_file)
  - id: output_temp_directory
    type:
      - 'null'
      - Directory
    doc: set the directory for holding temporary files (/tmp)
    outputBinding:
      glob: $(inputs.temp_directory)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hisat2:2.2.3--h8471819_0
s:url: https://daehwankimlab.github.io/hisat2
$namespaces:
  s: https://schema.org/
