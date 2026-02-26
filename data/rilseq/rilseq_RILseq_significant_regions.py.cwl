cwlVersion: v1.2
class: CommandLineTool
baseCommand: RILseq_significant_regions.py
label: rilseq_RILseq_significant_regions.py
doc: "Find over-represented regions of interactions.\n\nTool homepage: http://github.com/asafpr/RILseq"
inputs:
  - id: reads_in
    type: File
    doc: An output file of map_chimeric_fragments.py with the chimeric 
      fragments.
    inputBinding:
      position: 1
  - id: all_interactions
    type:
      - 'null'
      - boolean
    doc: Skip all statistical tests and report all the interactions.
    default: false
    inputBinding:
      position: 102
      prefix: --all_interactions
  - id: bc_chrlist
    type:
      - 'null'
      - string
    doc: A comma separated dictionary of chromosome names from the bam file to 
      EcoCyc names. See the names of chromosomes in bam file using samtools view
      -H foo.bam.
    default: chr,COLI-K12
    inputBinding:
      position: 102
      prefix: --BC_chrlist
  - id: bc_dir
    type:
      - 'null'
      - Directory
    doc: BioCyc data dir, used to map the regions to genes. If not given only 
      the regions will be reported
    default: None
    inputBinding:
      position: 102
      prefix: --bc_dir
  - id: est_utr_lens
    type:
      - 'null'
      - int
    doc: Estimated UTRs lengths when there is not data.
    default: 100
    inputBinding:
      position: 102
      prefix: --est_utr_lens
  - id: genome
    type:
      - 'null'
      - File
    doc: genome fasta file
    default: None
    inputBinding:
      position: 102
      prefix: --genome
  - id: length
    type:
      - 'null'
      - int
    doc: Length of sequence used for mapping. Used to determine the gene in the 
      regions.
    default: 25
    inputBinding:
      position: 102
      prefix: --length
  - id: linear_chromosome_list
    type:
      - 'null'
      - string
    doc: A list of chromosomes/plasmids names that are linear and not cyclic.The
      name should be identical to the chromosome/plasmid name in the given 
      genome fasta file.
    default: ''
    inputBinding:
      position: 102
      prefix: --linear_chromosome_list
  - id: max_pv
    type:
      - 'null'
      - float
    doc: Maximal pvalue to report (after correction).
    default: 0.05
    inputBinding:
      position: 102
      prefix: --max_pv
  - id: maxsegs
    type:
      - 'null'
      - int
    doc: Maximal number of consecutive segments that will be treated as a 
      region.
    default: 5
    inputBinding:
      position: 102
      prefix: --maxsegs
  - id: min_int
    type:
      - 'null'
      - int
    doc: Minimal number of interactions to report.
    default: 5
    inputBinding:
      position: 102
      prefix: --min_int
  - id: min_odds_ratio
    type:
      - 'null'
      - float
    doc: Minimal odds ratio to report
    default: 1.0
    inputBinding:
      position: 102
      prefix: --min_odds_ratio
  - id: min_total_counts
    type:
      - 'null'
      - int
    doc: Minimal number of reads in the total library to assess normalization 
      from.
    default: 10
    inputBinding:
      position: 102
      prefix: --min_total_counts
  - id: norm_percentile
    type:
      - 'null'
      - float
    doc: Percentile of IP/total to use when evaluating normalization of odds 
      ratio in total. The value IP/total is evaluated for every region with at 
      least (--min_total_counts) reads and to avoid outliers the 99th percentile
      is taken as the normalization value meaning this is the highest amount of 
      IP reads that can be obtained in this library given the amount of total 
      RNA.
    default: 0.99
    inputBinding:
      position: 102
      prefix: --norm_percentile
  - id: only_singles
    type:
      - 'null'
      - boolean
    doc: Return only the single interactions. This should be used with 
      --all_interactions to count the number of single reads in the library.
    default: false
    inputBinding:
      position: 102
      prefix: --only_singles
  - id: pad_seqs
    type:
      - 'null'
      - int
    doc: When computing RNAup pad the interacting regions.
    default: 50
    inputBinding:
      position: 102
      prefix: --pad_seqs
  - id: refseq_dir
    type:
      - 'null'
      - Directory
    doc: RefSeq dir of organism to get the gene description from.
    default: None
    inputBinding:
      position: 102
      prefix: --refseq_dir
  - id: rep_table
    type:
      - 'null'
      - File
    doc: 'A table containing data on REP elements. This file was generated using SmartTables
      (e.g. this: http://ecocyc.org/group?id=biocyc14-8223-3640227683)'
    default: None
    inputBinding:
      position: 102
      prefix: --rep_table
  - id: ribozero
    type:
      - 'null'
      - boolean
    doc: Remove rRNA prior to the statistical analysis.
    default: false
    inputBinding:
      position: 102
      prefix: --ribozero
  - id: rnaup_cmd
    type:
      - 'null'
      - string
    doc: Executable of RNAup with its parameters
    default: RNAup
    inputBinding:
      position: 102
      prefix: --RNAup_cmd
  - id: rrna_list
    type:
      - 'null'
      - string
    doc: rRNA list of types for rRNA_prod param in read_genes_data(). this is a 
      no spaces comma-seperated list. e.g. 'rRNA,rrna,RRNA'
    default: rRNA,rrna,RRNA
    inputBinding:
      position: 102
      prefix: --rrna_list
  - id: run_rnaup
    type:
      - 'null'
      - boolean
    doc: Run RNAup and compute the interactions predicted strength
    default: false
    inputBinding:
      position: 102
      prefix: --run_RNAup
  - id: seglen
    type:
      - 'null'
      - int
    doc: Length of minimal segment of interaction.
    default: 100
    inputBinding:
      position: 102
      prefix: --seglen
  - id: servers
    type:
      - 'null'
      - string
    doc: A list of computers to run RNAup on (or number of CPUs)
    default: None
    inputBinding:
      position: 102
      prefix: --servers
  - id: shuffles
    type:
      - 'null'
      - int
    doc: Shuffle the first sequence to compute an empirical p-value of the 
      hybridization energy using RNAup.
    default: 0
    inputBinding:
      position: 102
      prefix: --shuffles
  - id: single_counts
    type:
      - 'null'
      - File
    doc: A file with the counts of single fragments per gene.
    default: None
    inputBinding:
      position: 102
      prefix: --single_counts
  - id: targets_file
    type:
      - 'null'
      - File
    doc: A list of sRNA-mRNA interactions, should be in EcoCyc acc.
    default: None
    inputBinding:
      position: 102
      prefix: --targets_file
  - id: total_reverse
    type:
      - 'null'
      - boolean
    doc: Total library is the reverse strand.
    default: false
    inputBinding:
      position: 102
      prefix: --total_reverse
  - id: total_rna
    type:
      - 'null'
      - string
    doc: Normalize in total RNA from these bam files. Enter a comma separated 
      list of bam files.
    default: None
    inputBinding:
      position: 102
      prefix: --total_RNA
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rilseq:0.82--pyhdfd78af_0
stdout: rilseq_RILseq_significant_regions.py.out
