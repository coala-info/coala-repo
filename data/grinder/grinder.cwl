cwlVersion: v1.2
class: CommandLineTool
baseCommand: grinder
label: grinder
doc: "Generates simulated shotgun or amplicon sequencing reads from reference sequences.\n\
  \nTool homepage: https://github.com/rcoh/angle-grinder"
inputs:
  - id: abundance_file
    type:
      - 'null'
      - File
    doc: Specify the relative abundance of the reference sequences manually in 
      an input file. Each line of the file should contain a sequence name and 
      its relative abundance (%), e.g. 'seqABC 82.1' or 'seqABC 82.1 10.2' if 
      you are specifying two different libraries.
    inputBinding:
      position: 101
      prefix: -abundance_file
  - id: abundance_model
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Relative abundance model for the input reference sequences: uniform, linear,
      powerlaw, logarithmic or exponential. The uniform and linear models do not require
      a parameter, but the other models take a parameter in the range [0, infinity).
      If this parameter is not specified, then it is randomly chosen.'
    default: uniform 1
    inputBinding:
      position: 101
      prefix: -abundance_model
  - id: base_name
    type:
      - 'null'
      - string
    doc: Prefix of the output files.
    default: grinder
    inputBinding:
      position: 101
      prefix: -base_name
  - id: chimera_dist
    type:
      - 'null'
      - type: array
        items: string
    doc: "Specify the distribution of chimeras: bimeras, trimeras, quadrameras and
      multimeras of higher order. The default is the average values from Quince et
      al. 2011: '314 38 1', which corresponds to 89% of bimeras, 11% of trimeras and
      0.3% of quadrameras. Note that this option only takes effect when you request
      the generation of chimeras with the <chimera_perc> option."
    default: 314 38 1
    inputBinding:
      position: 101
      prefix: -chimera_dist
  - id: chimera_kmer
    type:
      - 'null'
      - int
    doc: Activate a method to form chimeras by picking breakpoints at places 
      where k-mers are shared between sequences. <chimera_kmer> represents k, 
      the length of the k-mers (in bp). The longer the kmer, the more similar 
      the sequences have to be to be eligible to form chimeras. The more 
      frequent a k-mer is in the pool of reference sequences (taking into 
      account their relative abundance), the more often this k-mer will be 
      chosen. For example, CHSIM (Edgar et al. 2011) uses this method with a 
      k-mer length of 10 bp. If you do not want to use k-mer information to form
      chimeras, use 0, which will result in the reference sequences and 
      breakpoints to be taken randomly on the "aligned" reference sequences. 
      Note that this option only takes effect when you request the generation of
      chimeras with the <chimera_perc> option. Also, this options is quite 
      memory intensive, so you should probably limit yourself to a relatively 
      small number of reference sequences if you want to use it.
    default: 10
    inputBinding:
      position: 101
      prefix: -chimera_kmer
  - id: chimera_perc
    type:
      - 'null'
      - float
    doc: Specify the percent of reads in amplicon libraries that should be 
      chimeric sequences. The 'reference' field in the description of chimeric 
      reads will contain the ID of all the reference sequences forming the 
      chimeric template. A typical value is 10% for amplicons. This option can 
      be used to generate chimeric shotgun reads as well.
    default: 0
    inputBinding:
      position: 101
      prefix: -chimera_perc
  - id: copy_bias
    type:
      - 'null'
      - int
    doc: 'In amplicon libraries where full genomes are used as input, sample species
      proportionally to the number of copies of the target gene: at equal relative
      abundance, genomes that have multiple copies of the target gene contribute more
      amplicon reads than genomes that have a single copy. 0 = no, 1 = yes.'
    default: 1
    inputBinding:
      position: 101
      prefix: -copy_bias
  - id: coverage_fold
    type:
      - 'null'
      - float
    doc: Desired fold coverage of the input reference sequences (the output 
      FASTA length divided by the input FASTA length). Do not specify this if 
      you specify the number of reads directly.
    inputBinding:
      position: 101
      prefix: -coverage_fold
  - id: delete_chars
    type:
      - 'null'
      - string
    doc: Remove the specified characters from the reference sequences 
      (case-insensitive), e.g. '-~*' to remove gaps (- or ~) or terminator (*). 
      Removing these characters is done once, when reading the reference 
      sequences, prior to taking reads. Hence it is more efficient than 
      <exclude_chars>.
    default: ''
    inputBinding:
      position: 101
      prefix: -delete_chars
  - id: desc_track
    type:
      - 'null'
      - int
    doc: Track read information (reference sequence, position, errors, ...) by 
      writing it in the read description.
    default: 1
    inputBinding:
      position: 101
      prefix: -desc_track
  - id: diversity
    type:
      - 'null'
      - type: array
        items: string
    doc: This option specifies alpha diversity, specifically the richness, i.e. 
      number of reference sequences to take randomly and include in each 
      library. Use 0 for the maximum richness possible (based on the number of 
      reference sequences available). Provide one value to make all libraries 
      have the same diversity, or one richness value per library otherwise.
    default: '0'
    inputBinding:
      position: 101
      prefix: -diversity
  - id: exclude_chars
    type:
      - 'null'
      - string
    doc: Do not create reads containing any of the specified characters (case 
      insensitive). For example, use 'NX' to prevent reads with ambiguities (N 
      or X). Grinder will error if it fails to find a suitable read (or pair of 
      reads) after 10 attempts. Consider using <delete_chars>, which may be more
      appropriate for your case.
    default: ''
    inputBinding:
      position: 101
      prefix: -exclude_chars
  - id: fastq_output
    type:
      - 'null'
      - boolean
    doc: 'Whether to write the generated reads in FASTQ format (with Sanger-encoded
      quality scores) instead of FASTA and QUAL or not (1: yes, 0: no). <qual_levels>
      need to be specified for this option to be effective.'
    default: false
    inputBinding:
      position: 101
      prefix: -fastq_output
  - id: forward_reverse
    type:
      - 'null'
      - File
    doc: Use DNA amplicon sequencing using a forward and reverse PCR primer 
      sequence provided in a FASTA file. The reference sequences and their 
      reverse complement will be searched for PCR primer matches. The primer 
      sequences should use the IUPAC convention for degenerate residues and the 
      reference sequences that that do not match the specified primers are 
      excluded. If your reference sequences are full genomes, it is recommended 
      to use <copy_bias> = 1 and <length_bias> = 0 to generate amplicon reads. 
      To sequence from the forward strand, set <unidirectional> to 1 and put the
      forward primer first and reverse primer second in the FASTA file. To 
      sequence from the reverse strand, invert the primers in the FASTA file and
      use <unidirectional> = -1. The second primer sequence in the FASTA file is
      always optional.
    inputBinding:
      position: 101
      prefix: -forward_reverse
  - id: homopolymer_dist
    type:
      - 'null'
      - int
    doc: Introduce sequencing errors in the reads under the form of 
      homopolymeric stretches (e.g. AAA, CCCCC) using a specified model where 
      the homopolymer length follows a normal distribution N(mean, standard 
      deviation) that is function of the homopolymer length n
    default: 0
    inputBinding:
      position: 101
      prefix: -homopolymer_dist
  - id: insert_dist
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Create paired-end or mate-pair reads spanning the given insert length. Important:
      the insert is defined in the biological sense, i.e. its length includes the
      length of both reads and of the stretch of DNA between them: 0 : off, or: insert
      size distribution in bp, in the same format as the read length distribution
      (a typical value is 2,500 bp for mate pairs)'
    default: '0'
    inputBinding:
      position: 101
      prefix: -insert_dist
  - id: length_bias
    type:
      - 'null'
      - int
    doc: In shotgun libraries, sample reference sequences proportionally to 
      their length. For example, in simulated microbial datasets, this means 
      that at the same relative abundance, larger genomes contribute more reads 
      than smaller genomes (and all genomes have the same fold coverage). 0 = 
      no, 1 = yes.
    default: 1
    inputBinding:
      position: 101
      prefix: -length_bias
  - id: mate_orientation
    type:
      - 'null'
      - string
    doc: 'When generating paired-end or mate-pair reads (see <insert_dist>), specify
      the orientation of the reads (F: forward, R: reverse): FR: ---> <--- e.g. Sanger,
      Illumina paired-end, IonTorrent mate-pair FF: ---> ---> e.g. 454 RF: <--- --->
      e.g. Illumina mate-pair RR: <--- <---'
    default: FR
    inputBinding:
      position: 101
      prefix: -mate_orientation
  - id: multiplex_mids
    type:
      - 'null'
      - File
    doc: Specify an optional FASTA file that contains multiplex sequence 
      identifiers (a.k.a MIDs or barcodes) to add to the sequences (one sequence
      per library, in the order given). The MIDs are included in the length 
      specified with the -read_dist option and can be altered by sequencing 
      errors. See the MIDesigner or BarCrawl programs to generate MID sequences.
    inputBinding:
      position: 101
      prefix: -multiplex_mids
  - id: mutation_dist
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Introduce sequencing errors in the reads, under the form of mutations (substitutions,
      insertions and deletions) at positions that follow a specified distribution
      (with replacement): model (uniform, linear, poly4), model parameters.'
    default: uniform 0 0
    inputBinding:
      position: 101
      prefix: -mutation_dist
  - id: mutation_ratio
    type:
      - 'null'
      - type: array
        items: string
    doc: Indicate the percentage of substitutions and the number of indels 
      (insertions and deletions). For example, use '80 20' (4 substitutions for 
      each indel) for Sanger reads. Note that this parameter has no effect 
      unless you specify the <mutation_dist> option.
    default: 80 20
    inputBinding:
      position: 101
      prefix: -mutation_ratio
  - id: num_libraries
    type:
      - 'null'
      - int
    doc: Number of independent libraries to create. Specify how diverse and 
      similar they should be with <diversity>, <shared_perc> and 
      <permuted_perc>. Assign them different MID tags with <multiplex_mids>.
    default: 1
    inputBinding:
      position: 101
      prefix: -num_libraries
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory where the results should be written. This folder will be 
      created if needed.
    default: .
    inputBinding:
      position: 101
      prefix: -output_dir
  - id: permuted_perc
    type:
      - 'null'
      - float
    doc: This option controls another aspect of beta-diversity. For multiple 
      libraries, choose the percent of the most-abundant reference sequences to 
      permute (randomly shuffle) the rank-abundance of.
    default: 100
    inputBinding:
      position: 101
      prefix: -permuted_perc
  - id: profile_file
    type:
      - 'null'
      - File
    doc: A file that contains Grinder arguments. This is useful if you use many 
      options or often use the same options. Lines with comments (#) are 
      ignored.
    inputBinding:
      position: 101
      prefix: -profile_file
  - id: qual_levels
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Generate basic quality scores for the simulated reads. Good residues are
      given a specified good score (e.g. 30) and residues that are the result of an
      insertion or substitution are given a specified bad score (e.g. 10). Specify
      first the good score and then the bad score on the command-line, e.g.: 30 10.'
    inputBinding:
      position: 101
      prefix: -qual_levels
  - id: random_seed
    type:
      - 'null'
      - int
    doc: Seed number to use for the pseudo-random number generator.
    inputBinding:
      position: 101
      prefix: -random_seed
  - id: read_dist
    type:
      - 'null'
      - type: array
        items: string
    doc: "Desired shotgun or amplicon read length distribution specified as: average
      length, distribution ('uniform' or 'normal') and standard deviation."
    default: '100'
    inputBinding:
      position: 101
      prefix: -read_dist
  - id: reference_file
    type: File
    doc: FASTA file that contains the input reference sequences (full genomes, 
      16S rRNA genes, transcripts, proteins...) or '-' to read them from the 
      standard input.
    inputBinding:
      position: 101
      prefix: -reference_file
  - id: reference_file
    type: File
    doc: FASTA file that contains the input reference sequences (full genomes, 
      16S rRNA genes, transcripts, proteins...) or '-' to read them from the 
      standard input.
    inputBinding:
      position: 101
      prefix: -genome_file
  - id: shared_perc
    type:
      - 'null'
      - float
    doc: This option controls an aspect of beta-diversity. When creating 
      multiple libraries, specify the percent of reference sequences they should
      have in common (relative to the diversity of the least diverse library).
    default: 0
    inputBinding:
      position: 101
      prefix: -shared_perc
  - id: total_reads
    type:
      - 'null'
      - int
    doc: Number of shotgun or amplicon reads to generate for each library. Do 
      not specify this if you specify the fold coverage.
    default: 100
    inputBinding:
      position: 101
      prefix: -total_reads
  - id: unidirectional
    type:
      - 'null'
      - int
    doc: 'Instead of producing reads bidirectionally, from the reference strand and
      its reverse complement, proceed unidirectionally, from one strand only (forward
      or reverse). Values: 0 (off, i.e. bidirectional), 1 (forward), -1 (reverse).
      Use <unidirectional> = 1 for amplicon and strand-specific transcriptomic or
      proteomic datasets.'
    default: 0
    inputBinding:
      position: 101
      prefix: -unidirectional
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/grinder:v0.5.4-5-deb_cv1
stdout: grinder.out
