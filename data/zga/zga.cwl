cwlVersion: v1.2
class: CommandLineTool
baseCommand: zga
label: zga
doc: "ZGA genome assembly and annotation pipeline ver. 0.1.1\n\nTool homepage: https://github.com/laxeye/zga"
inputs:
  - id: mp_1
    type:
      - 'null'
      - type: array
        items: File
    doc: Mate pair forward reads. SPAdes only
    inputBinding:
      position: 1
  - id: mp_2
    type:
      - 'null'
      - type: array
        items: File
    doc: Mate pair forward reads. SPAdes only
    inputBinding:
      position: 2
  - id: nanopore
    type:
      - 'null'
      - type: array
        items: File
    doc: Nanopore reads. Space-separated if multiple.
    inputBinding:
      position: 3
  - id: pacbio
    type:
      - 'null'
      - type: array
        items: File
    doc: PacBio reads. Space-separated if multiple.
    inputBinding:
      position: 4
  - id: pe_1
    type:
      - 'null'
      - type: array
        items: File
    doc: FASTQ file(s) with first (left) paired-end reads. Space-separated if 
      multiple.
    inputBinding:
      position: 5
  - id: pe_2
    type:
      - 'null'
      - type: array
        items: File
    doc: FASTQ file(s) with second (right) paired-end reads. Space-separated if 
      multiple.
    inputBinding:
      position: 6
  - id: pe_merged
    type:
      - 'null'
      - type: array
        items: File
    doc: FASTQ file(s) with merged overlapped paired-end reads
    inputBinding:
      position: 7
  - id: single_end
    type:
      - 'null'
      - type: array
        items: File
    doc: FASTQ file(s) with unpaired or single-end reads
    inputBinding:
      position: 8
  - id: adapters
    type:
      - 'null'
      - File
    doc: Adapter sequences for short reads trimming (FASTA). By default Illumina
      and BGI adapter sequences are used.
    inputBinding:
      position: 109
      prefix: --adapters
  - id: assembler
    type:
      - 'null'
      - string
    doc: 'Assembler: Unicycler (default; better quality), SPAdes (faster, may use
      mate-pair reads), Flye (long reads only with short-reads polishing), MEGAHIT
      (short reads only).'
    default: unicycler
    inputBinding:
      position: 109
      prefix: --assembler
  - id: bbduk_extra
    type:
      - 'null'
      - type: array
        items: string
    doc: Extra options for BBduk. Should be space-separated.
    inputBinding:
      position: 109
      prefix: --bbduk-extra
  - id: bbduk_k
    type:
      - 'null'
      - int
    doc: Kmer length used for finding contaminants with BBduk.
    inputBinding:
      position: 109
      prefix: --bbduk-k
  - id: bbmerge
    type:
      - 'null'
      - boolean
    doc: Merge overlapped paired-end reads with BBMerge.
    inputBinding:
      position: 109
      prefix: --bbmerge
  - id: bbmerge_extra
    type:
      - 'null'
      - type: array
        items: string
    doc: Extra options for BBMerge. Should be space-separated.
    inputBinding:
      position: 109
      prefix: --bbmerge-extra
  - id: calculate_genome_size
    type:
      - 'null'
      - boolean
    doc: Estimate genome size with mash.
    inputBinding:
      position: 109
      prefix: --calculate-genome-size
  - id: check_phix
    type:
      - 'null'
      - boolean
    doc: Check genome for presence of PhiX control sequence.
    inputBinding:
      position: 109
      prefix: --check-phix
  - id: checkm_full_tree
    type:
      - 'null'
      - boolean
    doc: Use full tree for inference of marker set, requires LOTS of memory.
    inputBinding:
      position: 109
      prefix: --checkm-full-tree
  - id: checkm_mode
    type:
      - 'null'
      - string
    doc: CheckM working mode. Default is checking for domain-specific 
      marker-set.
    default: taxonomy_wf
    inputBinding:
      position: 109
      prefix: --checkm-mode
  - id: checkm_rank
    type:
      - 'null'
      - string
    doc: Rank of taxon for CheckM. Run 'checkm taxon_list' for details.
    inputBinding:
      position: 109
      prefix: --checkm-rank
  - id: checkm_taxon
    type:
      - 'null'
      - string
    doc: Taxon for CheckM. Run 'checkm taxon_list' for details.
    inputBinding:
      position: 109
      prefix: --checkm-taxon
  - id: compliant
    type:
      - 'null'
      - boolean
    doc: Force Genbank/ENA/DDJB compliance.
    inputBinding:
      position: 109
      prefix: --compliant
  - id: domain
    type:
      - 'null'
      - string
    doc: 'Prokaryotic domain: Bacteria or Archaea, default: Bacteria.'
    default: Bacteria
    inputBinding:
      position: 109
      prefix: --domain
  - id: entropy_cutoff
    type:
      - 'null'
      - float
    doc: Set between 0 and 1 to filter reads with entropy below that value. 
      Higher is more stringent. Default = -1, filtering disabled.
    default: -1
    inputBinding:
      position: 109
      prefix: --entropy-cutoff
  - id: extract_replicons
    type:
      - 'null'
      - boolean
    doc: 'Unicycler: extract complete replicons (e.g. plasmids) from the short-read
      based assembly to separate files'
    inputBinding:
      position: 109
      prefix: --extract-replicons
  - id: filter_by_tile
    type:
      - 'null'
      - boolean
    doc: Filter short reads (Illumina only!) based on positional quality over a 
      flowcell.
    inputBinding:
      position: 109
      prefix: --filter-by-tile
  - id: first_step
    type:
      - 'null'
      - string
    doc: 'First step of the pipeline. Default: readqc'
    default: readqc
    inputBinding:
      position: 109
      prefix: --first-step
  - id: flye_short_polish
    type:
      - 'null'
      - boolean
    doc: Perform polishing of Flye assembly with short reads using racon.
    inputBinding:
      position: 109
      prefix: --flye-short-polish
  - id: flye_skip_long_polish
    type:
      - 'null'
      - boolean
    doc: Skip stage of genome polishing with long reads.
    inputBinding:
      position: 109
      prefix: --flye-skip-long-polish
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite output directory if exists
    inputBinding:
      position: 109
      prefix: --force
  - id: genome
    type:
      - 'null'
      - File
    doc: Genome assembly (when starting with assembled genome).
    inputBinding:
      position: 109
      prefix: --genome
  - id: genome_size_estimation
    type:
      - 'null'
      - int
    doc: Genome size in bp (no K/M suffix supported) for Flye assembler, if 
      known.
    inputBinding:
      position: 109
      prefix: --genome-size-estimation
  - id: genus
    type:
      - 'null'
      - string
    doc: "Genus name if known, default: 'Unknown'."
    default: Unknown
    inputBinding:
      position: 109
      prefix: --genus
  - id: last_step
    type:
      - 'null'
      - string
    doc: 'Last step of the pipeline. Default: annotation'
    default: annotation
    inputBinding:
      position: 109
      prefix: --last-step
  - id: linear_seqs
    type:
      - 'null'
      - int
    doc: Expected number of linear sequences
    inputBinding:
      position: 109
      prefix: --linear-seqs
  - id: locus_tag
    type:
      - 'null'
      - string
    doc: Locus tag prefix. If not provided prefix will be by bakta.
    inputBinding:
      position: 109
      prefix: --locus-tag
  - id: mash_kmer_copies
    type:
      - 'null'
      - int
    doc: 'Minimum copies of each k-mer to include in size estimation, default: 10.'
    default: 10
    inputBinding:
      position: 109
      prefix: --mash-kmer-copies
  - id: memory_limit
    type:
      - 'null'
      - string
    doc: 'Memory limit in GB, default: 8.'
    default: '8'
    inputBinding:
      position: 109
      prefix: --memory-limit
  - id: min_short_read_length
    type:
      - 'null'
      - int
    doc: Minimum short read length to keep after quality trimming.
    inputBinding:
      position: 109
      prefix: --min-short-read-length
  - id: minimum_contig_length
    type:
      - 'null'
      - int
    doc: Minimum sequence length in genome assembly.
    inputBinding:
      position: 109
      prefix: --minimum-contig-length
  - id: no_nxtrim
    type:
      - 'null'
      - boolean
    doc: Don't process mate-pair reads with NxTrim. Usefull for preprocessed 
      reads
    inputBinding:
      position: 109
      prefix: --no-nxtrim
  - id: no_spades_correction
    type:
      - 'null'
      - boolean
    doc: Disable short read correction by SPAdes.
    inputBinding:
      position: 109
      prefix: --no-spades-correction
  - id: normalize_kmer_cov
    type:
      - 'null'
      - int
    doc: Normalize read depth based on kmer counts to arbitrary value.
    inputBinding:
      position: 109
      prefix: --normalize-kmer-cov
  - id: output_dir
    type: Directory
    doc: Output directory
    inputBinding:
      position: 109
      prefix: --output-dir
  - id: perform_polishing
    type:
      - 'null'
      - boolean
    doc: Perform polishing. Useful only for flye assembly of long reads and 
      short reads available.
    inputBinding:
      position: 109
      prefix: --perform-polishing
  - id: polishing_iterations
    type:
      - 'null'
      - int
    doc: 'Number of polishing iterations, default: 1.'
    default: 1
    inputBinding:
      position: 109
      prefix: --polishing-iterations
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for annotated files.
    inputBinding:
      position: 109
      prefix: --prefix
  - id: quality_cutoff
    type:
      - 'null'
      - int
    doc: 'Base quality cutoff for short reads, default: 18'
    default: 18
    inputBinding:
      position: 109
      prefix: --quality-cutoff
  - id: spades_k_list
    type:
      - 'null'
      - string
    doc: "SPAdes: List of kmers, comma-separated even numbers e.g. '21,33,55,77'"
    inputBinding:
      position: 109
      prefix: --spades-k-list
  - id: species
    type:
      - 'null'
      - string
    doc: "Species name if known, , default: 'sp.'"
    default: sp.
    inputBinding:
      position: 109
      prefix: --species
  - id: strain
    type:
      - 'null'
      - string
    doc: Strain name if known
    inputBinding:
      position: 109
      prefix: --strain
  - id: tadpole_correct
    type:
      - 'null'
      - boolean
    doc: Perform error correction of short reads with tadpole.sh from 
      BBtools.SPAdes correction may be disabled with "--no-spades-correction".
    inputBinding:
      position: 109
      prefix: --tadpole-correct
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of CPU threads to use (where possible), default: 4.'
    default: 4
    inputBinding:
      position: 109
      prefix: --threads
  - id: translation_table
    type:
      - 'null'
      - int
    doc: 'Translation table: 11/4, default: 11.'
    default: 11
    inputBinding:
      position: 109
      prefix: --translation-table
  - id: transparent
    type:
      - 'null'
      - boolean
    doc: Show output from tools inside the pipeline
    inputBinding:
      position: 109
      prefix: --transparent
  - id: unicycler_mode
    type:
      - 'null'
      - string
    doc: 'Unicycler: assember mode: conservative, normal (default) or bold.'
    default: normal
    inputBinding:
      position: 109
      prefix: --unicycler-mode
  - id: use_scaffolds
    type:
      - 'null'
      - boolean
    doc: 'SPAdes: Use assembled scaffolds. Contigs are used by default.'
    inputBinding:
      position: 109
      prefix: --use-scaffolds
  - id: use_unknown_mp
    type:
      - 'null'
      - boolean
    doc: 'NxTrim: Include reads that are probably mate pairs (default: only known
      mate pairs used)'
    inputBinding:
      position: 109
      prefix: --use-unknown-mp
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/zga:0.1.1--pyhdfd78af_0
stdout: zga.out
