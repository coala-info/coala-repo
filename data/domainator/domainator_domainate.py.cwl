cwlVersion: v1.2
class: CommandLineTool
baseCommand: domainator_domainate.py
label: domainator_domainate.py
doc: "Annotate sequence files with hmm profiles\n\nFor each CDS or protein in the
  input file, run the hmmer3 against the target domain hmm database to annotate all
  the different known/detectable domains in the CDS.\nHits with E value lower than
  the threshold (default 10) will be added to the annotation in genbank output file
  as a new \"feature\"\n\nTool homepage: https://github.com/nebiolabs/domainator"
inputs:
  - id: batch_size
    type:
      - 'null'
      - int
    doc: How many protein sequences to search at one time in a batch. Increasing
      this number might improve speeds at the cost of memory.
    default: 10000
    inputBinding:
      position: 101
      prefix: --batch_size
  - id: config
    type:
      - 'null'
      - File
    doc: Path to a configuration file.
    default: None
    inputBinding:
      position: 101
      prefix: --config
  - id: cpu
    type:
      - 'null'
      - int
    doc: 'the number of cores of the cpu which are used at a time to run the search
      [default: use all available cores]'
    default: 0
    inputBinding:
      position: 101
      prefix: --cpu
  - id: esm2_3di_device
    type:
      - 'null'
      - string
    doc: device to use for esm2_3Di model.
    default: cuda:0
    inputBinding:
      position: 101
      prefix: --esm2_3Di_device
  - id: esm2_3di_weights
    type:
      - 'null'
      - File
    doc: checkpoint file for esm2_3Di model.
    inputBinding:
      position: 101
      prefix: --esm2_3Di_weights
  - id: evalue_threshold
    type:
      - 'null'
      - float
    doc: threshold E value for the domain hit. Must be <=10.
    default: 0.001
    inputBinding:
      position: 101
      prefix: --evalue
  - id: exclude_taxids
    type:
      - 'null'
      - type: array
        items: string
    doc: Space separated list of taxids to exclude. Contigs with taxonomy in 
      this list will be skipped.
    inputBinding:
      position: 101
      prefix: --exclude_taxids
  - id: fasta_type
    type:
      - 'null'
      - string
    doc: Whether the sequences in fasta files are protein or nucleotide 
      sequences.
    default: protein
    inputBinding:
      position: 101
      prefix: --fasta_type
  - id: foldseek
    type:
      - 'null'
      - type: array
        items: File
    doc: Foldseek database files.
    inputBinding:
      position: 101
      prefix: --foldseek
  - id: gene_call
    type:
      - 'null'
      - string
    doc: "When activated, new CDS annotations will be added with Prodigal in Metagenomic
      mode. If 'all', then any existing CDS annotations will be deleted and all contigs
      will be re-annotated. If 'unannotated', then only contigs without CDS annotations
      will be annotated. [default: None]. If you supply a nucleotide fasta file, be
      sure to also specify --fasta_type nucleotide. Note that if you do gene calling,
      it is STRONGLY recommended that you also supply -Z, because database size is
      pre-calcuated at the beginning of the execution, whereas gene-calling is done
      on the fly. Not supplying Z may become an error in the future."
    default: None
    inputBinding:
      position: 101
      prefix: --gene_call
  - id: hits_only
    type:
      - 'null'
      - boolean
    doc: when activated, the ouptut will only have contigs with at least one 
      domain annotation. In many cases, domain_search.py will be faster and more
      appropriate.
    inputBinding:
      position: 101
      prefix: --hits_only
  - id: include_taxids
    type:
      - 'null'
      - type: array
        items: string
    doc: Space separated list of taxids to include. Contigs with taxonomy not in
      this list will be skipped.
    inputBinding:
      position: 101
      prefix: --include_taxids
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: the genbank or fasta files to annotate. Genbank files can be nucleotide
      (with CDS annotations) or peptide. Fasta files must be peptide.
    inputBinding:
      position: 101
      prefix: --input
  - id: max_domains
    type:
      - 'null'
      - int
    doc: the maximum number of domains to be reported per CDS. If not specified,
      then no max_domains filter is applied.
    default: 0
    inputBinding:
      position: 101
      prefix: --max_domains
  - id: max_mode
    type:
      - 'null'
      - boolean
    doc: Run hmmsearch/phmmer in maximum sensitivity mode, which is much slower,
      but more sensitive.
    inputBinding:
      position: 101
      prefix: --max_mode
  - id: max_overlap
    type:
      - 'null'
      - float
    doc: the maximum fractional of overlap between domains to be included in the
      annotated genbank. If >= 1, then no overlap filtering will be done.
    default: 1.0
    inputBinding:
      position: 101
      prefix: --max_overlap
  - id: min_evalue
    type:
      - 'null'
      - float
    doc: hits with E value LOWER (as in BETTER) than this will be filtered out. 
      NOT FREQUENTLY USED. Use only if you want to eliminate close matches. Must
      be >=0.
    default: 0.0
    inputBinding:
      position: 101
      prefix: --min_evalue
  - id: ncbi_taxonomy_path
    type:
      - 'null'
      - Directory
    doc: Path to NCBI taxonomy database directory. Will be created and 
      downloaded if it does not exist.
    default: /tmp/ncbi_taxonomy
    inputBinding:
      position: 101
      prefix: --ncbi_taxonomy_path
  - id: no_annotations
    type:
      - 'null'
      - boolean
    doc: when activated, new annotations will not be added to the file. This is 
      useful if you are just trying to extract a set of contigs for annotation 
      in a later step.
    inputBinding:
      position: 101
      prefix: --no_annotations
  - id: offset
    type:
      - 'null'
      - string
    doc: 'File offset to start reading records at. (Note that this usually only makes
      sense when there is just a single input file). Default: start at the top of
      the file'
    default: None
    inputBinding:
      position: 101
      prefix: --offset
  - id: overlap_by_db
    type:
      - 'null'
      - boolean
    doc: If activated, then overlap filtering will be done by database, rather 
      than all together.
    inputBinding:
      position: 101
      prefix: --overlap_by_db
  - id: print_config
    type:
      - 'null'
      - boolean
    doc: 'Print the configuration after applying all other arguments and exit. The
      optional flags customizes the output and are one or more keywords separated
      by comma. The supported flags are: comments, skip_default, skip_null.'
    inputBinding:
      position: 101
      prefix: --print_config
  - id: recs_to_read
    type:
      - 'null'
      - int
    doc: 'Stop after reading this many records. Default: read all the records'
    default: None
    inputBinding:
      position: 101
      prefix: --recs_to_read
  - id: references
    type:
      - 'null'
      - type: array
        items: File
    doc: the names of the HMM files with profiles to search. Or reference 
      protein fasta files.
    inputBinding:
      position: 101
      prefix: --references
  - id: taxonomy_update
    type:
      - 'null'
      - boolean
    doc: If taxonomy database exists, check it against the version on the ncbi 
      server and update if there is a newer version.
    inputBinding:
      position: 101
      prefix: --taxonomy_update
  - id: z_parameter
    type:
      - 'null'
      - int
    doc: "Passed as the -Z parameter to hmmsearch: Assert that the total number of
      targets in your searches is <x>, for the purposes of per-sequence E-value calculations,
      rather than the actual number of targets seen. Default: 1000\n             \
      \           Set to 0 to use the number actual target sequences (currently this
      does does not account for taxonomic filtering).Supplying -Z is recommended for
      most use cases of domainate, as it will speed up the search and make comparisons
      between searches more meaningful."
    default: 1000
    inputBinding:
      position: 101
      prefix: -Z
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output genbank filename. If not supplied, writes to stdout.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/domainator:0.8.1--pyhdfd78af_0
