cwlVersion: v1.2
class: CommandLineTool
baseCommand: STAR
label: rna-star_STAR
doc: "Spliced Transcripts Alignment to a Reference\n\nTool homepage: https://github.com/alexdobin/STAR"
inputs:
  - id: align_ends_protrude
    type:
      - 'null'
      - type: array
        items: string
    doc: "allow protrusion of alignment ends, i.e. start (end) of the +strand mate
      downstream of the start (end) of the -strand mate\n                        1st
      word: int: maximum number of protrusion bases allowed\n                    \
      \    2nd word: string: \n                                            ConcordantPair
      ... report alignments with non-zero protrusion as concordant pairs\n       \
      \                                     DiscordantPair ... report alignments with
      non-zero protrusion as discordant pairs"
    inputBinding:
      position: 101
      prefix: --alignEndsProtrude
  - id: align_ends_type
    type:
      - 'null'
      - string
    doc: "type of read ends alignment\n                        Local             ...
      standard local alignment with soft-clipping allowed\n                      \
      \  EndToEnd          ... force end-to-end read alignment, do not soft-clip\n\
      \                        Extend5pOfRead1   ... fully extend only the 5p of the
      read1, all other ends: local alignment\n                        Extend5pOfReads12
      ... fully extend only the 5p of the both read1 and read2, all other ends: local
      alignment"
    inputBinding:
      position: 101
      prefix: --alignEndsType
  - id: align_insertion_flush
    type:
      - 'null'
      - string
    doc: "how to flush ambiguous insertion positions\n                        None\
      \    ... insertions are not flushed\n                        Right   ... insertions
      are flushed to the right"
    inputBinding:
      position: 101
      prefix: --alignInsertionFlush
  - id: align_intron_max
    type:
      - 'null'
      - int
    doc: maximum intron size, if 0, max intron size will be determined by 
      (2^winBinNbits)*winAnchorDistNbins
    inputBinding:
      position: 101
      prefix: --alignIntronMax
  - id: align_intron_min
    type:
      - 'null'
      - int
    doc: 'minimum intron size: genomic gap is considered intron if its length>=alignIntronMin,
      otherwise it is considered Deletion'
    inputBinding:
      position: 101
      prefix: --alignIntronMin
  - id: align_mates_gap_max
    type:
      - 'null'
      - int
    doc: maximum gap between two mates, if 0, max intron gap will be determined 
      by (2^winBinNbits)*winAnchorDistNbins
    inputBinding:
      position: 101
      prefix: --alignMatesGapMax
  - id: align_sj_overhang_min
    type:
      - 'null'
      - int
    doc: minimum overhang (i.e. block size) for spliced alignments
    inputBinding:
      position: 101
      prefix: --alignSJoverhangMin
  - id: align_sj_stitch_mismatch_nmax
    type:
      - 'null'
      - type: array
        items: int
    doc: "4*int>=0: maximum number of mismatches for stitching of the splice junctions
      (-1: no limit).\n                            (1) non-canonical motifs, (2) GT/AG
      and CT/AC motif, (3) GC/AG and CT/GC motif, (4) AT/AC and GT/AT motif."
    inputBinding:
      position: 101
      prefix: --alignSJstitchMismatchNmax
  - id: align_sjdb_overhang_min
    type:
      - 'null'
      - int
    doc: minimum overhang (i.e. block size) for annotated (sjdb) spliced 
      alignments
    inputBinding:
      position: 101
      prefix: --alignSJDBoverhangMin
  - id: align_soft_clip_at_reference_ends
    type:
      - 'null'
      - string
    doc: "allow the soft-clipping of the alignments past the end of the chromosomes\n\
      \                                Yes ... allow\n                           \
      \     No  ... prohibit, useful for compatibility with Cufflinks"
    inputBinding:
      position: 101
      prefix: --alignSoftClipAtReferenceEnds
  - id: align_spliced_mate_map_lmin
    type:
      - 'null'
      - int
    doc: '>0: minimum mapped length for a read mate that is spliced'
    inputBinding:
      position: 101
      prefix: --alignSplicedMateMapLmin
  - id: align_spliced_mate_map_lmin_over_lmate
    type:
      - 'null'
      - float
    doc: '>0: alignSplicedMateMapLmin normalized to mate length'
    inputBinding:
      position: 101
      prefix: --alignSplicedMateMapLminOverLmate
  - id: align_transcripts_per_read_nmax
    type:
      - 'null'
      - int
    doc: '>0: max number of different alignments per read to consider'
    inputBinding:
      position: 101
      prefix: --alignTranscriptsPerReadNmax
  - id: align_transcripts_per_window_nmax
    type:
      - 'null'
      - int
    doc: '>0: max number of transcripts per window'
    inputBinding:
      position: 101
      prefix: --alignTranscriptsPerWindowNmax
  - id: align_windows_per_read_nmax
    type:
      - 'null'
      - int
    doc: '>0: max number of windows per read'
    inputBinding:
      position: 101
      prefix: --alignWindowsPerReadNmax
  - id: bam_remove_duplicates_mate2bases_n
    type:
      - 'null'
      - int
    doc: ">0: number of bases from the 5' of mate 2 to use in collapsing (e.g. for
      RAMPAGE)"
    inputBinding:
      position: 101
      prefix: --bamRemoveDuplicatesMate2basesN
  - id: bam_remove_duplicates_type
    type:
      - 'null'
      - string
    doc: "mark duplicates in the BAM file, for now only works with (i) sorted BAM
      fed with inputBAMfile, and (ii) for paired-end alignments only\n           \
      \             -                       ... no duplicate removal/marking\n   \
      \                     UniqueIdentical         ... mark all multimappers, and
      duplicate unique mappers. The coordinates, FLAG, CIGAR must be identical\n \
      \                       UniqueIdenticalNotMulti  ... mark duplicate unique mappers
      but not multimappers. The coordinates, FLAG, CIGAR must be identical"
    inputBinding:
      position: 101
      prefix: --bamRemoveDuplicatesType
  - id: chim_filter
    type:
      - 'null'
      - type: array
        items: string
    doc: "different filters for chimeric alignments\n                            None
      ... no filtering\n                            banGenomicN ... Ns are not allowed
      in the genome sequence around the chimeric junction"
    inputBinding:
      position: 101
      prefix: --chimFilter
  - id: chim_junction_overhang_min
    type:
      - 'null'
      - int
    doc: '>=0: minimum overhang for a chimeric junction'
    inputBinding:
      position: 101
      prefix: --chimJunctionOverhangMin
  - id: chim_main_segment_mult_nmax
    type:
      - 'null'
      - int
    doc: '>=1: maximum number of multi-alignments for the main chimeric segment. =1
      will prohibit multimapping main segments.'
    inputBinding:
      position: 101
      prefix: --chimMainSegmentMultNmax
  - id: chim_multimap_nmax
    type:
      - 'null'
      - int
    doc: ">=0: maximum number of chimeric multi-alignments\n                     \
      \           0 ... use the old scheme for chimeric detection which only considered
      unique alignments"
    inputBinding:
      position: 101
      prefix: --chimMultimapNmax
  - id: chim_multimap_score_range
    type:
      - 'null'
      - int
    doc: '>=0: the score range for multi-mapping chimeras below the best chimeric
      score. Only works with --chimMultimapNmax > 1'
    inputBinding:
      position: 101
      prefix: --chimMultimapScoreRange
  - id: chim_nonchim_score_drop_min
    type:
      - 'null'
      - int
    doc: '>=0: to trigger chimeric detection, the drop in the best non-chimeric alignment
      score with respect to the read length has to be smaller than this value'
    inputBinding:
      position: 101
      prefix: --chimNonchimScoreDropMin
  - id: chim_out_junction_format
    type:
      - 'null'
      - int
    doc: "formatting type for the Chimeric.out.junction file\n                   \
      \             0 ... no comment lines/headers\n                             \
      \   1 ... comment lines at the end of the file: command line and Nreads: total,
      unique, multi"
    inputBinding:
      position: 101
      prefix: --chimOutJunctionFormat
  - id: chim_out_type
    type:
      - 'null'
      - type: array
        items: string
    doc: "type of chimeric output\n                            Junctions       ...
      Chimeric.out.junction\n                            SeparateSAMold  ... output
      old SAM into separate Chimeric.out.sam file\n                            WithinBAM\
      \       ... output into main aligned BAM files (Aligned.*.bam)\n           \
      \                 WithinBAM HardClip  ... (default) hard-clipping in the CIGAR
      for supplemental chimeric alignments (defaultif no 2nd word is present)\n  \
      \                          WithinBAM SoftClip  ... soft-clipping in the CIGAR
      for supplemental chimeric alignments"
    inputBinding:
      position: 101
      prefix: --chimOutType
  - id: chim_score_drop_max
    type:
      - 'null'
      - int
    doc: '>=0: max drop (difference) of chimeric score (the sum of scores of all chimeric
      segments) from the read length'
    inputBinding:
      position: 101
      prefix: --chimScoreDropMax
  - id: chim_score_junction_non_gtag
    type:
      - 'null'
      - int
    doc: penalty for a non-GT/AG chimeric junction
    inputBinding:
      position: 101
      prefix: --chimScoreJunctionNonGTAG
  - id: chim_score_min
    type:
      - 'null'
      - int
    doc: '>=0: minimum total (summed) score of the chimeric segments'
    inputBinding:
      position: 101
      prefix: --chimScoreMin
  - id: chim_score_separation
    type:
      - 'null'
      - int
    doc: '>=0: minimum difference (separation) between the best chimeric score and
      the next one'
    inputBinding:
      position: 101
      prefix: --chimScoreSeparation
  - id: chim_segment_min
    type:
      - 'null'
      - int
    doc: '>=0: minimum length of chimeric segment length, if ==0, no chimeric output'
    inputBinding:
      position: 101
      prefix: --chimSegmentMin
  - id: chim_segment_read_gap_max
    type:
      - 'null'
      - int
    doc: '>=0: maximum gap in the read sequence between chimeric segments'
    inputBinding:
      position: 101
      prefix: --chimSegmentReadGapMax
  - id: clip3p_adapter_mmp
    type:
      - 'null'
      - type: array
        items: float
    doc: max proportion of mismatches for 3p adpater clipping for each mate.  If
      one value is given, it will be assumed the same for both mates.
    inputBinding:
      position: 101
      prefix: --clip3pAdapterMMp
  - id: clip3p_adapter_seq
    type:
      - 'null'
      - type: array
        items: string
    doc: adapter sequences to clip from 3p of each mate.  If one value is given,
      it will be assumed the same for both mates.
    inputBinding:
      position: 101
      prefix: --clip3pAdapterSeq
  - id: clip3p_after_adapter_nbases
    type:
      - 'null'
      - type: array
        items: int
    doc: number of bases to clip from 3p of each mate after the adapter 
      clipping. If one value is given, it will be assumed the same for both 
      mates.
    inputBinding:
      position: 101
      prefix: --clip3pAfterAdapterNbases
  - id: clip3p_nbases
    type:
      - 'null'
      - type: array
        items: int
    doc: number(s) of bases to clip from 3p of each mate. If one value is given,
      it will be assumed the same for both mates.
    inputBinding:
      position: 101
      prefix: --clip3pNbases
  - id: clip5p_nbases
    type:
      - 'null'
      - type: array
        items: int
    doc: number(s) of bases to clip from 5p of each mate. If one value is given,
      it will be assumed the same for both mates.
    inputBinding:
      position: 101
      prefix: --clip5pNbases
  - id: genome_chain_files
    type:
      - 'null'
      - File
    doc: chain files for genomic liftover. Only used with --runMode liftOver .
    inputBinding:
      position: 101
      prefix: --genomeChainFiles
  - id: genome_chr_bin_nbits
    type:
      - 'null'
      - int
    doc: '=log2(chrBin), where chrBin is the size of the bins for genome storage:
      each chromosome will occupy an integer number of bins. For a genome with large
      number of contigs, it is recommended to scale this parameter as min(18, log2[max(GenomeLength/NumberOfReferences,ReadLength)]).'
    inputBinding:
      position: 101
      prefix: --genomeChrBinNbits
  - id: genome_consensus_file
    type:
      - 'null'
      - File
    doc: VCF file with consensus SNPs (i.e. alternative allele is the major 
      (AF>0.5) allele)
    inputBinding:
      position: 101
      prefix: --genomeConsensusFile
  - id: genome_dir
    type: Directory
    doc: path to the directory where genome files are stored (for --runMode 
      alignReads) or will be generated (for --runMode generateGenome)
    inputBinding:
      position: 101
      prefix: --genomeDir
  - id: genome_fasta_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "path(s) to the fasta files with the genome sequences, separated by spaces.
      These files should be plain text FASTA files, they *cannot* be zipped.\n   \
      \                         Required for the genome generation (--runMode genomeGenerate).
      Can also be used in the mapping (--runMode alignReads) to add extra (new) sequences
      to the genome (e.g. spike-ins)."
    inputBinding:
      position: 101
      prefix: --genomeFastaFiles
  - id: genome_file_sizes
    type:
      - 'null'
      - type: array
        items: string
    doc: genome files exact sizes in bytes. Typically, this should not be 
      defined by the user.
    inputBinding:
      position: 101
      prefix: --genomeFileSizes
  - id: genome_load
    type:
      - 'null'
      - string
    doc: "mode of shared memory usage for the genome files. Only used with --runMode
      alignReads.\n                          LoadAndKeep     ... load genome into
      shared and keep it in memory after run\n                          LoadAndRemove\
      \   ... load genome into shared but remove it after run\n                  \
      \        LoadAndExit     ... load genome into shared memory and exit, keeping
      the genome in memory for future runs\n                          Remove     \
      \     ... do not map anything, just remove loaded genome from memory\n     \
      \                     NoSharedMemory  ... do not use shared memory, each job
      will have its own private copy of the genome"
    inputBinding:
      position: 101
      prefix: --genomeLoad
  - id: genome_sa_index_nbases
    type:
      - 'null'
      - int
    doc: length (bases) of the SA pre-indexing string. Typically between 10 and 
      15. Longer strings will use much more memory, but allow faster searches. 
      For small genomes, the parameter --genomeSAindexNbases must be scaled down
      to min(14, log2(GenomeLength)/2 - 1).
    inputBinding:
      position: 101
      prefix: --genomeSAindexNbases
  - id: genome_sa_sparse_d
    type:
      - 'null'
      - int
    doc: 'suffux array sparsity, i.e. distance between indices: use bigger numbers
      to decrease needed RAM at the cost of mapping speed reduction'
    inputBinding:
      position: 101
      prefix: --genomeSAsparseD
  - id: genome_suffix_length_max
    type:
      - 'null'
      - int
    doc: maximum length of the suffixes, has to be longer than read length. -1 =
      infinite.
    inputBinding:
      position: 101
      prefix: --genomeSuffixLengthMax
  - id: input_bam_file
    type:
      - 'null'
      - File
    doc: path to BAM input file, to be used with --runMode 
      inputAlignmentsFromBAM
    inputBinding:
      position: 101
      prefix: --inputBAMfile
  - id: limit_bam_sort_ram
    type:
      - 'null'
      - int
    doc: maximum available RAM (bytes) for sorting BAM. If =0, it will be set to
      the genome index size. 0 value can only be used with --genomeLoad 
      NoSharedMemory option.
    inputBinding:
      position: 101
      prefix: --limitBAMsortRAM
  - id: limit_genome_generate_ram
    type:
      - 'null'
      - int
    doc: maximum available RAM (bytes) for genome generation
    inputBinding:
      position: 101
      prefix: --limitGenomeGenerateRAM
  - id: limit_io_buffer_size
    type:
      - 'null'
      - int
    doc: max available buffers size (bytes) for input/output, per thread
    inputBinding:
      position: 101
      prefix: --limitIoBufferSize
  - id: limit_nreads_soft
    type:
      - 'null'
      - int
    doc: soft limit on the number of reads
    inputBinding:
      position: 101
      prefix: --limitNreadsSoft
  - id: limit_out_sam_one_read_bytes
    type:
      - 'null'
      - int
    doc: 'max size of the SAM record (bytes) for one read. Recommended value: >(2*(LengthMate1+LengthMate2+100)*outFilterMultimapNmax'
    inputBinding:
      position: 101
      prefix: --limitOutSAMoneReadBytes
  - id: limit_out_sj_collapsed
    type:
      - 'null'
      - int
    doc: max number of collapsed junctions
    inputBinding:
      position: 101
      prefix: --limitOutSJcollapsed
  - id: limit_out_sj_one_read
    type:
      - 'null'
      - int
    doc: max number of junctions for one read (including all multi-mappers)
    inputBinding:
      position: 101
      prefix: --limitOutSJoneRead
  - id: limit_sjdb_insert_nsj
    type:
      - 'null'
      - int
    doc: maximum number of junction to be inserted to the genome on the fly at 
      the mapping stage, including those from annotations and those detected in 
      the 1st step of the 2-pass run
    inputBinding:
      position: 101
      prefix: --limitSjdbInsertNsj
  - id: out_bam_compression
    type:
      - 'null'
      - int
    doc: -1 to 10  BAM compression level, -1=default compression (6?), 0=no 
      compression, 10=maximum compression
    inputBinding:
      position: 101
      prefix: --outBAMcompression
  - id: out_bam_sorting_bins_n
    type:
      - 'null'
      - int
    doc: '>0:  number of genome bins fo coordinate-sorting'
    inputBinding:
      position: 101
      prefix: --outBAMsortingBinsN
  - id: out_bam_sorting_thread_n
    type:
      - 'null'
      - int
    doc: '>=0: number of threads for BAM sorting. 0 will default to min(6,--runThreadN).'
    inputBinding:
      position: 101
      prefix: --outBAMsortingThreadN
  - id: out_file_name_prefix
    type:
      - 'null'
      - string
    doc: output files name prefix (including full or relative path). Can only be
      defined on the command line.
    inputBinding:
      position: 101
      prefix: --outFileNamePrefix
  - id: out_filter_intron_motifs
    type:
      - 'null'
      - string
    doc: "filter alignment using their motifs\n\t\t\t\tNone                      \
      \     ... no filtering\n\t\t\t\tRemoveNoncanonical             ... filter out
      alignments that contain non-canonical junctions\n\t\t\t\tRemoveNoncanonicalUnannotated\
      \  ... filter out alignments that contain non-canonical unannotated junctions
      when using annotated splice junctions database. The annotated non-canonical
      junctions will be kept."
    inputBinding:
      position: 101
      prefix: --outFilterIntronMotifs
  - id: out_filter_intron_strands
    type:
      - 'null'
      - string
    doc: "filter alignments \n                RemoveInconsistentStrands      ... remove
      alignments that have junctions with inconsistent strands\n                None\
      \                           ... no filtering"
    inputBinding:
      position: 101
      prefix: --outFilterIntronStrands
  - id: out_filter_match_nmin
    type:
      - 'null'
      - int
    doc: alignment will be output only if the number of matched bases is higher 
      than or equal to this value.
    inputBinding:
      position: 101
      prefix: --outFilterMatchNmin
  - id: out_filter_match_nmin_over_lread
    type:
      - 'null'
      - float
    doc: sam as outFilterMatchNmin, but normalized to the read length (sum of 
      mates' lengths for paired-end reads).
    inputBinding:
      position: 101
      prefix: --outFilterMatchNminOverLread
  - id: out_filter_mismatch_nmax
    type:
      - 'null'
      - int
    doc: alignment will be output only if it has no more mismatches than this 
      value.
    inputBinding:
      position: 101
      prefix: --outFilterMismatchNmax
  - id: out_filter_mismatch_nover_lmax
    type:
      - 'null'
      - float
    doc: alignment will be output only if its ratio of mismatches to *mapped* 
      length is less than or equal to this value.
    inputBinding:
      position: 101
      prefix: --outFilterMismatchNoverLmax
  - id: out_filter_mismatch_nover_read_lmax
    type:
      - 'null'
      - float
    doc: alignment will be output only if its ratio of mismatches to *read* 
      length is less than or equal to this value.
    inputBinding:
      position: 101
      prefix: --outFilterMismatchNoverReadLmax
  - id: out_filter_multimap_nmax
    type:
      - 'null'
      - int
    doc: "maximum number of loci the read is allowed to map to. Alignments (all of
      them) will be output only if the read maps to no more loci than this value.\n\
      \         Otherwise no alignments will be output, and the read will be counted
      as \"mapped to too many loci\" in the Log.final.out ."
    inputBinding:
      position: 101
      prefix: --outFilterMultimapNmax
  - id: out_filter_multimap_score_range
    type:
      - 'null'
      - int
    doc: the score range below the maximum score for multimapping alignments
    inputBinding:
      position: 101
      prefix: --outFilterMultimapScoreRange
  - id: out_filter_score_min
    type:
      - 'null'
      - int
    doc: alignment will be output only if its score is higher than or equal to 
      this value.
    inputBinding:
      position: 101
      prefix: --outFilterScoreMin
  - id: out_filter_score_min_over_lread
    type:
      - 'null'
      - float
    doc: same as outFilterScoreMin, but  normalized to read length (sum of 
      mates' lengths for paired-end reads)
    inputBinding:
      position: 101
      prefix: --outFilterScoreMinOverLread
  - id: out_filter_type
    type:
      - 'null'
      - string
    doc: "type of filtering\n                                Normal  ... standard
      filtering using only current alignment\n                                BySJout
      ... keep only those reads that contain junctions that passed filtering into
      SJ.out.tab"
    inputBinding:
      position: 101
      prefix: --outFilterType
  - id: out_multimapper_order
    type:
      - 'null'
      - string
    doc: "order of multimapping alignments in the output files\n                 \
      \               Old_2.4             ... quasi-random order used before 2.5.0\n\
      \                                Random              ... random order of alignments
      for each multi-mapper. Read mates (pairs) are always adjacent, all alignment
      for each read stay together. This option will become default in the future releases."
    inputBinding:
      position: 101
      prefix: --outMultimapperOrder
  - id: out_qsconversion_add
    type:
      - 'null'
      - int
    doc: add this number to the quality score (e.g. to convert from Illumina to 
      Sanger, use -31)
    inputBinding:
      position: 101
      prefix: --outQSconversionAdd
  - id: out_reads_unmapped
    type:
      - 'null'
      - string
    doc: "output of unmapped and partially mapped (i.e. mapped only one mate of a
      paired end read) reads in separate file(s).\n                              \
      \  None    ... no output\n                                Fastx   ... output
      in separate fasta/fastq files, Unmapped.out.mate1/2"
    inputBinding:
      position: 101
      prefix: --outReadsUnmapped
  - id: out_sam_attr_ihstart
    type:
      - 'null'
      - int
    doc: start value for the IH attribute. 0 may be required by some downstream 
      software, such as Cufflinks or StringTie.
    inputBinding:
      position: 101
      prefix: --outSAMattrIHstart
  - id: out_sam_attr_rgline
    type:
      - 'null'
      - type: array
        items: string
    doc: "SAM/BAM read group line. The first word contains the read group identifier
      and must start with \"ID:\", e.g. --outSAMattrRGline ID:xxx CN:yy \"DS:z z z\"\
      .\n            xxx will be added as RG tag to each output alignment. Any spaces
      in the tag values have to be double quoted.\n            Comma separated RG
      lines correspons to different (comma separated) input files in --readFilesIn.
      Commas have to be surrounded by spaces, e.g.\n            --outSAMattrRGline
      ID:xxx , ID:zzz \"DS:z z\" , ID:yyy DS:yyyy"
    inputBinding:
      position: 101
      prefix: --outSAMattrRGline
  - id: out_sam_attributes
    type:
      - 'null'
      - string
    doc: "a string of desired SAM attributes, in the order desired for the output
      SAM\n                                NH HI AS nM NM MD jM jI XS MC ch ... any
      combination in any order\n                                None        ... no
      attributes\n                                Standard    ... NH HI AS nM\n  \
      \                              All         ... NH HI AS nM NM MD jM jI MC ch\n\
      \                                vA          ... variant allele\n          \
      \                      vG          ... genomic coordiante of the variant overlapped
      by the read\n                                vW          ... 0/1 - alignment
      does not pass / passes WASP filtering. Requires --waspOutputMode SAMtag \n \
      \                               CR,CY,UR,UY ... sequences and quality scores
      of cell barcodes and UMIs for the solo* demultiplexing\n                   \
      \             Unsupported/undocumented:\n                                rB\
      \          ... alignment block read/genomic coordinates\n                  \
      \              vR          ... read coordinate of the variant"
    inputBinding:
      position: 101
      prefix: --outSAMattributes
  - id: out_sam_filter
    type:
      - 'null'
      - type: array
        items: string
    doc: "filter the output into main SAM/BAM files\n                        KeepOnlyAddedReferences
      ... only keep the reads for which all alignments are to the extra reference
      sequences added with --genomeFastaFiles at the mapping stage.\n            \
      \            KeepAllAddedReferences ...  keep all alignments to the extra reference
      sequences added with --genomeFastaFiles at the mapping stage."
    inputBinding:
      position: 101
      prefix: --outSAMfilter
  - id: out_sam_flag_and
    type:
      - 'null'
      - int
    doc: "0 to 65535: sam FLAG will be bitwise AND'd with this value, i.e. FLAG=FLAG
      & outSAMflagOR. This is applied after all flags have been set by STAR, but before
      outSAMflagOR. Can be used to unset specific bits that are not set otherwise."
    inputBinding:
      position: 101
      prefix: --outSAMflagAND
  - id: out_sam_flag_or
    type:
      - 'null'
      - int
    doc: "0 to 65535: sam FLAG will be bitwise OR'd with this value, i.e. FLAG=FLAG
      | outSAMflagOR. This is applied after all flags have been set by STAR, and after
      outSAMflagAND. Can be used to set specific bits that are not set otherwise."
    inputBinding:
      position: 101
      prefix: --outSAMflagOR
  - id: out_sam_header_comment_file
    type:
      - 'null'
      - File
    doc: path to the file with @CO (comment) lines of the SAM header
    inputBinding:
      position: 101
      prefix: --outSAMheaderCommentFile
  - id: out_sam_header_hd
    type:
      - 'null'
      - type: array
        items: string
    doc: '@HD (header) line of the SAM header'
    inputBinding:
      position: 101
      prefix: --outSAMheaderHD
  - id: out_sam_header_pg
    type:
      - 'null'
      - type: array
        items: string
    doc: extra @PG (software) line of the SAM header (in addition to STAR)
    inputBinding:
      position: 101
      prefix: --outSAMheaderPG
  - id: out_sam_mapq_unique
    type:
      - 'null'
      - int
    doc: '0 to 255: the MAPQ value for unique mappers'
    inputBinding:
      position: 101
      prefix: --outSAMmapqUnique
  - id: out_sam_mode
    type:
      - 'null'
      - string
    doc: "mode of SAM output\n                                None ... no SAM output\n\
      \                                Full ... full SAM output\n                \
      \                NoQS ... full SAM but without quality scores"
    inputBinding:
      position: 101
      prefix: --outSAMmode
  - id: out_sam_mult_nmax
    type:
      - 'null'
      - int
    doc: "max number of multiple alignments for a read that will be output to the
      SAM/BAM files.\n                        -1 ... all alignments (up to --outFilterMultimapNmax)
      will be output"
    inputBinding:
      position: 101
      prefix: --outSAMmultNmax
  - id: out_sam_order
    type:
      - 'null'
      - string
    doc: "type of sorting for the SAM output\n                                Paired:
      one mate after the other for all paired alignments\n                       \
      \         PairedKeepInputOrder: one mate after the other for all paired alignments,
      the order is kept the same as in the input FASTQ files"
    inputBinding:
      position: 101
      prefix: --outSAMorder
  - id: out_sam_primary_flag
    type:
      - 'null'
      - string
    doc: "which alignments are considered primary - all others will be marked with
      0x100 bit in the FLAG\n                                OneBestScore ... only
      one alignment with the best score is primary\n                             \
      \   AllBestScore ... all alignments with the best score are primary"
    inputBinding:
      position: 101
      prefix: --outSAMprimaryFlag
  - id: out_sam_read_id
    type:
      - 'null'
      - string
    doc: "read ID record type\n                                Standard ... first
      word (until space) from the FASTx read ID line, removing /1,/2 from the end\n\
      \                                Number   ... read number (index) in the FASTx
      file"
    inputBinding:
      position: 101
      prefix: --outSAMreadID
  - id: out_sam_strand_field
    type:
      - 'null'
      - string
    doc: "Cufflinks-like strand field flag\n                                None \
      \       ... not used\n                                intronMotif ... strand
      derived from the intron motif. Reads with inconsistent and/or non-canonical
      introns are filtered out."
    inputBinding:
      position: 101
      prefix: --outSAMstrandField
  - id: out_sam_tlen
    type:
      - 'null'
      - int
    doc: "calculation method for the TLEN field in the SAM/BAM files\n           \
      \             1 ... leftmost base of the (+)strand mate to rightmost base of
      the (-)mate. (+)sign for the (+)strand mate\n                        2 ... leftmost
      base of any mate to rightmost base of any mate. (+)sign for the mate with the
      leftmost base. This is different from 1 for overlapping mates with protruding
      ends"
    inputBinding:
      position: 101
      prefix: --outSAMtlen
  - id: out_sam_type
    type:
      - 'null'
      - type: array
        items: string
    doc: "type of SAM/BAM output\n                                1st word:\n    \
      \                            BAM  ... output BAM without sorting\n         \
      \                       SAM  ... output SAM without sorting\n              \
      \                  None ... no SAM/BAM output\n                            \
      \    2nd, 3rd:\n                                Unsorted           ... standard
      unsorted\n                                SortedByCoordinate ... sorted by coordinate.
      This option will allocate extra memory for sorting which can be specified by
      --limitBAMsortRAM."
    inputBinding:
      position: 101
      prefix: --outSAMtype
  - id: out_sam_unmapped
    type:
      - 'null'
      - type: array
        items: string
    doc: "output of unmapped reads in the SAM format\n                           \
      \     1st word:\n                                None   ... no output\n    \
      \                            Within ... output unmapped reads within the main
      SAM file (i.e. Aligned.out.sam)\n                                2nd word:\n\
      \                                KeepPairs ... record unmapped mate for each
      alignment, and, in case of unsorted output, keep it adjacent to its mapped mate.
      Only affects multi-mapping reads."
    inputBinding:
      position: 101
      prefix: --outSAMunmapped
  - id: out_sj_filter_count_total_min
    type:
      - 'null'
      - type: array
        items: int
    doc: "4 integers: minimum total (multi-mapping+unique) read count per junction
      for: (1) non-canonical motifs, (2) GT/AG and CT/AC motif, (3) GC/AG and CT/GC
      motif, (4) AT/AC and GT/AT motif. -1 means no output for that motif\n      \
      \                          Junctions are output if one of outSJfilterCountUniqueMin
      OR outSJfilterCountTotalMin conditions are satisfied\n                     \
      \           does not apply to annotated junctions"
    inputBinding:
      position: 101
      prefix: --outSJfilterCountTotalMin
  - id: out_sj_filter_count_unique_min
    type:
      - 'null'
      - type: array
        items: int
    doc: "4 integers: minimum uniquely mapping read count per junction for: (1) non-canonical
      motifs, (2) GT/AG and CT/AC motif, (3) GC/AG and CT/GC motif, (4) AT/AC and
      GT/AT motif. -1 means no output for that motif\n                           \
      \     Junctions are output if one of outSJfilterCountUniqueMin OR outSJfilterCountTotalMin
      conditions are satisfied\n                                does not apply to
      annotated junctions"
    inputBinding:
      position: 101
      prefix: --outSJfilterCountUniqueMin
  - id: out_sj_filter_dist_to_other_sjmin
    type:
      - 'null'
      - type: array
        items: int
    doc: "4 integers>=0: minimum allowed distance to other junctions' donor/acceptor\n\
      \                                does not apply to annotated junctions"
    inputBinding:
      position: 101
      prefix: --outSJfilterDistToOtherSJmin
  - id: out_sj_filter_intron_max_vs_read_n
    type:
      - 'null'
      - type: array
        items: int
    doc: "N integers>=0: maximum gap allowed for junctions supported by 1,2,3,,,N
      reads\n                                i.e. by default junctions supported by
      1 read can have gaps <=50000b, by 2 reads: <=100000b, by 3 reads: <=200000.
      by >=4 reads any gap <=alignIntronMax\n                                does
      not apply to annotated junctions"
    inputBinding:
      position: 101
      prefix: --outSJfilterIntronMaxVsReadN
  - id: out_sj_filter_overhang_min
    type:
      - 'null'
      - type: array
        items: int
    doc: "4 integers:    minimum overhang length for splice junctions on both sides
      for: (1) non-canonical motifs, (2) GT/AG and CT/AC motif, (3) GC/AG and CT/GC
      motif, (4) AT/AC and GT/AT motif. -1 means no output for that motif\n      \
      \                          does not apply to annotated junctions"
    inputBinding:
      position: 101
      prefix: --outSJfilterOverhangMin
  - id: out_sj_filter_reads
    type:
      - 'null'
      - string
    doc: "which reads to consider for collapsed splice junctions output\n        \
      \        All: all reads, unique- and multi-mappers\n                Unique:
      uniquely mapping reads only"
    inputBinding:
      position: 101
      prefix: --outSJfilterReads
  - id: out_std
    type:
      - 'null'
      - string
    doc: "which output will be directed to stdout (standard out)\n               \
      \                 Log                    ... log messages\n                \
      \                SAM                    ... alignments in SAM format (which
      normally are output to Aligned.out.sam file), normal standard output will go
      into Log.std.out\n                                BAM_Unsorted           ...
      alignments in BAM format, unsorted. Requires --outSAMtype BAM Unsorted\n   \
      \                             BAM_SortedByCoordinate ... alignments in BAM format,
      unsorted. Requires --outSAMtype BAM SortedByCoordinate\n                   \
      \             BAM_Quant              ... alignments to transcriptome in BAM
      format, unsorted. Requires --quantMode TranscriptomeSAM"
    inputBinding:
      position: 101
      prefix: --outStd
  - id: out_tmp_dir
    type:
      - 'null'
      - Directory
    doc: "path to a directory that will be used as temporary by STAR. All contents
      of this directory will be removed!\n            - the temp directory will default
      to outFileNamePrefix_STARtmp"
    inputBinding:
      position: 101
      prefix: --outTmpDir
  - id: out_tmp_keep
    type:
      - 'null'
      - string
    doc: "whether to keep the tempporary files after STAR runs is finished\n     \
      \                           None ... remove all temporary files\n          \
      \                      All .. keep all files"
    inputBinding:
      position: 101
      prefix: --outTmpKeep
  - id: out_wig_norm
    type:
      - 'null'
      - string
    doc: "type of normalization for the signal\n                        RPM    ...
      reads per million of mapped reads\n                        None   ... no normalization,
      \"raw\" counts"
    inputBinding:
      position: 101
      prefix: --outWigNorm
  - id: out_wig_references_prefix
    type:
      - 'null'
      - string
    doc: prefix matching reference names to include in the output wiggle file, 
      e.g. "chr", default "-" - include all references
    inputBinding:
      position: 101
      prefix: --outWigReferencesPrefix
  - id: out_wig_strand
    type:
      - 'null'
      - string
    doc: "strandedness of wiggle/bedGraph output\n                    Stranded   ...\
      \  separate strands, str1 and str2\n                    Unstranded ...  collapsed
      strands"
    inputBinding:
      position: 101
      prefix: --outWigStrand
  - id: out_wig_type
    type:
      - 'null'
      - type: array
        items: string
    doc: "type of signal output, e.g. \"bedGraph\" OR \"bedGraph read1_5p\". Requires
      sorted BAM: --outSAMtype BAM SortedByCoordinate .\n                    1st word:\n\
      \                    None       ... no signal output\n                    bedGraph\
      \   ... bedGraph format\n                    wiggle     ... wiggle format\n\
      \                    2nd word:\n                    read1_5p   ... signal from
      only 5' of the 1st read, useful for CAGE/RAMPAGE etc\n                    read2\
      \      ... signal from only 2nd read"
    inputBinding:
      position: 101
      prefix: --outWigType
  - id: parameters_files
    type:
      - 'null'
      - string
    doc: 'name of a user-defined parameters file, "-": none. Can only be defined on
      the command line.'
    inputBinding:
      position: 101
      prefix: --parametersFiles
  - id: pe_overlap_mmp
    type:
      - 'null'
      - float
    doc: maximum proportion of mismatched bases in the overlap area
    inputBinding:
      position: 101
      prefix: --peOverlapMMp
  - id: pe_overlap_nbases_min
    type:
      - 'null'
      - int
    doc: minimum number of overlap bases to trigger mates merging and 
      realignment
    inputBinding:
      position: 101
      prefix: --peOverlapNbasesMin
  - id: quant_mode
    type:
      - 'null'
      - type: array
        items: string
    doc: "types of quantification requested\n                            -       \
      \         ... none\n                            TranscriptomeSAM ... output
      SAM/BAM alignments to transcriptome into a separate file\n                 \
      \           GeneCounts       ... count reads per gene"
    inputBinding:
      position: 101
      prefix: --quantMode
  - id: quant_transcriptome_bam_compression
    type:
      - 'null'
      - type: array
        items: int
    doc: "-2 to 10  transcriptome BAM compression level\n                        \
      \    -2  ... no BAM output\n                            -1  ... default compression
      (6?)\n                             0  ... no compression\n                 \
      \            10 ... maximum compression"
    inputBinding:
      position: 101
      prefix: --quantTranscriptomeBAMcompression
  - id: quant_transcriptome_ban
    type:
      - 'null'
      - string
    doc: "prohibit various alignment type\n                            IndelSoftclipSingleend\
      \  ... prohibit indels, soft clipping and single-end alignments - compatible
      with RSEM\n                            Singleend               ... prohibit
      single-end alignments"
    inputBinding:
      position: 101
      prefix: --quantTranscriptomeBan
  - id: read_files
    type:
      type: array
      items: File
    doc: paths to files that contain input read1 (and, if needed, read2)
    inputBinding:
      position: 101
      prefix: --readFilesIn
  - id: read_files_command
    type:
      - 'null'
      - type: array
        items: string
    doc: "command line to execute for each of the input file. This command should
      generate FASTA or FASTQ text and send it to stdout\n               For example:
      zcat - to uncompress .gz files, bzcat - to uncompress .bz2 files, etc."
    inputBinding:
      position: 101
      prefix: --readFilesCommand
  - id: read_files_prefix
    type:
      - 'null'
      - string
    doc: "preifx for the read files names, i.e. it will be added in front of the strings
      in --readFilesIn\n                            -: no prefix"
    inputBinding:
      position: 101
      prefix: --readFilesPrefix
  - id: read_files_type
    type:
      - 'null'
      - string
    doc: "format of input read files\n                            Fastx       ...
      FASTA or FASTQ\n                            SAM SE      ... SAM or BAM single-end
      reads; for BAM use --readFilesCommand samtools view\n                      \
      \      SAM PE      ... SAM or BAM paired-end reads; for BAM use --readFilesCommand
      samtools view"
    inputBinding:
      position: 101
      prefix: --readFilesType
  - id: read_map_number
    type:
      - 'null'
      - int
    doc: "number of reads to map from the beginning of the file\n                \
      \            -1: map all reads"
    inputBinding:
      position: 101
      prefix: --readMapNumber
  - id: read_mates_lengths_in
    type:
      - 'null'
      - string
    doc: Equal/NotEqual - lengths of names,sequences,qualities for both mates 
      are the same  / not the same. NotEqual is safe in all situations.
    inputBinding:
      position: 101
      prefix: --readMatesLengthsIn
  - id: read_name_separator
    type:
      - 'null'
      - string
    doc: character(s) separating the part of the read names that will be trimmed
      in output (read name after space is always trimmed)
    inputBinding:
      position: 101
      prefix: --readNameSeparator
  - id: read_strand
    type:
      - 'null'
      - string
    doc: "library strandedness type\n                            Unstranded  ... unstranded
      library\n                            Forward     ... 1st read strand same as
      RNA (i.e. 2nd cDNA synthesis strand)\n                            Reverse  \
      \   ... 1st read opposite to RNA (i.e. 1st cDNA synthesis strand)"
    inputBinding:
      position: 101
      prefix: --readStrand
  - id: run_dir_perm
    type:
      - 'null'
      - string
    doc: "permissions for the directories created at the run-time.\n             \
      \                   User_RWX ... user-read/write/execute\n                 \
      \               All_RWX  ... all-read/write/execute (same as chmod 777)"
    inputBinding:
      position: 101
      prefix: --runDirPerm
  - id: run_mode
    type:
      - 'null'
      - string
    doc: "type of the run.\n\n                                alignReads         \
      \    ... map reads\n                                genomeGenerate         ...
      generate genome files\n                                inputAlignmentsFromBAM
      ... input alignments from BAM. Presently only works with --outWigType and --bamRemoveDuplicates.\n\
      \                                liftOver               ... lift-over of GTF
      files (--sjdbGTFfile) between genome assemblies using chain file(s) from --genomeChainFiles."
    inputBinding:
      position: 101
      prefix: --runMode
  - id: run_rngseed
    type:
      - 'null'
      - int
    doc: random number generator seed.
    inputBinding:
      position: 101
      prefix: --runRNGseed
  - id: run_thread_n
    type:
      - 'null'
      - int
    doc: number of threads to run STAR
    inputBinding:
      position: 101
      prefix: --runThreadN
  - id: score_del_base
    type:
      - 'null'
      - int
    doc: deletion extension penalty per base (in addition to scoreDelOpen)
    inputBinding:
      position: 101
      prefix: --scoreDelBase
  - id: score_del_open
    type:
      - 'null'
      - int
    doc: deletion open penalty
    inputBinding:
      position: 101
      prefix: --scoreDelOpen
  - id: score_gap
    type:
      - 'null'
      - int
    doc: splice junction penalty (independent on intron motif)
    inputBinding:
      position: 101
      prefix: --scoreGap
  - id: score_gap_atac
    type:
      - 'null'
      - int
    doc: AT/AC  and GT/AT junction penalty  (in addition to scoreGap)
    inputBinding:
      position: 101
      prefix: --scoreGapATAC
  - id: score_gap_gcag
    type:
      - 'null'
      - int
    doc: GC/AG and CT/GC junction penalty (in addition to scoreGap)
    inputBinding:
      position: 101
      prefix: --scoreGapGCAG
  - id: score_gap_noncan
    type:
      - 'null'
      - int
    doc: non-canonical junction penalty (in addition to scoreGap)
    inputBinding:
      position: 101
      prefix: --scoreGapNoncan
  - id: score_genomic_length_log2scale
    type:
      - 'null'
      - float
    doc: 'extra score logarithmically scaled with genomic length of the alignment:
      scoreGenomicLengthLog2scale*log2(genomicLength)'
    inputBinding:
      position: 101
      prefix: --scoreGenomicLengthLog2scale
  - id: score_ins_base
    type:
      - 'null'
      - int
    doc: insertion extension penalty per base (in addition to scoreInsOpen)
    inputBinding:
      position: 101
      prefix: --scoreInsBase
  - id: score_ins_open
    type:
      - 'null'
      - int
    doc: insertion open penalty
    inputBinding:
      position: 101
      prefix: --scoreInsOpen
  - id: score_stitch_sjshift
    type:
      - 'null'
      - int
    doc: maximum score reduction while searching for SJ boundaries inthe 
      stitching step
    inputBinding:
      position: 101
      prefix: --scoreStitchSJshift
  - id: seed_multimap_nmax
    type:
      - 'null'
      - int
    doc: only pieces that map fewer than this value are utilized in the 
      stitching procedure
    inputBinding:
      position: 101
      prefix: --seedMultimapNmax
  - id: seed_none_loci_per_window
    type:
      - 'null'
      - int
    doc: max number of one seed loci per window
    inputBinding:
      position: 101
      prefix: --seedNoneLociPerWindow
  - id: seed_per_read_nmax
    type:
      - 'null'
      - int
    doc: max number of seeds per read
    inputBinding:
      position: 101
      prefix: --seedPerReadNmax
  - id: seed_per_window_nmax
    type:
      - 'null'
      - int
    doc: max number of seeds per window
    inputBinding:
      position: 101
      prefix: --seedPerWindowNmax
  - id: seed_search_lmax
    type:
      - 'null'
      - int
    doc: defines the maximum length of the seeds, if =0 max seed lengthis 
      infinite
    inputBinding:
      position: 101
      prefix: --seedSearchLmax
  - id: seed_search_start_lmax
    type:
      - 'null'
      - int
    doc: defines the search start point through the read - the read is split 
      into pieces no longer than this value
    inputBinding:
      position: 101
      prefix: --seedSearchStartLmax
  - id: seed_search_start_lmax_over_lread
    type:
      - 'null'
      - float
    doc: seedSearchStartLmax normalized to read length (sum of mates' lengths 
      for paired-end reads)
    inputBinding:
      position: 101
      prefix: --seedSearchStartLmaxOverLread
  - id: seed_split_min
    type:
      - 'null'
      - int
    doc: min length of the seed sequences split by Ns or mate gap
    inputBinding:
      position: 101
      prefix: --seedSplitMin
  - id: sjdb_file_chr_start_end
    type:
      - 'null'
      - type: array
        items: string
    doc: path to the files with genomic coordinates (chr <tab> start <tab> end 
      <tab> strand) for the splice junction introns. Multiple files can be 
      supplied wand will be concatenated.
    inputBinding:
      position: 101
      prefix: --sjdbFileChrStartEnd
  - id: sjdb_gtf_chr_prefix
    type:
      - 'null'
      - string
    doc: prefix for chromosome names in a GTF file (e.g. 'chr' for using ENSMEBL
      annotations with UCSC genomes)
    inputBinding:
      position: 101
      prefix: --sjdbGTFchrPrefix
  - id: sjdb_gtf_feature_exon
    type:
      - 'null'
      - string
    doc: feature type in GTF file to be used as exons for building transcripts
    inputBinding:
      position: 101
      prefix: --sjdbGTFfeatureExon
  - id: sjdb_gtf_file
    type:
      - 'null'
      - File
    doc: path to the GTF file with annotations
    inputBinding:
      position: 101
      prefix: --sjdbGTFfile
  - id: sjdb_gtf_tag_exon_parent_gene
    type:
      - 'null'
      - string
    doc: tag name to be used as exons' gene-parents (default "gene_id" works for
      GTF files)
    inputBinding:
      position: 101
      prefix: --sjdbGTFtagExonParentGene
  - id: sjdb_gtf_tag_exon_parent_transcript
    type:
      - 'null'
      - string
    doc: tag name to be used as exons' transcript-parents (default 
      "transcript_id" works for GTF files)
    inputBinding:
      position: 101
      prefix: --sjdbGTFtagExonParentTranscript
  - id: sjdb_insert_save
    type:
      - 'null'
      - string
    doc: "which files to save when sjdb junctions are inserted on the fly at the mapping
      step\n\t\t\t\t\tBasic ... only small junction / transcript files\n\t\t\t\t\t\
      All   ... all files including big Genome, SA and SAindex - this will create
      a complete genome directory"
    inputBinding:
      position: 101
      prefix: --sjdbInsertSave
  - id: sjdb_overhang
    type:
      - 'null'
      - int
    doc: length of the donor/acceptor sequence on each side of the junctions, 
      ideally = (mate_length - 1)
    inputBinding:
      position: 101
      prefix: --sjdbOverhang
  - id: sjdb_score
    type:
      - 'null'
      - int
    doc: extra alignment score for alignmets that cross database junctions
    inputBinding:
      position: 101
      prefix: --sjdbScore
  - id: solo_cb_len
    type:
      - 'null'
      - int
    doc: cell barcode length
    inputBinding:
      position: 101
      prefix: --soloCBlen
  - id: solo_cb_start
    type:
      - 'null'
      - int
    doc: cell barcode start base
    inputBinding:
      position: 101
      prefix: --soloCBstart
  - id: solo_cb_whitelist
    type:
      - 'null'
      - File
    doc: file with whitelist of cell barcodes
    inputBinding:
      position: 101
      prefix: --soloCBwhitelist
  - id: solo_features
    type:
      - 'null'
      - type: array
        items: string
    doc: "genomic features for which the UMI counts per Cell Barcode are collected\n\
      \                            Gene            ... genes: reads match the gene
      transcript\n                            SJ              ... splice junctions:
      reported in SJ.out.tab"
    inputBinding:
      position: 101
      prefix: --soloFeatures
  - id: solo_out_file_names
    type:
      - 'null'
      - type: array
        items: string
    doc: "file names for STARsolo output\n                            1st word   \
      \ ... file name prefix\n                            2nd word    ... barcode
      sequences\n                            3rd word    ... gene IDs and names\n\
      \                            4th word    ... cell/gene counts matrix\n     \
      \                       5th word    ... cell/splice junction counts matrix"
    inputBinding:
      position: 101
      prefix: --soloOutFileNames
  - id: solo_strand
    type:
      - 'null'
      - string
    doc: "strandedness of the solo libraries:\n                            Unstranded\
      \  ... no strand information\n                            Forward     ... read
      strand same as the original RNA molecule\n                            Reverse\
      \     ... read strand opposite to the original RNA molecule"
    inputBinding:
      position: 101
      prefix: --soloStrand
  - id: solo_type
    type:
      - 'null'
      - type: array
        items: string
    doc: "type of single-cell RNA-seq\n                            Droplet   ... one
      cell barcode and one UMI barcode in read2, e.g. Drop-seq and 10X Chromium"
    inputBinding:
      position: 101
      prefix: --soloType
  - id: solo_umi_dedup
    type:
      - 'null'
      - type: array
        items: string
    doc: "type of UMI deduplication (collapsing) algorithm\n                     \
      \       1MM_All             ... all UMIs with 1 mismatch distance to each other
      are collapsed (i.e. counted once)\n                            1MM_Directional\
      \     ... follows the \"directional\" method from the UMI-tools by Smith, Heger
      and Sudbery (Genome Research 2017).\n                            1MM_NotCollapsed\
      \      ... UMIs with 1 mismatch distance to others are not collapsed (i.e. all
      counted)"
    inputBinding:
      position: 101
      prefix: --soloUMIdedup
  - id: solo_umi_len
    type:
      - 'null'
      - int
    doc: UMI length
    inputBinding:
      position: 101
      prefix: --soloUMIlen
  - id: solo_umi_start
    type:
      - 'null'
      - int
    doc: UMI start base
    inputBinding:
      position: 101
      prefix: --soloUMIstart
  - id: sys_shell
    type:
      - 'null'
      - string
    doc: "path to the shell binary, preferably bash, e.g. /bin/bash.\n           \
      \         - ... the default shell is executed, typically /bin/sh. This was reported
      to fail on some Ubuntu systems - then you need to specify path to bash."
    inputBinding:
      position: 101
      prefix: --sysShell
  - id: twopass1_reads_n
    type:
      - 'null'
      - int
    doc: number of reads to process for the 1st step. Use very large number (or 
      default -1) to map all reads in the first step.
    inputBinding:
      position: 101
      prefix: --twopass1readsN
  - id: twopass_mode
    type:
      - 'null'
      - string
    doc: "2-pass mapping mode.\n                            None        ... 1-pass
      mapping\n                            Basic       ... basic 2-pass mapping, with
      all 1st pass junctions inserted into the genome indices on the fly"
    inputBinding:
      position: 101
      prefix: --twopassMode
  - id: var_vcf_file
    type:
      - 'null'
      - File
    doc: path to the VCF file that contains variation data.
    inputBinding:
      position: 101
      prefix: --varVCFfile
  - id: wasp_output_mode
    type:
      - 'null'
      - string
    doc: "WASP allele-specific output type. This is re-implemenation of the original
      WASP mappability filtering by Bryce van de Geijn, Graham McVicker, Yoav Gilad
      & Jonathan K Pritchard. Please cite the original WASP paper: Nature Methods
      12, 1061–1063 (2015), https://www.nature.com/articles/nmeth.3582 .\n       \
      \                     SAMtag      ... add WASP tags to the alignments that pass
      WASP filtering"
    inputBinding:
      position: 101
      prefix: --waspOutputMode
  - id: win_anchor_dist_nbins
    type:
      - 'null'
      - int
    doc: max number of bins between two anchors that allows aggregation of 
      anchors into one window
    inputBinding:
      position: 101
      prefix: --winAnchorDistNbins
  - id: win_anchor_multimap_nmax
    type:
      - 'null'
      - int
    doc: max number of loci anchors are allowed to map to
    inputBinding:
      position: 101
      prefix: --winAnchorMultimapNmax
  - id: win_bin_nbits
    type:
      - 'null'
      - int
    doc: =log2(winBin), where winBin is the size of the bin for the 
      windows/clustering, each window will occupy an integer number of bins.
    inputBinding:
      position: 101
      prefix: --winBinNbits
  - id: win_flank_nbins
    type:
      - 'null'
      - int
    doc: log2(winFlank), where win Flank is the size of the left and right 
      flanking regions for each window
    inputBinding:
      position: 101
      prefix: --winFlankNbins
  - id: win_read_coverage_bases_min
    type:
      - 'null'
      - int
    doc: '>0: minimum number of bases covered by the seeds in a window , for STARlong
      algorithm only.'
    inputBinding:
      position: 101
      prefix: --winReadCoverageBasesMin
  - id: win_read_coverage_relative_min
    type:
      - 'null'
      - float
    doc: minimum relative coverage of the read sequence by the seeds in a 
      window, for STARlong algorithm only.
    inputBinding:
      position: 101
      prefix: --winReadCoverageRelativeMin
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rna-star:v2.7.0adfsg-1-deb_cv1
stdout: rna-star_STAR.out
