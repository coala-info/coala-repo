cwlVersion: v1.2
class: CommandLineTool
baseCommand: bismark
label: bismark
doc: "The Bismark bisulfite mapper and methylation caller takes in FastA or FastQ
  files and aligns the reads to a specified bisulfite genome. Sequence reads are transformed
  into a bisulfite converted forward strand version (C->T conversion) or into a bisulfite
  treated reverse strand (G->A conversion of the forward strand). Each of these reads
  are then aligned to bisulfite treated forward strand index of a reference genome
  (C->T converted) and a bisulfite treated reverse strand index of the genome (G->A
  conversion of the forward strand, by doing this alignments will produce the same
  positions). These 4 instances of Bowtie 2 or HISAT2 are run in parallel. The sequence
  file(s) are then read in again sequence by sequence to pull out the original sequence
  from the genome and determine if there were any protected C's present or not. The
  final output of Bismark is in BAM/SAM format by default.\n\nTool homepage: https://github.com/FelixKrueger/Bismark/"
inputs:
  - id: genome_folder
    type: Directory
    doc: "The path to the folder containing the unmodified reference genome as well
      as the subfolders created by the Bismark_Genome_Preparation script (/Bisulfite_Genome/CT_conversion/
      and /Bisulfite_Genome/GA_conversion/). Bismark expects one or more fastA files
      in this folder (file extension: .fa, .fa.gz or .fasta or .fasta.gz). The path
      can be relative or absolute. The path may also be set as '--genome_folder /path/to/genome/folder/'."
    inputBinding:
      position: 1
  - id: singles
    type:
      - 'null'
      - type: array
        items: File
    doc: A comma- or space-separated list of files containing the reads to be 
      aligned (e.g. lane1.fq,lane2.fq lane3.fq). Reads may be a mix of different
      lengths. Bismark will produce one mapping result and one report file per 
      input file. Please note that one should supply a list of files in 
      conjunction with --basename as the output files will constantly overwrite 
      each other...
    inputBinding:
      position: 2
  - id: ambiguous_bam
    type:
      - 'null'
      - boolean
    doc: For reads that have multiple alignments a random alignment is written 
      out to a special file ending in '.ambiguous.bam'. The alignments are in 
      Bowtie2 format and do not any contain Bismark specific entries such as the
      methylation call etc. These ambiguous BAM files are intended to be used as
      coverage estimators for variant callers.
    inputBinding:
      position: 103
      prefix: --ambig_bam
  - id: ambiguous_reads
    type:
      - 'null'
      - boolean
    doc: Write all reads which produce more than one valid alignment with the 
      same number of lowest mismatches or other reads that fail to align 
      uniquely to a file in the output directory. Written reads will appear as. 
      they did in the input, without any of the translation of quality values 
      that may have taken place within Bowtie or Bismark. Paired-end reads will 
      be written to two parallel files with _1 and _2 inserted in their 
      filenames, i.e. _ambiguous_reads_1.txt and _ambiguous_reads_2.txt. These 
      reads are not written to the file specified with --un.
    inputBinding:
      position: 103
      prefix: --ambiguous
  - id: basename
    type:
      - 'null'
      - string
    doc: Write all output to files starting with this base file name. For 
      example, '--basename foo' would result in the files 'foo.bam' and 
      'foo_SE_report.txt' (or its paired-end equivalent). Takes precedence over 
      --prefix. Be advised that you should not use this option in conjunction 
      with supplying lists of files to be processed consecutively, as all output
      files will constantly overwrite each other.
    inputBinding:
      position: 103
      prefix: --basename
  - id: bowtie2_aligner
    type:
      - 'null'
      - boolean
    doc: Uses Bowtie 2 as default aligner. Bismark limits Bowtie 2 to only 
      perform end-to-end alignments, i.e. searches for alignments involving all 
      read characters (also called untrimmed or unclipped alignments). Bismark 
      assumes that raw sequence data is adapter and/or quality trimmed where 
      appropriate. Both small (.bt2) and large (.bt2l) Bowtie 2 indexes are 
      supported. To use HISAT2 instead of Bowtie 2 please see option --hisat2.
    inputBinding:
      position: 103
      prefix: --bowtie2
  - id: bowtie2_reseeding_attempts
    type:
      - 'null'
      - int
    doc: <int> is the maximum number of times Bowtie 2 will "re-seed" reads with
      repetitive seeds. When "re-seeding," Bowtie 2 simply chooses a new set of 
      reads (same length, same number of mismatches allowed) at different 
      offsets and searches for more alignments. A read is considered to have 
      repetitive seeds if the total number of seed hits divided by the number of
      seeds that aligned at least once is greater than 300.
    inputBinding:
      position: 103
      prefix: -R
  - id: bowtie2_seed_extension_attempts
    type:
      - 'null'
      - int
    doc: Up to <int> consecutive seed extension attempts can "fail" before 
      Bowtie 2 moves on, using the alignments found so far. A seed extension 
      "fails" if it does not yield a new best or a new second-best alignment.
    inputBinding:
      position: 103
      prefix: -D
  - id: bowtie2_threads
    type:
      - 'null'
      - int
    doc: "Launch NTHREADS parallel search threads (default: 1). Threads will run on
      separate processors/cores and synchronize when parsing reads and outputting
      alignments. Searching for alignments is highly parallel, and speedup is close
      to linear. Increasing -p increases Bowtie 2's memory footprint. E.g. when aligning
      to a human genome index, increasing -p from 1 to 8 increases the memory footprint
      by a few hundred megabytes. This option is only available if Bowtie 2 is linked
      with the pthreads library (i.e. if BOWTIE_PTHREADS=0 is not specified at build
      time). In addition, this option will automatically use the option '--reorder',
      which guarantees that output SAM records are printed in an order corresponding
      to the order of the reads in the original input file, even when -p is set greater
      than 1 (Bismark requires the Bowtie 2 output to be this way). Specifying --reorder
      and setting -p greater than 1 causes Bowtie 2 to run somewhat slower and use
      somewhat more memory then if --reorder were not specified. Has no effect if
      -p is set to 1, since output order will naturally correspond to input order
      in that case."
    inputBinding:
      position: 103
      prefix: -p
  - id: cram_reference
    type:
      - 'null'
      - File
    doc: CRAM output requires you to specify a reference genome as a single 
      FastA file. If this single-FastA reference file is not supplied explicitly
      it will be regenerated from the genome .fa sequence(s) used for the 
      Bismark run and written to a file called 
      'Bismark_genome_CRAM_reference.mfa' into the oputput directory.
    inputBinding:
      position: 103
      prefix: --cram_ref
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: The query input files (specified as <mate1>,<mate2> or <singles> are 
      FASTA files (usually having extensions .fa, .mfa, .fna or similar). All 
      quality values are assumed to be 40 on the Phred scale. FASTA files are 
      expected to contain both the read name and the sequence on a single line 
      (and not spread over several lines).
    inputBinding:
      position: 103
      prefix: --fasta
  - id: fastq
    type:
      - 'null'
      - boolean
    doc: The query input files (specified as <mate1>,<mate2> or <singles> are 
      FASTQ files (usually having extension .fg or .fastq). This is the default.
      See also --solexa-quals.
    inputBinding:
      position: 103
      prefix: --fastq
  - id: gzip_compressed_temp
    type:
      - 'null'
      - boolean
    doc: Temporary bisulfite conversion files will be written out in a GZIP 
      compressed form to save disk space. This option is available for most 
      alignment modes but is not available for paired-end FastA files. This 
      option might be somewhat slower than writing out uncompressed files, but 
      this awaits further testing.
    inputBinding:
      position: 103
      prefix: --gzip
  - id: hisat2_aligner
    type:
      - 'null'
      - boolean
    doc: Uses HISAT2 instead of Bowtie 2. Bismark uses HISAT2 in end-to-end mode
      by default, i.e. searches for alignments involving all read characters 
      (also called untrimmed or unclipped alignments) using the option 
      '--no-softclipping'. Bismark assumes that raw sequence data is adapter 
      and/or quality trimmed where appropriate. From v0.22.0 onwards, Bismark 
      also supports the local alignment mode of HISAT2 (please see --local). 
      Both small (.ht2) and large (.ht2l) HISAT2 indexes are supported.
    inputBinding:
      position: 103
      prefix: --hisat2
  - id: icpc
    type:
      - 'null'
      - boolean
    doc: "This option will truncate read IDs at the first space or tab it encounters,
      which are sometimes used to add comments to a FastQ entry (instead of replacing
      them with underscores (_) as is the default behaviour). The opion is deliberately
      somewhat cryptic (\"I couldn't possibly comment\"), as it only becomes relevant
      when R1 and R2 of read pairs are mapped separately in single-end mode, and then
      re-paired afterwards (the SAM format dictates that R1 and R2 have the same read
      ID). Paired-end mapping already creates BAM files with identical read IDs. For
      more information please see here: https://github.com/FelixKrueger/Bismark/issues/236.
      Default: OFF."
    inputBinding:
      position: 103
      prefix: --icpc
  - id: ignore_quals
    type:
      - 'null'
      - boolean
    doc: When calculating a mismatch penalty, always consider the quality value 
      at the mismatched position to be the highest possible, regardless of the 
      actual value. I.e. input is treated as though all quality values are high.
      This is also the default behavior when the input doesn't specify quality 
      values (e.g. in -f mode). This option is invariable and on by default.
    inputBinding:
      position: 103
      prefix: --ignore-quals
  - id: known_splice_sites_file
    type:
      - 'null'
      - File
    doc: Provide a list of known splice sites.
    inputBinding:
      position: 103
      prefix: --known-splicesite-infile
  - id: local_alignment
    type:
      - 'null'
      - boolean
    doc: 'In this mode, it is not required that the entire read aligns from one end
      to the other. Rather, some characters may be omitted (“soft-clipped”) from the
      ends in order to achieve the greatest possible alignment score. For Bowtie 2,
      the match bonus --ma (default: 2) is used in this mode, and the best possible
      alignment score is equal to the match bonus (--ma) times the length of the read.
      This is mutually exclusive with end-to-end alignments. For HISAT2, it is currently
      not exactly known how the best alignment is calculated.'
    inputBinding:
      position: 103
      prefix: --local
  - id: mates1
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Comma-separated list of files containing the #1 mates (filename usually
      includes "_1"), e.g. flyA_1.fq,flyB_1.fq). Sequences specified with this option
      must correspond file-for-file and read-for-read with those specified in <mates2>.
      Reads may be a mix of different lengths. Bismark will produce one mapping result
      and one report file per paired-end input file pair.'
    inputBinding:
      position: 103
      prefix: '-1'
  - id: mates2
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Comma-separated list of files containing the #2 mates (filename usually
      includes "_2"), e.g. flyA_2.fq,flyB_2.fq). Sequences specified with this option
      must correspond file-for-file and read-for-read with those specified in <mates1>.
      Reads may be a mix of different lengths.'
    inputBinding:
      position: 103
      prefix: '-2'
  - id: max_insert_size
    type:
      - 'null'
      - int
    doc: The maximum insert size for valid paired-end alignments. E.g. if -X 100
      is specified and a paired-end alignment consists of two 20-bp alignments 
      in the proper orientation with a 60-bp gap between them, that alignment is
      considered valid (as long as -I is also satisfied). A 61-bp gap would not 
      be valid in that case.
    inputBinding:
      position: 103
      prefix: --maxins
  - id: min_insert_size
    type:
      - 'null'
      - int
    doc: The minimum insert size for valid paired-end alignments. E.g. if -I 60 
      is specified and a paired-end alignment consists of two 20-bp alignments 
      in the appropriate orientation with a 20-bp gap between them, that 
      alignment is considered valid (as long as -X is also satisfied). A 19-bp 
      gap would not be valid in that case.
    inputBinding:
      position: 103
      prefix: --minins
  - id: minimap2_aligner
    type:
      - 'null'
      - boolean
    doc: "Uses minimap2 as the underlying read aligner. This mode is very new and
      currently experimental. Expect that things may change in the near future. The
      default mapping mode is --nanopore (preset '-x map-ont' (Nanopore reads)). Currently,
      there are no plans to support PacBio reads. Internally, minimap2 is run with
      the options -a --MD. More information here: https://lh3.github.io/minimap2/minimap2.html."
    inputBinding:
      position: 103
      prefix: --minimap2
  - id: minimap2_max_length
    type:
      - 'null'
      - int
    doc: Maximum length cutoff for very long sequences (currently allowed 
      100-100,000 bp).
    inputBinding:
      position: 103
      prefix: --mm2_maximum_length
  - id: minimap2_nanopore
    type:
      - 'null'
      - boolean
    doc: Using the minimap2 preset for Oxford Nanopore (ONT) vs reference 
      mapping (-x map-ont). Only works in conjuntion with --minimap2.
      qualifiers.
    inputBinding:
      position: 103
      prefix: --mm2_nanopore
  - id: minimap2_pacbio
    type:
      - 'null'
      - boolean
    doc: Using the minimap2 preset for PacBio vs reference mapping (-x map-pb). 
      Only works in conjuntion with --minimap2.
    inputBinding:
      position: 103
      prefix: --mm2_pacbio
  - id: minimap2_short_reads
    type:
      - 'null'
      - boolean
    doc: "This option invokes the minmap2 preset setting '-x sr' and is intended for
      genomic short-read mapping with accurate reads (probably Illumina 150bp+ ?).
      For spliced short-reads, please use --hisat2 instead. The 'sr' preset mode (short
      single-end reads without splicing) uses the following options: -k21 -w11 --sr
      --frag=yes -A2 -B8 -O12,32 -E2,1 -r50 -p.5 -N20 -f1000,5000 -n2 -m20 -s40 -g200
      -2K50m --heap-sort=yes --secondary=no"
    inputBinding:
      position: 103
      prefix: --mm2_short_reads
  - id: mismatches
    type:
      - 'null'
      - int
    doc: 'Sets the number of mismatches to allowed in a seed alignment during multiseed
      alignment. Can be set to 0 or 1. Setting this higher makes alignment slower
      (often much slower) but increases sensitivity. Default: 0. This option is only
      available for Bowtie 2 (for Bowtie 1 see -n).'
    inputBinding:
      position: 103
      prefix: -N
  - id: multicore
    type:
      - 'null'
      - int
    doc: Sets the number of parallel instances of Bismark to be run 
      concurrently. (See --parallel)
    inputBinding:
      position: 103
      prefix: --multicore
  - id: no_discordant_alignments
    type:
      - 'null'
      - boolean
    doc: Normally, Bowtie 2 or HISAT2 look for discordant alignments if it 
      cannot find any concordant alignments. A discordant alignment is an 
      alignment where both mates align uniquely, but that does not satisfy the 
      paired-end constraints (--fr/--rf/--ff, -I, -X). This option disables that
      behavior and it is on by default.
    inputBinding:
      position: 103
      prefix: --no-discordant
  - id: no_dovetail
    type:
      - 'null'
      - boolean
    doc: "It is possible, though unusual, for the mates to \"dovetail\", with the
      mates seemingly extending \"past\" each other as in this example: Mate 1: GTCAGCTACGATATTGTTTGGGGTGACACATTACGC
      Mate 2: TATGAGTCAGCTACGATATTGTTTGGGGTGACACAT Reference: GCAGATTATATGAGTCAGCTACGATATTGTTTGGGGTGACACATTACGCGTCTTTGAC
      By default, dovetailing is considered inconsistent with concordant alignment,
      but by default Bismark calls Bowtie 2 with --dovetail, causing it to consider
      dovetailing alignments as concordant. This becomes relevant whenever reads are
      clipped from their 5' end prior to mapping, e.g. because of quality or bias
      issues. Specify --no_dovetail to turn off this behaviour for paired-end libraries."
    inputBinding:
      position: 103
      prefix: --no_dovetail
  - id: no_mixed_alignments
    type:
      - 'null'
      - boolean
    doc: This option disables the behavior to try to find alignments for the 
      individual mates if it cannot find a concordant or discordant alignment 
      for a pair. This option is invariably on by default.
    inputBinding:
      position: 103
      prefix: --no-mixed
  - id: no_spliced_alignment
    type:
      - 'null'
      - boolean
    doc: Disable spliced alignment.
    inputBinding:
      position: 103
      prefix: --no-spliced-alignment
  - id: non_bs_mismatches
    type:
      - 'null'
      - boolean
    doc: Optionally, outputs an extra column specifying the number of 
      non-bisulfite mismatches a read has. This option is only available in 
      end-to-end mode. The value is just the number of actual non-bisulfite 
      mismatches and ignores potential insertions or deletions. The format for 
      single-end reads and read 1 of paired-end reads is 'XA:Z:number of 
      mismatches' and 'XB:Z:number of mismatches' for read 2 of paired-end 
      reads.
    inputBinding:
      position: 103
      prefix: --non_bs_mm
  - id: non_directional
    type:
      - 'null'
      - boolean
    doc: The sequencing library was constructed in a non strand-specific manner,
      alignments to all four bisulfite strands will be reported. (The current 
      Illumina protocol for BS-Seq is directional, in which case the strands 
      complementary to the original strands are merely theoretical and should 
      not exist in reality. Specifying directional alignments (which is the 
      default) will only run 2 alignment threads to the original top (OT) or 
      bottom (OB) strands in parallel and report these alignments. This is the 
      recommended option for sprand-specific libraries).
    inputBinding:
      position: 103
      prefix: --non_directional
  - id: nucleotide_coverage
    type:
      - 'null'
      - boolean
    doc: Calculates the mono- and di-nucleotide sequence composition of covered 
      positions in the analysed BAM file and compares it to the genomic average 
      composition once alignments are complete by calling 'bam2nuc'. Since this 
      calculation may take a while, bam2nuc attempts to write the genomic 
      sequence composition into a file called 
      'genomic_nucleotide_frequencies.txt' indside the reference genome folder 
      so it can be re-used the next time round instead of calculating it once 
      again. If a file 'nucleotide_stats.txt' is found with the Bismark reports 
      it will be automatically detected and used for the Bismark HTML report. 
      This option works only for BAM or CRAM files.
    inputBinding:
      position: 103
      prefix: --nucleotide_coverage
  - id: old_flag_paired_end
    type:
      - 'null'
      - boolean
    doc: Only in paired-end SAM mode, uses the FLAG values used by Bismark 
      v0.8.2 and before. In addition, this options appends /1 and /2 to the read
      IDs for reads 1 and 2 relative to the input file. Since both the appended 
      read IDs and custom FLAG values may cause problems with some downstream 
      tools such as Picard, new defaults were implemented as of version 0.8.3.
    inputBinding:
      position: 103
      prefix: --old_flag
  - id: output_bam
    type:
      - 'null'
      - boolean
    doc: Bismark will attempt to use the path to Samtools that was specified 
      with '--samtools_path', or, if it hasn't been specified, attempt to find 
      Samtools in the PATH. If no installation of Samtools can be found, the SAM
      output will be compressed with GZIP instead (yielding a .sam.gz output 
      file).
    inputBinding:
      position: 103
      prefix: --bam
  - id: output_cram
    type:
      - 'null'
      - boolean
    doc: Writes the output to a CRAM file instead of BAM. This requires the use 
      of Samtools 1.2 or higher.
    inputBinding:
      position: 103
      prefix: --cram
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Prefixes <prefix> to the output filenames. Trailing dots will be 
      replaced by a single one. For example, '--prefix test' with 'file.fq' 
      would result in the output file 'test.file.fq_bismark.sam' etc.
    inputBinding:
      position: 103
      prefix: --prefix
  - id: output_sam
    type:
      - 'null'
      - boolean
    doc: The output will be written out in SAM format instead of the default BAM
      format. Be warned that this requires ~10 times more disk space. --sam is 
      not compatible with the option --parallel.
    inputBinding:
      position: 103
      prefix: --sam
  - id: parallel_instances
    type:
      - 'null'
      - int
    doc: '(May also be --multicore <int>) Sets the number of parallel instances of
      Bismark to be run concurrently. This forks the Bismark alignment step very early
      on so that each individual Spawn of Bismark processes only every n-th sequence
      (n being set by --parallel). Once all processes have completed, the individual
      BAM files, mapping reports, unmapped or ambiguous FastQ files are merged into
      single files in very much the same way as they would have been generated running
      Bismark conventionally with only a single instance. If system resources are
      plentiful this is a viable option to speed up the alignment process (we observed
      a near linear speed increase for up to --parallel 8 tested). However, please
      note that a typical Bismark run will use several cores already (Bismark itself,
      2 or 4 threads of Bowtie2/HISAT2, Samtools, gzip etc...) and ~10-16GB of memory
      depending on the choice of aligner and genome. WARNING: Bismark Parallel (BP?)
      is resource hungry! Each value of --parallel specified will effectively lead
      to a linear increase in compute and memory requirements, so --parallel 4 for
      e.g. the GRCm38 mouse genome will probably use ~20 cores and eat ~40GB or RAM,
      but at the same time reduce the alignment time to ~25-30%. You have been warned.'
    inputBinding:
      position: 103
      prefix: --parallel
  - id: path_to_bowtie2
    type:
      - 'null'
      - Directory
    doc: The full path </../../> to the Bowtie 2 installation folder on your 
      system (not the bowtie2 executable itself). If not specified, it is 
      assumed that Bowtie 2 is in the PATH.
    inputBinding:
      position: 103
      prefix: --path_to_bowtie2
  - id: path_to_hisat2
    type:
      - 'null'
      - Directory
    doc: The full path </../../> to the HISAT2 installation folder on your 
      system (not the hisat2 executable itself). If not specified, it is assumed
      that HISAT2 is in the PATH.
    inputBinding:
      position: 103
      prefix: --path_to_hisat2
  - id: path_to_minimap2
    type:
      - 'null'
      - Directory
    doc: The full path </../../> to the minimap2 installation folder on your 
      system (not the minimap2 executable itself). If not specified, it is 
      assumed that minimap2 is in the PATH.
    inputBinding:
      position: 103
      prefix: --path_to_minimap2
  - id: pbat
    type:
      - 'null'
      - boolean
    doc: This options may be used for PBAT-Seq libraries (Post-Bisulfite Adapter
      Tagging; Kobayashi et al., PLoS Genetics, 2012). This is essentially the 
      exact opposite of alignments in 'directional' mode, as it will only launch
      two alignment threads to the CTOT and CTOB strands instead of the normal 
      OT and OB ones. Use this option only if you are certain that your 
      libraries were constructed following a PBAT protocol (if you don't know 
      what PBAT-Seq is you should not specify this option). The option --pbat 
      works only for FastQ files (in both Bowtie and Bowtie 2 mode) and using 
      uncompressed temporary files only).
    inputBinding:
      position: 103
      prefix: --pbat
  - id: phred33_quals
    type:
      - 'null'
      - boolean
    doc: FASTQ qualities are ASCII chars equal to the Phred quality plus 33.
    inputBinding:
      position: 103
      prefix: --phred33-quals
  - id: phred64_quals
    type:
      - 'null'
      - boolean
    doc: FASTQ qualities are ASCII chars equal to the Phred quality plus 64.
    inputBinding:
      position: 103
      prefix: --phred64-quals
  - id: read_gap_penalties
    type:
      - 'null'
      - string
    doc: Sets the read gap open (<int1>) and extend (<int2>) penalties. A read 
      gap of length N gets a penalty of <int1> + N * <int2>.
    inputBinding:
      position: 103
      prefix: --rdg
  - id: read_group_id
    type:
      - 'null'
      - string
    doc: Sets the ID field in the @RG header line.
    inputBinding:
      position: 103
      prefix: --rg_id
  - id: read_group_sample
    type:
      - 'null'
      - string
    doc: Sets the SM field in the @RG header line; can't be set without setting 
      --rg_id as well.
    inputBinding:
      position: 103
      prefix: --rg_sample
  - id: read_group_tag
    type:
      - 'null'
      - boolean
    doc: 'Write out a Read Group tag to the resulting SAM/BAM file. This will write
      the following line to the SAM header: @RG PL: ILLUMINA ID:SAMPLE SM:SAMPLE ;
      to set ID and SM see --rg_id and --rg_sample. In addition each read receives
      an RG:Z:RG-ID tag.'
    inputBinding:
      position: 103
      prefix: --rg_tag
  - id: reference_gap_penalties
    type:
      - 'null'
      - string
    doc: Sets the reference gap open (<int1>) and extend (<int2>) penalties. A 
      reference gap of length N gets a penalty of <int1> + N * <int2>.
    inputBinding:
      position: 103
      prefix: --rfg
  - id: sam_no_header
    type:
      - 'null'
      - boolean
    doc: Suppress SAM header lines (starting with @). This might be useful when 
      very large input files are split up into several smaller files to run 
      concurrently and the output files are to be merged.
    inputBinding:
      position: 103
      prefix: --sam-no-hd
  - id: samtools_path
    type:
      - 'null'
      - Directory
    doc: The path to your Samtools installation, e.g. /home/user/samtools/. Does
      not need to be specified explicitly if Samtools is in the PATH already.
    inputBinding:
      position: 103
      prefix: --samtools_path
  - id: score_min_function
    type:
      - 'null'
      - string
    doc: 'Sets a function governing the minimum alignment score needed for an alignment
      to be considered "valid" (i.e. good enough to report). This is a function of
      read length. In end-to-end mode (default), and --local mode for HISAT2 only,
      --score_min is set as a linear function and is set as <L,value,value>. For instance,
      specifying L,0,-0.2 sets the minimum-score function f to f(x) = 0 + (-0.2) *
      x, where x is the read length. The default for end-to-end (global) alignments
      is: L,0,-0.2. In --local mode for Bowtie 2, the function is logarithmic and
      is set as <G,value,value>. For instance, specifying G,20,8 sets the minimum-score
      function f to f(x) = 20 + 8 * ln(x), where x is the read length. The default
      is for local alignments in Bowtie 2 mode is: G,20,8. See also: setting function
      options at http://bowtie-bio.sourceforge.net/bowtie2.'
    inputBinding:
      position: 103
      prefix: --score_min
  - id: seed_length
    type:
      - 'null'
      - int
    doc: 'Sets the length of the seed substrings to align during multiseed alignment.
      Smaller values make alignment slower but more senstive. Default: the --sensitive
      preset of Bowtie 2 is used by default, which sets -L to 20. maximum of L can
      be set to 32. The length of the seed would effect the alignment speed dramatically
      while the larger L, the faster the aligment. This option is only available for
      Bowtie 2 (for Bowtie 1 see -l).'
    inputBinding:
      position: 103
      prefix: -L
  - id: single_end_list
    type:
      - 'null'
      - type: array
        items: File
    doc: giving a list of file names as <list>. The filenames may be provided as
      a comma [,] or colon [:] separated list.
    inputBinding:
      position: 103
      prefix: --single_end
  - id: single_end_mode
    type:
      - 'null'
      - boolean
    doc: Sets single-end mapping mode explicitly
    inputBinding:
      position: 103
      prefix: --se
  - id: skip_reads
    type:
      - 'null'
      - int
    doc: Skip (i.e. do not align) the first <int> reads or read pairs from the 
      input.
    inputBinding:
      position: 103
      prefix: --skip
  - id: strand_id
    type:
      - 'null'
      - boolean
    doc: "For non-directional paired-end libraries, the strands identity is encoded
      by the order in which R1 and R2 are reported, as well as the read and genome
      conversion state. If third party tools re-organise this order it may become
      difficult to determine the alignment strand identity. This option adds an optional
      tag, e.g. 'YS:Z:OT' or 'YS:Z:CTOB' to preserve this information. See also this
      thread for more details: https://github.com/FelixKrueger/Bismark/issues/455."
    inputBinding:
      position: 103
      prefix: --strandID
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: Write temporary files to this directory instead of into the same 
      directory as the input files. If the specified folder does not exist, 
      Bismark will attempt to create it first. The path to the temporary folder 
      can be either relative or absolute.
    inputBinding:
      position: 103
      prefix: --temp_dir
  - id: unmapped_reads
    type:
      - 'null'
      - boolean
    doc: Write all reads that could not be aligned to a file in the output 
      directory. Written reads will appear as they did in the input, without any
      translation of quality values that may have taken place within Bowtie or 
      Bismark. Paired-end reads will be written to two parallel files with _1 
      and _2 inserted in their filenames, i.e. _unmapped_reads_1.txt and 
      unmapped_reads_2.txt. Reads with more than one valid alignment with the 
      same number of lowest mismatches (ambiguous mapping) are also written to 
      _unmapped_reads.txt unless the option --ambiguous is specified as well.
    inputBinding:
      position: 103
      prefix: --unmapped
  - id: upto_reads
    type:
      - 'null'
      - int
    doc: Only aligns the first <int> reads or read pairs from the input.
    inputBinding:
      position: 103
      prefix: --upto
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Write all output files into this directory. By default the output files
      will be written into the same folder as the input file(s). If the 
      specified folder does not exist, Bismark will attempt to create it first. 
      The path to the output folder can be either relative or absolute.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bismark:0.25.1--hdfd78af_0
