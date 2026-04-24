cwlVersion: v1.2
class: CommandLineTool
baseCommand: gmap
label: gmap
doc: "Aligns DNA or protein sequences to a genome database.\n\nTool homepage: http://research-pub.gene.com/gmap"
inputs:
  - id: fasta_files
    type:
      type: array
      items: File
    doc: FASTA files to align
    inputBinding:
      position: 1
  - id: action_if_cigar_error
    type:
      - 'null'
      - string
    doc: 'Action to take if there is a disagreement between CIGAR length and sequence
      length. Allowed values: ignore, warning (default), noprint, abort. Note that
      the noprint option does not print the CIGAR string at all if there is an error,
      so it may break a SAM parser'
    inputBinding:
      position: 102
      prefix: --action-if-cigar-error
  - id: align
    type:
      - 'null'
      - boolean
    doc: Show alignments
    inputBinding:
      position: 102
      prefix: --align
  - id: align_fraction
    type:
      - 'null'
      - float
    doc: Process only the given fraction of reads, selected at random. If 
      --align-fraction and --part are given, --align-fraction takes precedence
    inputBinding:
      position: 102
      prefix: --align-fraction
  - id: allow_close_indels
    type:
      - 'null'
      - int
    doc: Allow an insertion and deletion close to each other (0=no, 1=yes 
      (default), 2=only for high-quality alignments)
    inputBinding:
      position: 102
      prefix: --allow-close-indels
  - id: alt_start_codons
    type:
      - 'null'
      - boolean
    doc: Also, use the alternate initiation codons shown in the above Web site. 
      By default, without this option, only ATG is considered an initiation 
      codon
    inputBinding:
      position: 102
      prefix: --alt-start-codons
  - id: append_output
    type:
      - 'null'
      - boolean
    doc: When --split-output or --failedinput is given, this flag will append 
      output to the existing files. Otherwise, the default is to create new 
      files.
    inputBinding:
      position: 102
      prefix: --append-output
  - id: atoidir
    type:
      - 'null'
      - Directory
    doc: Directory for A-to-I RNA editing index files (created using atoiindex) 
      (default is location of genome index files specified using -D, -V, and -d)
    inputBinding:
      position: 102
      prefix: --atoidir
  - id: batch_mode
    type:
      - 'null'
      - int
    doc: Batch mode
    inputBinding:
      position: 102
      prefix: --batch
  - id: canonical_mode
    type:
      - 'null'
      - int
    doc: Reward for canonical and semi-canonical introns. 0=low reward, 1=high 
      reward (default), 2=low reward for high-identity sequences and high reward
      otherwise
    inputBinding:
      position: 102
      prefix: --canonical-mode
  - id: cdsstart
    type:
      - 'null'
      - int
    doc: Translate codons from given nucleotide (1-based)
    inputBinding:
      position: 102
      prefix: --cdsstart
  - id: check
    type:
      - 'null'
      - boolean
    doc: Check compiler assumptions
    inputBinding:
      position: 102
      prefix: --check
  - id: chimera_margin
    type:
      - 'null'
      - int
    doc: Amount of unaligned sequence that triggers search for the remaining 
      sequence. Enables alignment of chimeric reads, and may help with some 
      non-chimeric reads. To turn off, set to zero.
    inputBinding:
      position: 102
      prefix: --chimera-margin
  - id: chimera_overlap
    type:
      - 'null'
      - string
    doc: Overlap to show, if any, at chimera breakpoint
    inputBinding:
      position: 102
      prefix: --chimera-overlap
  - id: chrsubset
    type:
      - 'null'
      - string
    doc: Limit search to given chromosome
    inputBinding:
      position: 102
      prefix: --chrsubset
  - id: cmdline_align
    type:
      - 'null'
      - string
    doc: Align these two sequences provided on the command line, first one being
      genomic and second one being cDNA
    inputBinding:
      position: 102
      prefix: --cmdline
  - id: cmetdir
    type:
      - 'null'
      - Directory
    doc: Directory for methylcytosine index files (created using cmetindex) 
      (default is location of genome index files specified using -D, -V, and -d)
    inputBinding:
      position: 102
      prefix: --cmetdir
  - id: continuous
    type:
      - 'null'
      - boolean
    doc: Show alignment in three continuous lines
    inputBinding:
      position: 102
      prefix: --continuous
  - id: continuous_by_exon
    type:
      - 'null'
      - boolean
    doc: Show alignment in three lines per exon
    inputBinding:
      position: 102
      prefix: --continuous-by-exon
  - id: cross_species
    type:
      - 'null'
      - boolean
    doc: Use a more sensitive search for canonical splicing, which helps 
      especially for cross-species alignments and other difficult cases
    inputBinding:
      position: 102
      prefix: --cross-species
  - id: direction
    type:
      - 'null'
      - string
    doc: cDNA direction (sense_force, antisense_force, sense_filter, 
      antisense_filter,or auto (default))
    inputBinding:
      position: 102
      prefix: --direction
  - id: end_trimming_score
    type:
      - 'null'
      - int
    doc: Trim ends if the alignment score is below this value where a match 
      scores +1 and a mismatch scores -3. The value should be 0 (default) or 
      negative. A negative allows some mismatches at the ends of the alignment
    inputBinding:
      position: 102
      prefix: --end-trimming-score
  - id: exons
    type:
      - 'null'
      - string
    doc: Print exons ("cdna" or "genomic"). Will also print introns with 
      "cdna+introns" or "genomic+introns"
    inputBinding:
      position: 102
      prefix: --exons
  - id: failed_input
    type:
      - 'null'
      - string
    doc: Print completely failed alignments as input FASTA or FASTQ format to 
      the given file. If the --split-output flag is also given, this file is 
      generated in addition to the output in the .nomapping file.
    inputBinding:
      position: 102
      prefix: --failed-input
  - id: failsonly
    type:
      - 'null'
      - boolean
    doc: Print only failed alignments, those with no results
    inputBinding:
      position: 102
      prefix: --failsonly
  - id: flanking
    type:
      - 'null'
      - int
    doc: Show flanking hits (default 0)
    inputBinding:
      position: 102
      prefix: --flanking
  - id: force_xs_dir
    type:
      - 'null'
      - boolean
    doc: For RNA-Seq alignments, disallows XS:A:? when the sense direction is 
      unclear, and replaces this value arbitrarily with XS:A:+. May be useful 
      for some programs, such as Cufflinks, that cannot handle XS:A:?. However, 
      if you use this flag, the reported value of XS:A:+ in these cases will not
      be meaningful.
    inputBinding:
      position: 102
      prefix: --force-xs-dir
  - id: fulllength
    type:
      - 'null'
      - boolean
    doc: Assume full-length protein, starting with Met
    inputBinding:
      position: 102
      prefix: --fulllength
  - id: genome_db
    type:
      - 'null'
      - string
    doc: Genome database. If argument is '?', lists available databases.
    inputBinding:
      position: 102
      prefix: --db
  - id: genome_dir
    type:
      - 'null'
      - Directory
    doc: Genome directory.
    inputBinding:
      position: 102
      prefix: --dir
  - id: genomic_segments
    type:
      - 'null'
      - File
    doc: User-supplied genomic segments. If multiple segments are provided, then
      every query sequence is aligned against every genomic segment
    inputBinding:
      position: 102
      prefix: --gseg
  - id: gff3_add_separators
    type:
      - 'null'
      - int
    doc: 'Whether to add a ### separator after each query sequence. Values: 0 (no),
      1 (yes, default)'
    inputBinding:
      position: 102
      prefix: --gff3-add-separators
  - id: gff3_cds
    type:
      - 'null'
      - string
    doc: 'Whether to use cDNA or genomic translation for the CDS coordinates. Values:
      cdna (default), genomic'
    inputBinding:
      position: 102
      prefix: --gff3-cds
  - id: gff3_fasta_annotation
    type:
      - 'null'
      - int
    doc: 'Whether to include annotation from the FASTA header into the GFF3 output.
      Values: 0 (default): Do not include. 1: Wrap all annotation as Annot="<header>".
      2: Include key=value pairs, replacing brackets with quotation marks and replacing
      spaces between key=value pairs with semicolons'
    inputBinding:
      position: 102
      prefix: --gff3-fasta-annotation
  - id: gff3_swap_phase
    type:
      - 'null'
      - int
    doc: 'Whether to swap phase (0 => 0, 1 => 2, 2 => 1) in gff3_gene format. Needed
      by some analysis programs, but deviates from GFF3 specification. Values: 0 (no,
      default), 1 (yes)'
    inputBinding:
      position: 102
      prefix: --gff3-swap-phase
  - id: indel_extend
    type:
      - 'null'
      - string
    doc: In dynamic programming, extension penalty for indel. Values for 
      --indel-open and --indel-extend should be in [-127,-1]. If value is < 
      -127, then will use -127 instead. If --indel-open and --indel-extend are 
      not specified, values are chosen adaptively, based on the differences 
      between the query and reference
    inputBinding:
      position: 102
      prefix: --indel-extend
  - id: indel_open
    type:
      - 'null'
      - string
    doc: In dynamic programming, opening penalty for indel. Values for 
      --indel-open and --indel-extend should be in [-127,-1]. If value is < 
      -127, then will use -127 instead. If --indel-open and --indel-extend are 
      not specified, values are chosen adaptively, based on the differences 
      between the query and reference
    inputBinding:
      position: 102
      prefix: --indel-open
  - id: input_buffer_size
    type:
      - 'null'
      - int
    doc: Size of input buffer (program reads this many sequences at a time for 
      efficiency)
    inputBinding:
      position: 102
      prefix: --input-buffer-size
  - id: introngap
    type:
      - 'null'
      - int
    doc: Nucleotides to show on each end of intron
    inputBinding:
      position: 102
      prefix: --introngap
  - id: invertmode
    type:
      - 'null'
      - int
    doc: "Mode for alignments to genomic (-) strand: 0=Don't invert the cDNA (default),
      1=Invert cDNA and print genomic (-) strand, 2=Invert cDNA and print genomic
      (+) strand"
    inputBinding:
      position: 102
      prefix: --invertmode
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: 'kmer size to use in genome database (allowed values: 16 or less). If not
      specified, the program will find the highest available kmer size in the genome
      database'
    inputBinding:
      position: 102
      prefix: --kmer
  - id: localsplicedist
    type:
      - 'null'
      - int
    doc: Max length for known splice sites at ends of sequence
    inputBinding:
      position: 102
      prefix: --localsplicedist
  - id: map
    type:
      - 'null'
      - string
    doc: Map file. If argument is '?', this lists available map files.
    inputBinding:
      position: 102
      prefix: --map
  - id: mapboth
    type:
      - 'null'
      - boolean
    doc: Report hits from both strands of genome
    inputBinding:
      position: 102
      prefix: --mapboth
  - id: mapdir
    type:
      - 'null'
      - Directory
    doc: Map directory
    inputBinding:
      position: 102
      prefix: --mapdir
  - id: mapexons
    type:
      - 'null'
      - boolean
    doc: Map each exon separately
    inputBinding:
      position: 102
      prefix: --mapexons
  - id: max_deletionlength
    type:
      - 'null'
      - int
    doc: Max length for a deletion. Above this size, a genomic gap will be 
      considered an intron rather than a deletion.
    inputBinding:
      position: 102
      prefix: --max-deletionlength
  - id: max_intronlength_ends
    type:
      - 'null'
      - int
    doc: 'Max length for first or last intron. Note: for backward compatibility, the
      -K or --intronlength flag will set both --max-intronlength-middle and --max-intronlength-ends.'
    inputBinding:
      position: 102
      prefix: --max-intronlength-ends
  - id: max_intronlength_middle
    type:
      - 'null'
      - int
    doc: 'Max length for one internal intron. Note: for backward compatibility, the
      -K or --intronlength flag will set both --max-intronlength-middle and --max-intronlength-ends.
      Also see --split-large-introns below.'
    inputBinding:
      position: 102
      prefix: --max-intronlength-middle
  - id: md5
    type:
      - 'null'
      - boolean
    doc: Print MD5 checksum for each query sequence
    inputBinding:
      position: 102
      prefix: --md5
  - id: md_lowercase_snp
    type:
      - 'null'
      - boolean
    doc: In MD string, when known SNPs are given by the -v flag, prints 
      difference nucleotides as lower-case when they, differ from reference but 
      match a known alternate allele
    inputBinding:
      position: 102
      prefix: --md-lowercase-snp
  - id: microexon_spliceprob
    type:
      - 'null'
      - float
    doc: Allow microexons only if one of the splice site probabilities is 
      greater than this value
    inputBinding:
      position: 102
      prefix: --microexon-spliceprob
  - id: min_identity
    type:
      - 'null'
      - float
    doc: Do not print alignments with identity less this value (default=0.0, 
      which means no filtering). Note that chimeric alignments will be output 
      regardless of this filter
    inputBinding:
      position: 102
      prefix: --min-identity
  - id: min_intronlength
    type:
      - 'null'
      - int
    doc: Min length for one internal intron. Below this size, a genomic gap will
      be considered a deletion rather than an intron.
    inputBinding:
      position: 102
      prefix: --min-intronlength
  - id: min_trimmed_coverage
    type:
      - 'null'
      - float
    doc: Do not print alignments with trimmed coverage less this value 
      (default=0.0, which means no filtering). Note that chimeric alignments 
      will be output regardless of this filter
    inputBinding:
      position: 102
      prefix: --min-trimmed-coverage
  - id: mode
    type:
      - 'null'
      - string
    doc: 'Alignment mode: standard (default), cmet-stranded, cmet-nonstranded, atoi-stranded,
      atoi-nonstranded, ttoc-stranded, or ttoc-nonstranded. Non-standard modes requires
      you to have previously run the cmetindex or atoiindex programs (which also cover
      the ttoc modes) on the genome'
    inputBinding:
      position: 102
      prefix: --mode
  - id: no_chimeras
    type:
      - 'null'
      - boolean
    doc: Turns off finding of chimeras. Same effect as --chimera-margin=0
    inputBinding:
      position: 102
      prefix: --no-chimeras
  - id: no_sam_headers
    type:
      - 'null'
      - boolean
    doc: Do not print headers beginning with '@'
    inputBinding:
      position: 102
      prefix: --no-sam-headers
  - id: nofails
    type:
      - 'null'
      - boolean
    doc: Exclude printing of failed alignments
    inputBinding:
      position: 102
      prefix: --nofails
  - id: nolengths
    type:
      - 'null'
      - boolean
    doc: No intron lengths in alignment
    inputBinding:
      position: 102
      prefix: --nolengths
  - id: nomargin
    type:
      - 'null'
      - boolean
    doc: No left margin in GMAP standard output (with the -A flag)
    inputBinding:
      position: 102
      prefix: --nomargin
  - id: nosplicing
    type:
      - 'null'
      - boolean
    doc: Turns off splicing (useful for aligning genomic sequences onto a 
      genome)
    inputBinding:
      position: 102
      prefix: --nosplicing
  - id: npaths
    type:
      - 'null'
      - int
    doc: Maximum number of paths to show. If set to 1, GMAP will not report 
      chimeric alignments, since those imply two paths. If you want a single 
      alignment plus chimeric alignments, then set this to be 0.
    inputBinding:
      position: 102
      prefix: --npaths
  - id: nthreads
    type:
      - 'null'
      - int
    doc: Number of worker threads
    inputBinding:
      position: 102
      prefix: --nthreads
  - id: ordered
    type:
      - 'null'
      - boolean
    doc: Print output in same order as input (relevant only if there is more 
      than one worker thread)
    inputBinding:
      position: 102
      prefix: --ordered
  - id: output_buffer_size
    type:
      - 'null'
      - int
    doc: Buffer size, in queries, for output thread. When the number of results 
      to be printed exceeds this size, worker threads wait until the backlog is 
      cleared
    inputBinding:
      position: 102
      prefix: --output-buffer-size
  - id: output_format
    type:
      - 'null'
      - int
    doc: 'Other format for output (also note the -A and -S options and other options
      listed under Output types): mask_introns, mask_utr_introns, psl (or 1) = PSL
      (BLAT) format, gff3_gene (or 2) = GFF3 gene format, gff3_match_cdna (or 3) =
      GFF3 cDNA_match format, gff3_match_est (or 4) = GFF3 EST_match format, splicesites
      (or 6) = splicesites output (for GSNAP splicing file), introns = introns output
      (for GSNAP splicing file), map_exons (or 7) = IIT FASTA exon map format, map_ranges
      (or 8) = IIT FASTA range map format, coords (or 9) = coords in table format,
      sampe = SAM format (setting paired_read bit in flag), samse = SAM format (without
      setting paired_read bit), bedpe = indels and gaps in BEDPE format'
    inputBinding:
      position: 102
      prefix: --format
  - id: pairalign
    type:
      - 'null'
      - boolean
    doc: Align two sequences in FASTA format via stdin, first one being genomic 
      and second one being cDNA
    inputBinding:
      position: 102
      prefix: --pairalign
  - id: part
    type:
      - 'null'
      - string
    doc: Process only the i-th out of every n sequences (e.g., 0/100 or 99/100) 
      (useful for distributing jobs to a computer farm).
    inputBinding:
      position: 102
      prefix: --part
  - id: print_comment
    type:
      - 'null'
      - boolean
    doc: Show comment line for each hit
    inputBinding:
      position: 102
      prefix: --print-comment
  - id: protein_dna
    type:
      - 'null'
      - boolean
    doc: Print protein sequence (cDNA)
    inputBinding:
      position: 102
      prefix: --protein_dna
  - id: protein_gen
    type:
      - 'null'
      - boolean
    doc: Print protein sequence (genomic)
    inputBinding:
      position: 102
      prefix: --protein_gen
  - id: prunelevel
    type:
      - 'null'
      - string
    doc: 'Pruning level: 0=no pruning (default), 1=poor seqs, 2=repetitive seqs, 3=poor
      and repetitive'
    inputBinding:
      position: 102
      prefix: --prunelevel
  - id: quality_print_shift
    type:
      - 'null'
      - int
    doc: Shift FASTQ quality scores by this amount in output (default is 0 for 
      sanger protocol; to change Illumina input to Sanger output, select -31)
    inputBinding:
      position: 102
      prefix: --quality-print-shift
  - id: quality_protocol
    type:
      - 'null'
      - string
    doc: 'Protocol for input quality scores. Allowed values: illumina (ASCII 64-126)
      (equivalent to -J 64 -j -31), sanger (ASCII 33-126) (equivalent to -J 33 -j
      0). Default is sanger (no quality print shift). SAM output files should have
      quality scores in sanger protocol. Or you can specify the print shift with this
      flag:'
    inputBinding:
      position: 102
      prefix: --quality-protocol
  - id: read_group_id
    type:
      - 'null'
      - string
    doc: Value to put into read-group id (RG-ID) field
    inputBinding:
      position: 102
      prefix: --read-group-id
  - id: read_group_library
    type:
      - 'null'
      - string
    doc: Value to put into read-group library (RG-LB) field
    inputBinding:
      position: 102
      prefix: --read-group-library
  - id: read_group_name
    type:
      - 'null'
      - string
    doc: Value to put into read-group name (RG-SM) field
    inputBinding:
      position: 102
      prefix: --read-group-name
  - id: read_group_platform
    type:
      - 'null'
      - string
    doc: Value to put into read-group library (RG-PL) field
    inputBinding:
      position: 102
      prefix: --read-group-platform
  - id: sam_extended_cigar
    type:
      - 'null'
      - boolean
    doc: Use extended CIGAR format (using X and = symbols instead of M, to 
      indicate matches and mismatches, respectively
    inputBinding:
      position: 102
      prefix: --sam-extended-cigar
  - id: sam_flipped
    type:
      - 'null'
      - boolean
    doc: Flip the query and genomic positions in the SAM output. Potentially 
      useful with the -g flag when short reads are picked as query sequences and
      longer reads as picked as genomic sequences
    inputBinding:
      position: 102
      prefix: --sam-flipped
  - id: sam_use_0M
    type:
      - 'null'
      - boolean
    doc: Insert 0M in CIGAR between adjacent insertions and deletions. Required 
      by Picard, but can cause errors in other tools
    inputBinding:
      position: 102
      prefix: --sam-use-0M
  - id: sampling
    type:
      - 'null'
      - int
    doc: Sampling to use in genome database. If not specified, the program will 
      find the smallest available sampling value in the genome database within 
      selected k-mer size
    inputBinding:
      position: 102
      prefix: --sampling
  - id: selfalign
    type:
      - 'null'
      - boolean
    doc: Align one sequence against itself in FASTA format via stdin (Useful for
      getting protein translation of a nucleotide sequence)
    inputBinding:
      position: 102
      prefix: --selfalign
  - id: snpsdir
    type:
      - 'null'
      - Directory
    doc: Directory for SNPs index files (created using snpindex) (default is 
      location of genome index files specified using -D and -d)
    inputBinding:
      position: 102
      prefix: --snpsdir
  - id: split_large_introns
    type:
      - 'null'
      - boolean
    doc: Sometimes GMAP will exceed the value for --max-intronlength-middle, if 
      it finds a good single alignment. However, you can force GMAP to split 
      such alignments by using this flag
    inputBinding:
      position: 102
      prefix: --split-large-introns
  - id: split_output
    type:
      - 'null'
      - string
    doc: Basename for multiple-file output, separately for nomapping, uniq, 
      mult, (and chimera, if --chimera-margin is selected)
    inputBinding:
      position: 102
      prefix: --split-output
  - id: strand
    type:
      - 'null'
      - string
    doc: Genome strand to try aligning to (plus, minus, or both default)
    inputBinding:
      position: 102
      prefix: --strand
  - id: suboptimal_score
    type:
      - 'null'
      - float
    doc: Report only paths whose score is within this value of the best path. If
      specified between 0.0 and 1.0, then treated as a fraction of the score of 
      the best alignment (matches minus penalties for mismatches and indels). 
      Otherwise, treated as an integer number to be subtracted from the score of
      the best alignment.
    inputBinding:
      position: 102
      prefix: --suboptimal-score
  - id: summary
    type:
      - 'null'
      - boolean
    doc: Show summary of alignments only
    inputBinding:
      position: 102
      prefix: --summary
  - id: tolerant
    type:
      - 'null'
      - boolean
    doc: Translates cDNA with corrections for frameshifts
    inputBinding:
      position: 102
      prefix: --tolerant
  - id: totallength
    type:
      - 'null'
      - int
    doc: Max total intron length
    inputBinding:
      position: 102
      prefix: --totallength
  - id: translation_code
    type:
      - 'null'
      - int
    doc: Genetic code used for translating codons to amino acids and computing 
      CDS. Integer value (default=1) corresponds to an available code at 
      http://www.ncbi.nlm.nih.gov/Taxonomy/Utils/wprintgc.cgi
    inputBinding:
      position: 102
      prefix: --translation-code
  - id: trim_end_exons
    type:
      - 'null'
      - int
    doc: Trim end exons with fewer than given number of matches (in nt, default 
      12)
    inputBinding:
      position: 102
      prefix: --trim-end-exons
  - id: truncate
    type:
      - 'null'
      - boolean
    doc: Truncate alignment around full-length protein, Met to Stop. Implies -F 
      flag.
    inputBinding:
      position: 102
      prefix: --truncate
  - id: use_shared_memory
    type:
      - 'null'
      - int
    doc: If 1, then allocated memory is shared among all processes on this node.
      If 0 (default), then each process has private allocated memory
    inputBinding:
      position: 102
      prefix: --use-shared-memory
  - id: use_snps
    type:
      - 'null'
      - string
    doc: Use database containing known SNPs (in <STRING>.iit, built previously 
      using snpindex) for tolerance to SNPs
    inputBinding:
      position: 102
      prefix: --use-snps
  - id: wraplength
    type:
      - 'null'
      - int
    doc: Wrap length for alignment
    inputBinding:
      position: 102
      prefix: --wraplength
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gmap:2025.07.31--pl5321hb1d24b7_1
stdout: gmap.out
