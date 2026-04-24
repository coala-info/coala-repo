cwlVersion: v1.2
class: CommandLineTool
baseCommand: cenotetaker3
label: cenote-taker3_cenotetaker3
doc: "Cenote-Taker 3 is a pipeline for virus discovery and thorough annotation of
  viral contigs and genomes.\n\nTool homepage: https://github.com/mtisza1/Cenote-Taker3"
inputs:
  - id: annotation_mode
    type:
      - 'null'
      - boolean
    doc: Annotate sequences only (skip discovery). Only use if you believe each 
      provided sequence is viral
    inputBinding:
      position: 101
      prefix: --annotation_mode
  - id: assembler
    type:
      - 'null'
      - string
    doc: Assembler used to generate contigs, if applicable. Specify version of 
      assembler software, if possible.
    inputBinding:
      position: 101
      prefix: --assembler
  - id: bioproject
    type:
      - 'null'
      - string
    doc: For read data on SRA, project number, usually beginning with 'PRJNA' or
      'PRJEB'
    inputBinding:
      position: 101
      prefix: --bioproject
  - id: biosample
    type:
      - 'null'
      - string
    doc: For read data on SRA, sample number, usually beginning with 'SAMN' or 
      'SAMEA' or 'SRS'
    inputBinding:
      position: 101
      prefix: --biosample
  - id: caller
    type:
      - 'null'
      - string
    doc: 'ORF caller for viruses. default: prodigal-gv prodigal- gv: prodigal-gv only
      (prodigal with extra models for unusual viruses) (meta mode) prodigal: prodigal
      classic only (meta mode). phanotate: phanotate only Note: phanotate takes longer
      than prodigal, exponentially so for LONG input contigs. adaptive: will choose
      based on preliminary taxonomy call (phages = phanotate, others = prodigal-gv)'
    inputBinding:
      position: 101
      prefix: --caller
  - id: cenote_dbs
    type:
      - 'null'
      - Directory
    doc: DB path. If not set here, Cenote-Taker looks for environmental variable
      CENOTE_DBS. Then, if this variable is unset, DB path is assumed to be 
      /usr/local/lib/python3.13
    inputBinding:
      position: 101
      prefix: --cenote-dbs
  - id: circ_file
    type:
      - 'null'
      - File
    doc: Provide a file with the names of contigs (header line sans ">") you 
      believe are circular, one per line. If using this option, CT3 will treat 
      listed contigs as circular but will not search for DTRs in sequences. 
      Useful for long read assembly outputs (flye, myloasm) that report circular
      contigs. --max_dtr_assess will still be considered.
    inputBinding:
      position: 101
      prefix: --circ-file
  - id: circ_minimum_hallmark_genes
    type:
      - 'null'
      - int
    doc: Number of detected viral hallmark genes on a circular contig to be 
      considered viral and recieve full annotation. For samples physically 
      enriched for virus particles, '0' can be used, but please treat circular 
      contigs without known viral domains cautiously. For unenriched samples, 
      '1' might be more suitable.
    inputBinding:
      position: 101
      prefix: --circ_minimum_hallmark_genes
  - id: collection_date
    type:
      - 'null'
      - string
    doc: 'Date of collection. this format: 01-Jan-2019, i.e. DD-Mmm-YYYY'
    inputBinding:
      position: 101
      prefix: --collection_date
  - id: cpu
    type:
      - 'null'
      - int
    doc: Number of CPUs available for Cenote-Taker 3.
    inputBinding:
      position: 101
      prefix: --cpu
  - id: data_source
    type:
      - 'null'
      - string
    doc: "original data is not taken from other researchers' public or private database.
      'tpa_assembly': data is taken from other researchers' public or private database.
      Please be sure to specify SRA metadata."
    inputBinding:
      position: 101
      prefix: --data_source
  - id: genbank
    type:
      - 'null'
      - boolean
    doc: Make GenBank files (.gbf, .sqn, .fsa, .tbl, .cmt, etc)?
    inputBinding:
      position: 101
      prefix: --genbank
  - id: hhsuite_tool
    type:
      - 'null'
      - string
    doc: "hhblits: query any of PDB, pfam, and CDD (depending on what is installed)
      to annotate ORFs escaping identification via upstream methods. hhsearch: a more
      sensitive tool, will query PDB, pfam, and CDD (depending on what is installed)
      to annotate ORFs. (WARNING: hhsearch takes much, much longer than hhblits and
      can extend the duration of the run many times over. Do not use on large input
      contig files). 'none': forgoes annotation of ORFs with hhsuite. Fastest way
      to complete a run."
    inputBinding:
      position: 101
      prefix: --hhsuite_tool
  - id: hmmscan_dbs
    type:
      - 'null'
      - string
    doc: HMMscan DB version. looks in cenote_db_path/hmmscan_DBs/
    inputBinding:
      position: 101
      prefix: --hmmscan_dbs
  - id: isolation_source
    type:
      - 'null'
      - string
    doc: Describes the local geographical source of the organism from which the 
      sequence was derived
    inputBinding:
      position: 101
      prefix: --isolation_source
  - id: lin_minimum_hallmark_genes
    type:
      - 'null'
      - int
    doc: Number of detected viral hallmark genes on a non-circular contig to be 
      considered viral and recieve full annotation. '2' might be more suitable, 
      yielding a false positive rate near 0.
    inputBinding:
      position: 101
      prefix: --lin_minimum_hallmark_genes
  - id: max_dtr_assess
    type:
      - 'null'
      - int
    doc: maximum sequence length to assess DTRs. Extra long contigs with DTRs 
      are likely to be bacterial chromosomes, not virus genomes.
    inputBinding:
      position: 101
      prefix: --max_dtr_assess
  - id: metagenome_type
    type:
      - 'null'
      - string
    doc: a.k.a. metagenome_source
    inputBinding:
      position: 101
      prefix: --metagenome_type
  - id: minimum_length_circular
    type:
      - 'null'
      - int
    doc: Minimum length of contigs to be checked for circularity. Bare minimun 
      is 1000 nts
    inputBinding:
      position: 101
      prefix: --minimum_length_circular
  - id: minimum_length_linear
    type:
      - 'null'
      - int
    doc: Minimum length of non-circualr contigs to be checked for viral hallmark
      genes.
    inputBinding:
      position: 101
      prefix: --minimum_length_linear
  - id: molecule_type
    type:
      - 'null'
      - string
    doc: viable options are DNA - OR - RNA
    inputBinding:
      position: 101
      prefix: --molecule_type
  - id: original_contigs
    type: File
    doc: Contig file with .fasta extension in fasta format. Each header must be 
      unique before the first space character
    inputBinding:
      position: 101
      prefix: --contigs
  - id: prophage
    type: string
    doc: True or False. Attempt to identify and remove flanking chromosomal 
      regions from non-circular contigs with viral hallmarks (True is highly 
      recommended for sequenced material not enriched for viruses. Virus- 
      enriched samples probably should be False (you might check enrichment with
      ViromeQC). Also, please use False if --lin_minimum_hallmark_genes is set 
      to 0)
    inputBinding:
      position: 101
      prefix: --prune_prophage
  - id: reads
    type:
      - 'null'
      - type: array
        items: File
    doc: read file(s) in .fastq format. You can specify more than one separated 
      by a space
    inputBinding:
      position: 101
      prefix: --reads
  - id: run_title
    type: string
    doc: Name of this run. A directory of this name will be created. Must be 
      unique from older runs or older run will be renamed. Must be less than 18 
      characters, using ONLY letters, numbers and underscores (_)
    inputBinding:
      position: 101
      prefix: --run_title
  - id: seqtech
    type:
      - 'null'
      - string
    doc: 'Which sequencing technology produced the reads? Common options: Illumina,
      Nanopore, PacBio, Onso, Aviti'
    inputBinding:
      position: 101
      prefix: --seqtech
  - id: srr_number
    type:
      - 'null'
      - string
    doc: For read data on SRA, run number, usually beginning with 'SRR' or 'ERR'
    inputBinding:
      position: 101
      prefix: --srr_number
  - id: srx_number
    type:
      - 'null'
      - string
    doc: For read data on SRA, experiment number, usually beginning with 'SRX' 
      or 'ERX'
    inputBinding:
      position: 101
      prefix: --srx_number
  - id: taxdb
    type:
      - 'null'
      - string
    doc: Which taxonomy database to use, just refseq virus OR virus hallmark 
      genes from nr virus containing genus, family, and class taxonomy labels 
      and clustered at 90 percent AAI plus all hallmark genes from refseq virus
    inputBinding:
      position: 101
      prefix: --taxdb
  - id: template_file
    type:
      - 'null'
      - File
    doc: 'Template file with some metadata. Real one required for GenBank submission.
      Takes a couple minutes to generate: https://submit.ncbi.nlm.nih.gov/genbank/template/submission/'
    inputBinding:
      position: 101
      prefix: --template_file
  - id: virus_domain_db
    type:
      - 'null'
      - type: array
        items: string
    doc: "Hits to which domain types should count as hallmark genes? 'virion' database:
      genes encoding virion structural proteins, packaging proteins, or capsid maturation
      proteins (DNA and RNA genomes) with LOWEST false discovery rate. 'rdrp' database:
      For RNA virus-derived RNA-dependent RNA polymerase. 'dnarep' database: replication
      genes of DNA viruses. mostly useful for small DNA viruses, e.g. CRESS viruses"
    inputBinding:
      position: 101
      prefix: --virus_domain_db
  - id: working_directory
    type:
      - 'null'
      - Directory
    doc: Set working directory with absolute or relative path. run directory 
      will be created within.
    inputBinding:
      position: 101
      prefix: --working_directory
  - id: wrap
    type:
      - 'null'
      - boolean
    doc: Wrap/rotate DTR/circular contigs so the start codon of an ORF is the 
      first nucleotide in the contig/genome
    inputBinding:
      position: 101
      prefix: --wrap
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cenote-taker3:3.4.4--pyhdfd78af_0
stdout: cenote-taker3_cenotetaker3.out
