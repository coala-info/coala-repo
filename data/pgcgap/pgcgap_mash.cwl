cwlVersion: v1.2
class: CommandLineTool
baseCommand: pgcgap
label: pgcgap_mash
doc: "The prokaryotic genomics and comparative genomics analysis pipeline\n\nTool
  homepage: https://github.com/liaochenlanruo/pgcgap/blob/master/README.md"
inputs:
  - id: aas_path
    type: Directory
    doc: Amino acids of all strains as fasta file paths
    default: ./Results/Annotations/AAs
    inputBinding:
      position: 101
      prefix: --AAsPath
  - id: abricate_bin
    type:
      - 'null'
      - File
    doc: Path to abricate binary file. Default tries if abricate is in PATH;
    inputBinding:
      position: 101
      prefix: --abricate-bin
  - id: abyss_bin
    type:
      - 'null'
      - File
    doc: Path to abyss binary file. Default tries if abyss is in PATH;
    inputBinding:
      position: 101
      prefix: --abyss-bin
  - id: acc
    type:
      - 'null'
      - boolean
    doc: Other useful gadgets
    inputBinding:
      position: 101
      prefix: --ACC
  - id: alignment_coverage_longer
    type:
      - 'null'
      - float
    doc: Alignment coverage for the longer sequence. If set to 0.9, the 
      alignment must covers 90% of the sequence
    default: 0.5
    inputBinding:
      position: 101
      prefix: -aL
  - id: alignment_coverage_shorter
    type:
      - 'null'
      - float
    doc: Alignment coverage for the shorter sequence. If set to 0.9, the 
      alignment must covers 90% of the sequence
    default: 0.7
    inputBinding:
      position: 101
      prefix: -aS
  - id: all
    type:
      - 'null'
      - boolean
    doc: Perform Assemble, Annotate, CoreTree, Pan, OrthoF, ANI, MASH, AntiRes 
      and pCOG functions with one command
    inputBinding:
      position: 101
      prefix: --All
  - id: ani
    type:
      - 'null'
      - boolean
    doc: Compute whole-genome Average Nucleotide Identity ( ANI )
    inputBinding:
      position: 101
      prefix: --ANI
  - id: annotate
    type:
      - 'null'
      - boolean
    doc: Genome annotation
    inputBinding:
      position: 101
      prefix: --Annotate
  - id: anti_res
    type:
      - 'null'
      - boolean
    doc: Screening for antimicrobial and virulence genes
    inputBinding:
      position: 101
      prefix: --AntiRes
  - id: assemble
    type:
      - 'null'
      - boolean
    doc: Assemble reads (short, long or hybrid) into contigs
    inputBinding:
      position: 101
      prefix: --Assemble
  - id: assembler
    type: string
    doc: Software used for illumina reads assembly, "abyss", "spades" and "auto"
      available
    default: auto
    inputBinding:
      position: 101
      prefix: --assembler
  - id: assess
    type:
      - 'null'
      - string
    doc: Filter short sequences in the genome and assess the status of the 
      genome.
    inputBinding:
      position: 101
      prefix: --Assess
  - id: bsnum
    type: int
    doc: Replicates for bootstrap of IQ-TREE.
    default: 500
    inputBinding:
      position: 101
      prefix: --bsnum
  - id: canu_bin
    type:
      - 'null'
      - File
    doc: Path to canu binary file. Default tries if canu is in PATH;
    inputBinding:
      position: 101
      prefix: --canu-bin
  - id: cd_hit_bin
    type:
      - 'null'
      - File
    doc: Path to cd-hit binary file. Default tries if cd-hit is in PATH;
    inputBinding:
      position: 101
      prefix: --cd-hit-bin
  - id: cds_path
    type: Directory
    doc: CDs of all strains as fasta file paths
    default: ./Results/Annotations/CDs
    inputBinding:
      position: 101
      prefix: --CDsPath
  - id: check_external_programs
    type:
      - 'null'
      - boolean
    doc: Check if all of the required external programs can be found and are 
      executable, then exit
    inputBinding:
      position: 101
      prefix: --check-external-programs
  - id: check_update
    type:
      - 'null'
      - boolean
    doc: Check if there is a new version of PGCGAP that can be upgraded
    inputBinding:
      position: 101
      prefix: --check-update
  - id: cluster_mode
    type:
      - 'null'
      - int
    doc: If set to 0, a sequence is clustered to the first cluster that meets 
      the threshold (fast cluster). If set to 1, the program will cluster it 
      into the most similar cluster that meets the threshold (accurate but slow 
      mode, Default 1)
    default: 1
    inputBinding:
      position: 101
      prefix: -g
  - id: codon
    type: int
    doc: Translation table
    default: 11
    inputBinding:
      position: 101
      prefix: --codon
  - id: column
    type:
      - 'null'
      - int
    doc: 'Parameter for getRepeats, specify which column is used for the calculation
      (default: 0 for the whole line).'
    default: 0
    inputBinding:
      position: 101
      prefix: --column
  - id: core_tree
    type:
      - 'null'
      - boolean
    doc: Construct single-copy core proteins tree and core SNPs tree
    inputBinding:
      position: 101
      prefix: --CoreTree
  - id: coverage_threshold
    type: int
    doc: Minimum %coverage to keep the result, should be a number between 0 to 
      100.
    default: 50
    inputBinding:
      position: 101
      prefix: --coverage
  - id: database
    type: string
    doc: 'The database to use, options: all, argannot, card, ecoh, ecoli_vf, megares,
      ncbi, plasmidfinder, resfinder and vfdb.'
    default: all
    inputBinding:
      position: 101
      prefix: --db
  - id: description_length
    type:
      - 'null'
      - int
    doc: length of description in .clstr file. if set to 0, it takes the fasta 
      defline and stops at first space
    default: 0
    inputBinding:
      position: 101
      prefix: -d
  - id: evalue
    type: float
    doc: maximum e-value to report alignments
    default: 0.001
    inputBinding:
      position: 101
      prefix: --evalue
  - id: fastani_bin
    type:
      - 'null'
      - File
    doc: Path to the fastANI binary file. Default tries if fastANI is in PATH;
    inputBinding:
      position: 101
      prefix: --fastANI-bin
  - id: fastboot
    type: int
    doc: Replicates for ultrafast bootstrap of IQ-TREE. ( must >= 1000
    default: 1000
    inputBinding:
      position: 101
      prefix: --fastboot
  - id: fasttree
    type:
      - 'null'
      - boolean
    doc: Use FastTree to construct phylogenetic tree quickly instead of IQ-TREE.
    inputBinding:
      position: 101
      prefix: --fasttree
  - id: filein
    type:
      - 'null'
      - string
    doc: Parameter for getRepeats, specify the input file.
    inputBinding:
      position: 101
      prefix: --filein
  - id: filter_length
    type: int
    doc: Sequences shorter than the 'filter_length' will be deleted from the 
      assembled genomes
    default: 200
    inputBinding:
      position: 101
      prefix: --filter_length
  - id: genome_size
    type: string
    doc: An estimate of the size of the genome. Common suffixes are allowed, for
      example, 3.7m or 2.8g. Needed by PacBio data and Oxford data
    default: Unset
    inputBinding:
      position: 101
      prefix: --genomeSize
  - id: genus
    type:
      - 'null'
      - string
    doc: Genus name of the strain
    default: NA
    inputBinding:
      position: 101
      prefix: --genus
  - id: get_repeats
    type:
      - 'null'
      - string
    doc: Counts the number of repeats of the string for the specified column in 
      a given file.
    inputBinding:
      position: 101
      prefix: --getRepeats
  - id: gff_path
    type: Directory
    doc: Gff files of all strains as paths
    default: ./Results/Annotations/GFF
    inputBinding:
      position: 101
      prefix: --GffPath
  - id: global_local_identity
    type:
      - 'null'
      - int
    doc: Use global (set to 1) or local (set to 0) sequence identity
    default: 0
    inputBinding:
      position: 101
      prefix: -G
  - id: hout
    type: string
    doc: Output directory for hybrid assembly
    default: ../../Results/Assembles/Hybrid
    inputBinding:
      position: 101
      prefix: --hout
  - id: id2seq
    type:
      - 'null'
      - string
    doc: Extract the corresponding sequences from a file to another file 
      according to a number of ids in one file.
    inputBinding:
      position: 101
      prefix: --id2seq
  - id: identity
    type:
      - 'null'
      - float
    doc: Minimum percentage identity for blastp
    default: 0.95
    inputBinding:
      position: 101
      prefix: --identi
  - id: identity_threshold
    type: int
    doc: Minimum %identity to keep the result, should be a number between 1 to 
      100.
    default: 75
    inputBinding:
      position: 101
      prefix: --identity
  - id: ids
    type:
      - 'null'
      - string
    doc: Parameter for id2seq, specify the file containing the IDs of sequences,
      if the file has multiple columns, space or tab should be used to separate 
      the columns.
    inputBinding:
      position: 101
      prefix: --ids
  - id: iqtree_bin
    type:
      - 'null'
      - File
    doc: Path to iqtree binary file. Default tries if iqtree is in PATH;
    inputBinding:
      position: 101
      prefix: --iqtree-bin
  - id: kmmer
    type: int
    doc: k-mer size for genome assembly of Illumina data with abyss
    default: 81
    inputBinding:
      position: 101
      prefix: --kmmer
  - id: length_threshold
    type:
      - 'null'
      - int
    doc: Threshold to keep a read based on length after trimming.
    default: 20
    inputBinding:
      position: 101
      prefix: --length
  - id: logs
    type:
      - 'null'
      - string
    doc: Name of the log file
    default: Logs.txt
    inputBinding:
      position: 101
      prefix: --logs
  - id: long
    type: string
    doc: FASTQ or FASTA file of long reads. Needed by hybrid assembly
    default: Unset
    inputBinding:
      position: 101
      prefix: --long
  - id: mafft_bin
    type:
      - 'null'
      - File
    doc: Path to mafft binary file. Default tries if mafft is in PATH;
    inputBinding:
      position: 101
      prefix: --mafft-bin
  - id: mash
    type:
      - 'null'
      - boolean
    doc: Genome and metagenome similarity estimation using MinHash
    inputBinding:
      position: 101
      prefix: --MASH
  - id: mash_bin
    type:
      - 'null'
      - File
    doc: Path to mash binary file. Default tries if mash is in PATH;
    inputBinding:
      position: 101
      prefix: --mash-bin
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: The minimum number of reads covering a site to be considered
    default: 10
    inputBinding:
      position: 101
      prefix: --mincov
  - id: min_fraction
    type:
      - 'null'
      - float
    doc: The minimum proportion of those reads which must differ from the 
      reference
    default: 0.9
    inputBinding:
      position: 101
      prefix: --minfrac
  - id: min_identity
    type: int
    doc: minimum identity% to report an alignment
    default: 40
    inputBinding:
      position: 101
      prefix: --id
  - id: min_query_cover
    type: int
    doc: minimum query cover%
    default: 70
    inputBinding:
      position: 101
      prefix: --query_cover
  - id: min_subject_cover
    type: int
    doc: minimum subject cover%
    default: 50
    inputBinding:
      position: 101
      prefix: --subject_cover
  - id: min_variant_quality
    type:
      - 'null'
      - int
    doc: The minimum VCF variant call "quality"
    default: 100
    inputBinding:
      position: 101
      prefix: --minqual
  - id: muscle_bin
    type:
      - 'null'
      - File
    doc: Path to nuscle binary file. Default tries if muscle in PATH;
    inputBinding:
      position: 101
      prefix: --muscle-bin
  - id: ortho_f
    type:
      - 'null'
      - boolean
    doc: Identify orthologous protein sequence families
    inputBinding:
      position: 101
      prefix: --OrthoF
  - id: orthofinder_bin
    type:
      - 'null'
      - File
    doc: Path to the orthofinder binary file. Default tries if orthofinder is in
      PATH;
    inputBinding:
      position: 101
      prefix: --orthofinder-bin
  - id: pal2nal_bin
    type:
      - 'null'
      - File
    doc: Path to the pal2nal.pl binary file. Default tries if pal2nal.pl is in 
      PATH;
    inputBinding:
      position: 101
      prefix: --pal2nal-bin
  - id: pan
    type:
      - 'null'
      - boolean
    doc: Run "panaroo" pan genome pipeline with gff3 files, and construct a 
      phylogenetic tree with the sing-copy core proteins called by panaroo
    inputBinding:
      position: 101
      prefix: --Pan
  - id: panaroo_bin
    type:
      - 'null'
      - File
    doc: Path to the Panaroo binary file. Default tries if Panaroo is in PATH;
    inputBinding:
      position: 101
      prefix: --panaroo-bin
  - id: pcog
    type:
      - 'null'
      - boolean
    doc: Run COG annotation for each strain (*.faa), and generate a table 
      containing the relative abundance of each flag for all strains
    inputBinding:
      position: 101
      prefix: --pCOG
  - id: platform
    type: string
    doc: Sequencing Platform, "illumina", "pacbio", "oxford" and "hybrid" 
      available
    default: illumina
    inputBinding:
      position: 101
      prefix: --platform
  - id: prodigal_bin
    type:
      - 'null'
      - File
    doc: Path to prodigal binary file. Default tries if prodigal is in PATH;
    inputBinding:
      position: 101
      prefix: --prodigal-bin
  - id: prokka_bin
    type:
      - 'null'
      - File
    doc: Path to prokka binary file. Default tries if prokka is in PATH;
    inputBinding:
      position: 101
      prefix: --prokka-bin
  - id: quality_threshold
    type:
      - 'null'
      - int
    doc: Threshold for trimming based on average quality in a window.
    default: 20
    inputBinding:
      position: 101
      prefix: --qual
  - id: quality_type
    type: string
    doc: Type of quality values (solexa (CASAVA < 1.3), illumina (CASAVA 1.3 to 
      1.7), sanger (which is CASAVA >= 1.8)).
    default: sanger
    inputBinding:
      position: 101
      prefix: --qualtype
  - id: query_list
    type: File
    doc: The file containing full paths to query genomes, one per line
    default: scaf.list
    inputBinding:
      position: 101
      prefix: --queryL
  - id: ram_limit
    type:
      - 'null'
      - int
    doc: Try and keep RAM under this many GB
    default: 8
    inputBinding:
      position: 101
      prefix: --ram
  - id: reads1
    type: string
    doc: 'The suffix name of reads 1 ( for example: if the name of reads 1 is "YBT-1520_L1_I050.R1.clean.fastq.gz",
      "YBT-1520" is the strain same, so the suffix name should be ".R1.clean.fastq.gz"
      )'
    inputBinding:
      position: 101
      prefix: --reads1
  - id: reads2
    type: string
    doc: 'The suffix name of reads 2( for example: if the name of reads 2 is "YBT-1520_2.fq",
      the suffix name should be _2.fq" )'
    inputBinding:
      position: 101
      prefix: --reads2
  - id: reads_path
    type: Directory
    doc: Reads of all strains as file paths
    default: ./Reads/Illumina
    inputBinding:
      position: 101
      prefix: --ReadsPath
  - id: redundance_tolerance
    type:
      - 'null'
      - int
    doc: Tolerance for redundance
    default: 0
    inputBinding:
      position: 101
      prefix: -t
  - id: reference_gbk
    type: File
    doc: 'The full path and name of reference genome in GENBANK format (recommended),
      fasta format is also OK. For example: "/mnt/g/test/ref.gbk"'
    inputBinding:
      position: 101
      prefix: --refgbk
  - id: reference_list
    type: File
    doc: The file containing full paths to reference genomes, one per line.
    default: scaf.list
    inputBinding:
      position: 101
      prefix: --refL
  - id: scaf_path
    type: Directory
    doc: Path for contigs/scaffolds
    default: Results/Assembles/Scaf/Illumina
    inputBinding:
      position: 101
      prefix: --scafPath
  - id: scaf_suffix
    type: string
    doc: The suffix of scaffolds or genome files. This is an important parameter
      that must be set
    default: .filtered.fas
    inputBinding:
      position: 101
      prefix: --Scaf_suffix
  - id: search_program
    type:
      - 'null'
      - string
    doc: 'Sequence search program, Options: blast, mmseqs, blast_gz, diamond'
    default: diamond
    inputBinding:
      position: 101
      prefix: --Sprogram
  - id: separator
    type:
      - 'null'
      - string
    doc: 'Parameter for getRepeats, specify the separator (space, tab, comma, semicolon)
      between columns (Default: tab).'
    default: "\t"
    inputBinding:
      position: 101
      prefix: --sep
  - id: seqin
    type:
      - 'null'
      - string
    doc: Parameter for id2seq, specify the FASTA format file that contains the 
      sequence.
    inputBinding:
      position: 101
      prefix: --seqin
  - id: seqout
    type:
      - 'null'
      - string
    doc: Parameter for id2seq, specify the name of the output file that will be 
      used to save the extracted sequences according to the user-supplied IDs.
    inputBinding:
      position: 101
      prefix: --seqout
  - id: sequence_file
    type:
      - 'null'
      - string
    doc: Path of the sequence file for analysis.
    inputBinding:
      position: 101
      prefix: --seqfile
  - id: sequence_identity_threshold
    type:
      - 'null'
      - float
    doc: Sequence identity threshold
    default: 0.5
    inputBinding:
      position: 101
      prefix: -c
  - id: sequence_type
    type:
      - 'null'
      - string
    doc: Type Of Sequence (p, d, c for Protein, DNA, Codons, respectively).
    default: p
    inputBinding:
      position: 101
      prefix: --seqtype
  - id: setup_cogdb
    type:
      - 'null'
      - boolean
    doc: Setup COG database. Users should execute "pgcgap --setup-COGdb" after 
      the first installation of pgcgap
    inputBinding:
      position: 101
      prefix: --setup-COGdb
  - id: setup_cogdb2
    type:
      - 'null'
      - boolean
    doc: Alternate method to setup COG database. This option can be used to 
      download and setup the COG database when network access is not available 
      with 'setup-COGdb'
    inputBinding:
      position: 101
      prefix: --setup-COGdb2
  - id: short1
    type: string
    doc: FASTQ file of first short reads in each pair. Needed by hybrid assembly
    default: Unset
    inputBinding:
      position: 101
      prefix: --short1
  - id: short2
    type: string
    doc: FASTQ file of second short reads in each pair. Needed by hybrid 
      assembly
    default: Unset
    inputBinding:
      position: 101
      prefix: --short2
  - id: sickle_bin
    type:
      - 'null'
      - File
    doc: Path to the sickle-trim binary file. Default tries if sickle is in 
      PATH;
    inputBinding:
      position: 101
      prefix: --sickle-bin
  - id: snippy_bin
    type:
      - 'null'
      - File
    doc: Path to the snippy binary file. Default tries if snippy is in PATH;
    inputBinding:
      position: 101
      prefix: --snippy-bin
  - id: snp_sites_bin
    type:
      - 'null'
      - File
    doc: Path to the snp-sites binary file. Default tries if snp-sites is in 
      PATH;
    inputBinding:
      position: 101
      prefix: --snp-sites-bin
  - id: species
    type:
      - 'null'
      - string
    doc: Species name of the strain
    default: NA
    inputBinding:
      position: 101
      prefix: --species
  - id: strain_num
    type: int
    doc: The total number of strains used for analysis, not including the 
      reference genome
    inputBinding:
      position: 101
      prefix: --strain_num
  - id: stree
    type:
      - 'null'
      - boolean
    doc: Construct a phylogenetic tree based on multiple sequences in one file
    inputBinding:
      position: 101
      prefix: --STREE
  - id: suffix_len
    type: int
    doc: (Strongly recommended) The suffix length of the reads file, that is the
      length of the reads name minus the length of the strain name. For example 
      the --suffix_len of "YBT-1520_L1_I050.R1.clean.fastq.gz" is 26 ( 
      "YBT-1520" is the strain name )
    default: 0
    inputBinding:
      position: 101
      prefix: --suffix_len
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to be used
    default: 4
    inputBinding:
      position: 101
      prefix: --threads
  - id: trimal_bin
    type:
      - 'null'
      - File
    doc: Path to trimAL binary file. Default tries if trimAL is in PATH;
    inputBinding:
      position: 101
      prefix: --trimAL-bin
  - id: unicycler_bin
    type:
      - 'null'
      - File
    doc: Path to unicycler binary file. Default tries if unicycler is in PATH;
    inputBinding:
      position: 101
      prefix: --unicycler-bin
  - id: var
    type:
      - 'null'
      - boolean
    doc: Rapid haploid variant calling and core genome alignment
    inputBinding:
      position: 101
      prefix: --VAR
  - id: word_length
    type:
      - 'null'
      - int
    doc: Word_length, -n 2 for thresholds 0.4-0.5, -n 3 for thresholds 0.5-0.6, 
      -n 4 for thresholds 0.6-0.7, -n 5 for thresholds 0.7-1.0
    default: 2
    inputBinding:
      position: 101
      prefix: -n
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgcgap:1.0.35--pl5321hdfd78af_1
stdout: pgcgap_mash.out
