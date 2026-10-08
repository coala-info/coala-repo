cwlVersion: v1.2
class: CommandLineTool
baseCommand: gsnap
label: gmap_gsnap
doc: "Genomic Short-read Nucleotide Alignment Program (GSNAP)\n\nTool homepage: http://research-pub.gene.com/gmap/"
inputs:
  - id: reads
    type:
      type: array
      items: File
    doc: Input FASTA/FASTQ file(s) with the reads (two files for paired-end reads)
    inputBinding:
      position: 110
  - id: output_name
    type: string
    default: gsnap.out
    doc: Name of the file that receives the standard output (the alignments)
  - id: dir
    type:
      - 'null'
      - Directory
    doc: "Genome directory.  Default (as specified by --with-gmapdb to the configure program) is /usr/local/share"
    inputBinding:
      position: 101
      prefix: --dir
  - id: db
    type:
      - 'null'
      - string
    doc: "Genome database"
    inputBinding:
      position: 101
      prefix: --db
  - id: two_pass
    type:
      - 'null'
      - boolean
    doc: "Two-pass mode, in which the sequences are processed first to identify splice sites and introns, and then aligned using this splicing information"
    inputBinding:
      position: 101
      prefix: --two-pass
  - id: use_localdb
    type:
      - 'null'
      - int
    doc: "Whether to use the local suffix arrays, which help with finding extensions to the ends of alignments in the presence of splicing or indels (0=no, 1=yes if available (default))"
    inputBinding:
      position: 101
      prefix: --use-localdb
  - id: transcriptdir
    type:
      - 'null'
      - Directory
    doc: "Transcriptome directory.  Default is the value for --dir above"
    inputBinding:
      position: 101
      prefix: --transcriptdir
  - id: transcriptdb
    type:
      - 'null'
      - string
    doc: "Transcriptome database"
    inputBinding:
      position: 101
      prefix: --transcriptdb
  - id: transcriptome_mode
    type:
      - 'null'
      - string
    doc: "Options: assist, only, annotate (default).  The option assist means to try transcriptome alignment first, but then use genomic alignment if nothing is found.  The option only means to try transcriptome alignment only.  The option annotate means to try only genomic alignment, to use the transcriptome only for annotation; this is the fastest option.  In the other two options, annotation is also performed"
    inputBinding:
      position: 101
      prefix: --transcriptome-mode
  - id: kmer
    type:
      - 'null'
      - int
    doc: "kmer size to use in genome database (allowed values: 16 or less) If not specified, the program will find the highest available kmer size in the genome database"
    inputBinding:
      position: 101
      prefix: --kmer
  - id: sampling
    type:
      - 'null'
      - int
    doc: "Sampling to use in genome database.  If not specified, the program will find the smallest available sampling value in the genome database within selected k-mer size"
    inputBinding:
      position: 101
      prefix: --sampling
  - id: align_fraction
    type:
      - 'null'
      - float
    doc: "Process only the given fraction of reads, selected at random If --align-fraction and --part are given, --align-fraction takes precedence"
    inputBinding:
      position: 101
      prefix: --align-fraction
  - id: part
    type:
      - 'null'
      - string
    doc: "Process only the i-th out of every n sequences e.g., 0/100 or 99/100 (useful for distributing jobs to a computer farm)."
    inputBinding:
      position: 101
      prefix: --part
  - id: input_buffer_size
    type:
      - 'null'
      - int
    doc: "Size of input buffer (program reads this many sequences at a time for efficiency) (default 10000)"
    inputBinding:
      position: 101
      prefix: --input-buffer-size
  - id: barcode_length
    type:
      - 'null'
      - int
    doc: "Amount of barcode to remove from start of every read before alignment (default 0)"
    inputBinding:
      position: 101
      prefix: --barcode-length
  - id: endtrim_length
    type:
      - 'null'
      - int
    doc: "Amount of trim to remove from the end of every read before alignment (default 0)"
    inputBinding:
      position: 101
      prefix: --endtrim-length
  - id: orientation
    type:
      - 'null'
      - string
    doc: "Orientation of paired-end reads Allowed values: FR (fwd-rev, or typical Illumina; default), RF (rev-fwd, for circularized inserts), or FF (fwd-fwd, same strand), or 10X (single-cell where read 1 has barcode information; read 2 is rev)"
    inputBinding:
      position: 101
      prefix: --orientation
  - id: 10x_whitelist
    type:
      - 'null'
      - File
    doc: "Whitelist of 10X Genomics GEM bead barcodes, needed to perform correction of cellular barcodes.  This file can be obtained at cellranger-x.y.z/lib/python/cellranger/barcodes (for Cell Ranger version >= 4) cellranger-x.y.z/lib/cellranger-cs/x.y.z/lib/python/cellranger/barcodes (<= 3)"
    inputBinding:
      position: 101
      prefix: --10x-whitelist
  - id: 10x_well_position
    type:
      - 'null'
      - int
    doc: "Position of well information in the accession, when separated by colons If set to 0, then no well information will be printed in the CB field (default: 4)"
    inputBinding:
      position: 101
      prefix: --10x-well-position
  - id: fastq_id_start
    type:
      - 'null'
      - int
    doc: "Starting position of identifier in FASTQ header, space-delimited (>= 1)"
    inputBinding:
      position: 101
      prefix: --fastq-id-start
  - id: fastq_id_end
    type:
      - 'null'
      - int
    doc: "Ending position of identifier in FASTQ header, space-delimited (>= 1) Examples: @HWUSI-EAS100R:6:73:941:1973#0/1 start=1, end=1 (default) => identifier is HWUSI-EAS100R:6:73:941:1973#0 @SRR001666.1 071112_SLXA-EAS1_s_7:5:1:817:345 length=36 start=1, end=1  => identifier is SRR001666.1 start=2, end=2  => identifier is 071112_SLXA-EAS1_s_7:5:1:817:345 start=1, end=2  => identifier is SRR001666.1 071112_SLXA-EAS1_s_7:5:1:817:345"
    inputBinding:
      position: 101
      prefix: --fastq-id-end
  - id: force_single_end
    type:
      - 'null'
      - boolean
    doc: "When multiple FASTQ files are provided on the command line, GSNAP assumes they are matching paired-end files.  This flag treats each file as single-end."
    inputBinding:
      position: 101
      prefix: --force-single-end
  - id: filter_chastity
    type:
      - 'null'
      - string
    doc: "Skips reads marked by the Illumina chastity program.  Expecting a string after the accession having a 'Y' after the first colon, like this: @accession 1:Y:0:CTTGTA where the 'Y' signifies filtering by chastity. Values: off (default), either, both.  For 'either', a 'Y' on either end of a paired-end read will be filtered.  For 'both', a 'Y' is required on both ends of a paired-end read (or on the only end of a single-end read)."
    inputBinding:
      position: 101
      prefix: --filter-chastity
  - id: allow_pe_name_mismatch
    type:
      - 'null'
      - boolean
    doc: "Allows accession names of reads to mismatch in paired-end files"
    inputBinding:
      position: 101
      prefix: --allow-pe-name-mismatch
  - id: interleaved
    type:
      - 'null'
      - boolean
    doc: "Input is in interleaved format (one read per line, tab-delimited"
    inputBinding:
      position: 101
      prefix: --interleaved
  - id: gunzip
    type:
      - 'null'
      - boolean
    doc: "Uncompress gzipped input files"
    inputBinding:
      position: 101
      prefix: --gunzip
  - id: bunzip2
    type:
      - 'null'
      - boolean
    doc: "Uncompress bzip2-compressed input files"
    inputBinding:
      position: 101
      prefix: --bunzip2
  - id: batch
    type:
      - 'null'
      - int
    doc: "Batch mode (default = 5) Mode  Hash offsets  Hash positions  Genome          Local hash offsets  Local hash positions  Localdb 0   allocate      mmap            mmap            allocate            mmap                  mmap 1   allocate      mmap & preload  mmap            allocate            mmap & preload        mmap 2   allocate      mmap & preload  mmap & preload  allocate            mmap & preload        mmap 3   allocate      allocate        mmap & preload  allocate            allocate              mmap 4   allocate      allocate        allocate        allocate            allocate              mmap (default)    5   allocate      allocate        allocate        allocate            allocate              allocate Note: For a single sequence, all data structures use mmap A batch level of 5 means the same as 4, and is kept only for backward compatibility"
    inputBinding:
      position: 101
      prefix: --batch
  - id: use_shared_memory
    type:
      - 'null'
      - int
    doc: "If 1, then allocated memory is shared among all processes on this node If 0 (default), then each process has private allocated memory"
    inputBinding:
      position: 101
      prefix: --use-shared-memory
  - id: preload_shared_memory
    type:
      - 'null'
      - boolean
    doc: "Load files indicated by --batch mode into shared memory for use by other GMAP/GSNAP processes on this node, and then exit.  Ignore any input files."
    inputBinding:
      position: 101
      prefix: --preload-shared-memory
  - id: unload_shared_memory
    type:
      - 'null'
      - boolean
    doc: "Unload files indicated by --batch mode into shared memory, or allow them to be unloaded when existing GMAP/GSNAP processes on this node are finished with them.  Ignore any input files."
    inputBinding:
      position: 101
      prefix: --unload-shared-memory
  - id: max_mismatches
    type:
      - 'null'
      - float
    doc: "Maximum number of mismatches allowed (if not specified, then GSNAP tries to find the best possible match in the genome) If specified between 0.0 and 1.0, then treated as a fraction of each read length.  Otherwise, treated as an integral number of mismatches (including indel and splicing penalties). Default is 0.3"
    inputBinding:
      position: 101
      prefix: --max-mismatches
  - id: query_unk_mismatch
    type:
      - 'null'
      - int
    doc: "Whether to count unknown (N) characters in the query as a mismatch (0=no (default), 1=yes)"
    inputBinding:
      position: 101
      prefix: --query-unk-mismatch
  - id: genome_unk_mismatch
    type:
      - 'null'
      - int
    doc: "Whether to count unknown (N) characters in the genome as a mismatch (0=no, 1=yes).  If --use-mask is specified, default is no, otherwise yes."
    inputBinding:
      position: 101
      prefix: --genome-unk-mismatch
  - id: maxsearch
    type:
      - 'null'
      - int
    doc: "Maximum number of alignments to find (default 1000). Should be larger than --npaths, which is the number to report. Keeping this number large will allow for random selection among multiple alignments. Reducing this number can speed up the program."
    inputBinding:
      position: 101
      prefix: --maxsearch
  - id: indel_endlength
    type:
      - 'null'
      - int
    doc: "Minimum length at end required for indel alignments (default 4)"
    inputBinding:
      position: 101
      prefix: --indel-endlength
  - id: max_insertions
    type:
      - 'null'
      - int
    doc: "Maximum number of insertions allowed (default 6)"
    inputBinding:
      position: 101
      prefix: --max-insertions
  - id: max_deletions
    type:
      - 'null'
      - int
    doc: "Maximum number of deletions allowed (default 9)"
    inputBinding:
      position: 101
      prefix: --max-deletions
  - id: suboptimal_levels
    type:
      - 'null'
      - int
    doc: "Report suboptimal hits beyond best hit (default 0) All hits with best score plus suboptimal-levels are reported (Note: Not currently implemented)"
    inputBinding:
      position: 101
      prefix: --suboptimal-levels
  - id: adapter_strip
    type:
      - 'null'
      - string
    doc: "Method for removing adapters from reads.  Currently allowed values: off, paired. Default is \"off\".  To turn on, specify \"paired\", which removes adapters from paired-end reads if they appear to be present."
    inputBinding:
      position: 101
      prefix: --adapter-strip
  - id: use_mask
    type:
      - 'null'
      - string
    doc: "Use genome containing masks (e.g. for non-exons) for scoring preference"
    inputBinding:
      position: 101
      prefix: --use-mask
  - id: snpsdir
    type:
      - 'null'
      - Directory
    doc: "Directory for SNPs index files (created using snpindex) (default is location of genome index files specified using -D and -d)"
    inputBinding:
      position: 101
      prefix: --snpsdir
  - id: use_snps
    type:
      - 'null'
      - string
    doc: "Use database containing known SNPs (in <STRING>.iit, built previously using snpindex) for tolerance to SNPs"
    inputBinding:
      position: 101
      prefix: --use-snps
  - id: cmetdir
    type:
      - 'null'
      - Directory
    doc: "Directory for methylcytosine index files (created using cmetindex) (default is location of genome index files specified using -D, -V, and -d)"
    inputBinding:
      position: 101
      prefix: --cmetdir
  - id: atoidir
    type:
      - 'null'
      - Directory
    doc: "Directory for A-to-I RNA editing index files (created using atoiindex) (default is location of genome index files specified using -D, -V, and -d)"
    inputBinding:
      position: 101
      prefix: --atoidir
  - id: mode
    type:
      - 'null'
      - string
    doc: "Alignment mode: standard (default), cmet-stranded, cmet-nonstranded, atoi-stranded, atoi-nonstranded, ttoc-stranded, or ttoc-nonstranded. Non-standard modes requires you to have previously run the cmetindex or atoiindex programs (which also cover the ttoc modes) on the genome"
    inputBinding:
      position: 101
      prefix: --mode
  - id: nthreads
    type:
      - 'null'
      - int
    doc: "Number of worker threads"
    inputBinding:
      position: 101
      prefix: --nthreads
  - id: find_dna_chimeras
    type:
      - 'null'
      - int
    doc: "Look for distant splicing involving poor splice sites (0=no, 1=yes) If not specified, then default is to be on unless only known splicing is desired (--use-splicing is specified and --novelsplicing is off)"
    inputBinding:
      position: 101
      prefix: --find-dna-chimeras
  - id: novelsplicing
    type:
      - 'null'
      - int
    doc: "Look for novel splicing (0=no (default), 1=yes)"
    inputBinding:
      position: 101
      prefix: --novelsplicing
  - id: splicingdir
    type:
      - 'null'
      - string
    doc: "Directory for splicing involving known sites or known introns, as specified by the -s or --use-splicing flag (default is directory computed from -D and -d flags).  Note: can just give full pathname to the -s flag instead."
    inputBinding:
      position: 101
      prefix: --splicingdir
  - id: use_splicing
    type:
      - 'null'
      - string
    doc: "Look for splicing involving known sites or known introns (in <STRING>.iit), at short or long distances See README instructions for the distinction between known sites and known introns"
    inputBinding:
      position: 101
      prefix: --use-splicing
  - id: splices_noeval
    type:
      - 'null'
      - boolean
    doc: "Do not evaluate splices for probability or intron length, but depend only on sequence alignment"
    inputBinding:
      position: 101
      prefix: --splices-noeval
  - id: splices_dump
    type:
      - 'null'
      - File
    doc: "Write splice junction information to FILE, in the same format as for STAR plus MaxEnt probabilities for the two intron positions.  Note that in this dump file, the annotation column is reserved strictly for known introns, and not novel introns that passed some criterion from a first pass."
    inputBinding:
      position: 101
      prefix: --splices-dump
  - id: splices_exclude_known
    type:
      - 'null'
      - boolean
    doc: "In the file for --splices-dump, exclude all known introns"
    inputBinding:
      position: 101
      prefix: --splices-exclude-known
  - id: localsplicedist
    type:
      - 'null'
      - int
    doc: "Definition of local novel splicing event (default 200000)"
    inputBinding:
      position: 101
      prefix: --localsplicedist
  - id: merge_distant_samechr
    type:
      - 'null'
      - boolean
    doc: "Report distant splices on the same chromosome as a single splice, if possible. Will produce a single SAM line instead of two SAM lines, which is also done for translocations, inversions, and scramble events"
    inputBinding:
      position: 101
      prefix: --merge-distant-samechr
  - id: pairmax_dna
    type:
      - 'null'
      - int
    doc: "Max total genomic length for DNA-Seq paired reads, or other reads without splicing (default 2000).  Used if -N or -s is not specified. This value is also used for circular chromosomes when splicing in linear chromosomes is allowed"
    inputBinding:
      position: 101
      prefix: --pairmax-dna
  - id: pairmax_rna
    type:
      - 'null'
      - int
    doc: "Max total genomic length for RNA-Seq paired reads, or other reads that could have a splice (default 200000).  Used if -N or -s is specified. Should probably match the value for -w, --localsplicedist."
    inputBinding:
      position: 101
      prefix: --pairmax-rna
  - id: resolve_inner
    type:
      - 'null'
      - int
    doc: "Whether to resolve soft-clipping on the insides of paired-end reads (default 1)"
    inputBinding:
      position: 101
      prefix: --resolve-inner
  - id: pairexpect
    type:
      - 'null'
      - int
    doc: "Expected paired-end length, used for resolving soft-clipping on the insides of paired-end reads, and for pairing DNA-seq reads (default 200)"
    inputBinding:
      position: 101
      prefix: --pairexpect
  - id: pairdev
    type:
      - 'null'
      - int
    doc: "Allowable deviation from expected paired-end length, used for resolving soft-clipping on the insides of paired-end reads (default 100)."
    inputBinding:
      position: 101
      prefix: --pairdev
  - id: pass1_min_support
    type:
      - 'null'
      - int
    doc: "Threshold read support for learning an intron during pass 1 of --two-pass mode (default 20)"
    inputBinding:
      position: 101
      prefix: --pass1-min-support
  - id: quality_protocol
    type:
      - 'null'
      - string
    doc: "Protocol for input quality scores.  Allowed values: illumina (ASCII 64-126) (equivalent to -J 64 -j -31) sanger   (ASCII 33-126) (equivalent to -J 33 -j 0) Default is sanger (no quality print shift) SAM output files should have quality scores in sanger protocol Or you can customize this behavior with these flags:"
    inputBinding:
      position: 101
      prefix: --quality-protocol
  - id: quality_zero_score
    type:
      - 'null'
      - int
    doc: "FASTQ quality scores are zero at this ASCII value (default is 33 for sanger protocol; for Illumina, select 64)"
    inputBinding:
      position: 101
      prefix: --quality-zero-score
  - id: quality_print_shift
    type:
      - 'null'
      - int
    doc: "Shift FASTQ quality scores by this amount in output (default is 0 for sanger protocol; to change Illumina input to Sanger output, select -31)"
    inputBinding:
      position: 101
      prefix: --quality-print-shift
  - id: npaths
    type:
      - 'null'
      - int
    doc: "Maximum number of paths to print (default 100)."
    inputBinding:
      position: 101
      prefix: --npaths
  - id: quiet_if_excessive
    type:
      - 'null'
      - boolean
    doc: "If more than maximum number of paths are found, then nothing is printed."
    inputBinding:
      position: 101
      prefix: --quiet-if-excessive
  - id: ordered
    type:
      - 'null'
      - boolean
    doc: "Print output in same order as input (relevant only if there is more than one worker thread)"
    inputBinding:
      position: 101
      prefix: --ordered
  - id: show_refdiff
    type:
      - 'null'
      - boolean
    doc: "For GSNAP output in SNP-tolerant alignment, shows all differences relative to the reference genome as lower case (otherwise, it shows all differences relative to both the reference and alternate genome)"
    inputBinding:
      position: 101
      prefix: --show-refdiff
  - id: clip_overlap
    type:
      - 'null'
      - boolean
    doc: "For paired-end reads whose alignments overlap, clip the overlapping region."
    inputBinding:
      position: 101
      prefix: --clip-overlap
  - id: merge_overlap
    type:
      - 'null'
      - boolean
    doc: "For paired-end reads whose alignments overlap, merge the two ends into a single end (beta implementation)"
    inputBinding:
      position: 101
      prefix: --merge-overlap
  - id: print_snps
    type:
      - 'null'
      - boolean
    doc: "Print detailed information about SNPs in reads (works only if -v also selected) (not fully implemented yet)"
    inputBinding:
      position: 101
      prefix: --print-snps
  - id: failsonly
    type:
      - 'null'
      - boolean
    doc: "Print only failed alignments, those with no results"
    inputBinding:
      position: 101
      prefix: --failsonly
  - id: nofails
    type:
      - 'null'
      - boolean
    doc: "Exclude printing of failed alignments"
    inputBinding:
      position: 101
      prefix: --nofails
  - id: only_concordant
    type:
      - 'null'
      - boolean
    doc: "Print only concordant alignments (concordant_uniq, concordant_mult, concordant_circular)"
    inputBinding:
      position: 101
      prefix: --only-concordant
  - id: omit_concordant_uniq
    type:
      - 'null'
      - boolean
    doc: "Do not print any concordant_uniq alignments"
    inputBinding:
      position: 101
      prefix: --omit-concordant-uniq
  - id: omit_concordant_mult
    type:
      - 'null'
      - boolean
    doc: "Do not print any concordant_mult alignments"
    inputBinding:
      position: 101
      prefix: --omit-concordant-mult
  - id: omit_softclipped
    type:
      - 'null'
      - boolean
    doc: "Do not allow any alignments with soft clips"
    inputBinding:
      position: 101
      prefix: --omit-softclipped
  - id: only_tr_consistent
    type:
      - 'null'
      - boolean
    doc: "Print only alignments with consistent transcripts (XX field present, identical if paired-end)"
    inputBinding:
      position: 101
      prefix: --only-tr-consistent
  - id: format
    type:
      - 'null'
      - string
    doc: "Another format type, other than default. Currently implemented: sam, m8 (BLAST tabular format)"
    inputBinding:
      position: 101
      prefix: --format
  - id: split_output
    type:
      - 'null'
      - string
    doc: "Basename for multiple-file output, separately for nomapping, halfmapping_uniq, halfmapping_mult, unpaired_uniq, unpaired_mult, paired_uniq, paired_mult, concordant_uniq, and concordant_mult results"
    inputBinding:
      position: 101
      prefix: --split-output
  - id: output_file
    type:
      - 'null'
      - string
    doc: "File name for a single stream of output results."
    inputBinding:
      position: 101
      prefix: --output-file
  - id: failed_input
    type:
      - 'null'
      - string
    doc: "Print completely failed alignments as input FASTA or FASTQ format, to the given file, appending .1 or .2, for paired-end data. If the --split-output flag is also given, this file is generated in addition to the output in the .nomapping file."
    inputBinding:
      position: 101
      prefix: --failed-input
  - id: append_output
    type:
      - 'null'
      - boolean
    doc: "When --split-output or --failed-input is given, this flag will append output to the existing files.  Otherwise, the default is to create new files."
    inputBinding:
      position: 101
      prefix: --append-output
  - id: order_among_best
    type:
      - 'null'
      - string
    doc: "Among alignments tied with the best score, order those alignments in this order. Allowed values: genomic, random (default)"
    inputBinding:
      position: 101
      prefix: --order-among-best
  - id: output_buffer_size
    type:
      - 'null'
      - int
    doc: "Buffer size, in queries, for output thread (default 1000).  When the number of results to be printed exceeds this size, worker threads wait until the backlog is cleared"
    inputBinding:
      position: 101
      prefix: --output-buffer-size
  - id: no_sam_headers
    type:
      - 'null'
      - boolean
    doc: "Do not print headers beginning with '@'"
    inputBinding:
      position: 101
      prefix: --no-sam-headers
  - id: add_paired_nomappers
    type:
      - 'null'
      - boolean
    doc: "Add nomapper lines as needed to make all paired-end results alternate between first end and second end"
    inputBinding:
      position: 101
      prefix: --add-paired-nomappers
  - id: paired_flag_means_concordant
    type:
      - 'null'
      - int
    doc: "Whether the paired bit in the SAM flags means concordant only (1) or paired plus concordant (0, default)"
    inputBinding:
      position: 101
      prefix: --paired-flag-means-concordant
  - id: sam_headers_batch
    type:
      - 'null'
      - int
    doc: "Print headers only for this batch, as specified by -q"
    inputBinding:
      position: 101
      prefix: --sam-headers-batch
  - id: sam_hardclip_use_S
    type:
      - 'null'
      - boolean
    doc: "Use S instead of H for hardclips"
    inputBinding:
      position: 101
      prefix: --sam-hardclip-use-S
  - id: sam_use_0M
    type:
      - 'null'
      - int
    doc: "If 1 (default), then insert 0M in CIGAR between adjacent indels and introns If 0, do not allow 0M.  Picard disallows 0M, but other tools may require it"
    inputBinding:
      position: 101
      prefix: --sam-use-0M
  - id: sam_extended_cigar
    type:
      - 'null'
      - boolean
    doc: "Use extended CIGAR format (using X and = symbols instead of M, to indicate matches and mismatches, respectively"
    inputBinding:
      position: 101
      prefix: --sam-extended-cigar
  - id: sam_multiple_primaries
    type:
      - 'null'
      - boolean
    doc: "Allows multiple alignments to be marked as primary if they have equally good mapping scores"
    inputBinding:
      position: 101
      prefix: --sam-multiple-primaries
  - id: sam_sparse_secondaries
    type:
      - 'null'
      - boolean
    doc: "For secondary alignments (in multiple mappings), uses '*' for SEQ and QUAL fields, to give smaller file sizes.  However, the output will give warnings in Picard to give warnings and may not work with downstream tools"
    inputBinding:
      position: 101
      prefix: --sam-sparse-secondaries
  - id: force_xs_dir
    type:
      - 'null'
      - boolean
    doc: "For RNA-Seq alignments, disallows XS:A:? when the sense direction is unclear, and replaces this value arbitrarily with XS:A:+. May be useful for some programs, such as Cufflinks, that cannot handle XS:A:?.  However, if you use this flag, the reported value of XS:A:+ in these cases will not be meaningful."
    inputBinding:
      position: 101
      prefix: --force-xs-dir
  - id: md_report_snps
    type:
      - 'null'
      - boolean
    doc: "In MD string, when known SNPs are given by the -v flag, prints difference nucleotides when they differ from reference but match a known alternate allele"
    inputBinding:
      position: 101
      prefix: --md-report-snps
  - id: no_soft_clips
    type:
      - 'null'
      - boolean
    doc: "Does not allow soft clips at ends.  Mismatches will be counted over the entire query"
    inputBinding:
      position: 101
      prefix: --no-soft-clips
  - id: extend_soft_clips
    type:
      - 'null'
      - boolean
    doc: "Extends alignments through soft clipped regions.  CIGAR string and coordinates will be revised, but mismatches and the MD string will reflect the clipped CIGAR"
    inputBinding:
      position: 101
      prefix: --extend-soft-clips
  - id: action_if_cigar_error
    type:
      - 'null'
      - boolean
    doc: "Action to take if there is a disagreement between CIGAR length and sequence length Allowed values: ignore, warning (default), noprint, abort Note that the noprint option does not print the CIGAR string at all if there is an error, so it may break a SAM parser"
    inputBinding:
      position: 101
      prefix: --action-if-cigar-error
  - id: read_group_id
    type:
      - 'null'
      - string
    doc: "Value to put into read-group id (RG-ID) field"
    inputBinding:
      position: 101
      prefix: --read-group-id
  - id: read_group_name
    type:
      - 'null'
      - string
    doc: "Value to put into read-group name (RG-SM) field"
    inputBinding:
      position: 101
      prefix: --read-group-name
  - id: read_group_library
    type:
      - 'null'
      - string
    doc: "Value to put into read-group library (RG-LB) field"
    inputBinding:
      position: 101
      prefix: --read-group-library
  - id: read_group_platform
    type:
      - 'null'
      - string
    doc: "Value to put into read-group library (RG-PL) field"
    inputBinding:
      position: 101
      prefix: --read-group-platform
outputs:
  - id: output
    type: File
    doc: Alignments written to standard output (SAM unless another --format is chosen)
    outputBinding:
      glob: $(inputs.output_name)
  - id: split_files
    type: File[]
    doc: Files written when --split-output is used
    outputBinding:
      glob: $(inputs.split_output).*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gmap:2025.07.31--pl5321hb1d24b7_1
stdout: $(inputs.output_name)
