cwlVersion: v1.2
class: CommandLineTool
baseCommand: domainator_domain_search.py
label: domainator_domain_search.py
doc: "Search for matches to hmm profiles\n\nFor searching large databases of sequences
  (genbank files or fasta files) with small numbers (< ~100) of queries (profiles
  or protein sequences).\n\nReturns the contigs with hits, possibly truncated to the
  neighborhood around the hits.\n\nWhen --max_hits is specified, it applies to the
  entire search, not individual queries. Thus if you supply 5 query profiles and --max_hits
  100, \nat most 100 hits will be returned (not 500). \n\nWhen max_hits or pad are
  specified, hits will be sorted by best domain score and written after the entire
  search completes.\nIf neither is set, then hits will be written on the fly and not
  sorted.\n\nTool homepage: https://github.com/nebiolabs/domainator"
inputs:
  - id: add_annotations
    type:
      - 'null'
      - boolean
    doc: When activated, new domainator annotations will be added to the file, 
      not just the domain_search annotations. Useful if you want to see what the
      non-best hits score.
    default: false
    inputBinding:
      position: 101
      prefix: --add_annotations
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Approximately how many protein sequences to search at one time in a 
      batch.
    default: 10000
    inputBinding:
      position: 101
      prefix: --batch_size
  - id: cds_down
    type:
      - 'null'
      - string
    doc: How many CDSs downstream of the selected CDS to extract. Example, 1 
      would mean to return contigs including the selected CDSs and the immediate
      downstream CDS.
    default: None
    inputBinding:
      position: 101
      prefix: --cds_down
  - id: cds_range
    type:
      - 'null'
      - string
    doc: How many CDSs upstream and downstream of the selected CDS to extract. 
      Example, 1 would mean to return contigs including the selected CDSs and 
      the immediate upstream and downstream CDSs.
    default: None
    inputBinding:
      position: 101
      prefix: --cds_range
  - id: cds_up
    type:
      - 'null'
      - string
    doc: How many CDSs upstream of the selected CDS to extract. Example, 1 would
      mean to return contigs including the selected CDSs and the immediate 
      upstream CDS.
    default: None
    inputBinding:
      position: 101
      prefix: --cds_up
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
  - id: decoys
    type:
      - 'null'
      - type: array
        items: string
    doc: Names of decoy domains. A decoy domain is a domain that is not expected
      to be found in the input sequences. If the best hit for a CDS/protein is a
      domain from the decoys list, it will be not be returned as a hit.
    default: None
    inputBinding:
      position: 101
      prefix: --decoys
  - id: decoys_file
    type:
      - 'null'
      - File
    doc: text file containing names of decoy domains.
    default: None
    inputBinding:
      position: 101
      prefix: --decoys_file
  - id: deduplicate
    type:
      - 'null'
      - boolean
    doc: by default if the same region is extracted for multiple hits then both 
      will be kept. Set this option to eliminate redundancies.
    default: false
    inputBinding:
      position: 101
      prefix: --deduplicate
  - id: evalue
    type:
      - 'null'
      - float
    doc: threshold E value for the domain hit. Must be <=10. [default 0.001]
    default: 0.001
    inputBinding:
      position: 101
      prefix: --evalue
  - id: exclude_taxids
    type:
      - 'null'
      - type: array
        items: string
    doc: Space separated list of taxids to exclude
    default: None
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
  - id: gene_call
    type:
      - 'null'
      - string
    doc: "When activated, new CDS annotations will be added with Prodigal in Metagenomic
      mode. If 'all', then any existing CDS annotations will be deleted and all contigs
      will be re-annotated. If 'unannotated', then only contigs without CDS annotations
      will be annotated. [default: None] Note that if you do gene calling, it is STRONGLY
      recommended that you also supply -Z, because database size is pre-calcuated
      at the beginning of the execution, whereas gene-calling is done on the fly.
      Not supplying Z may become an error in the future."
    default: None
    inputBinding:
      position: 101
      prefix: --gene_call
  - id: include_taxids
    type:
      - 'null'
      - type: array
        items: string
    doc: Space separated list of taxids to include
    default: None
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
    default: None
    inputBinding:
      position: 101
      prefix: --input
  - id: kb_down
    type:
      - 'null'
      - string
    doc: How many kb downstream of the selected CDS to extract. Starting from 
      the end of the CDS.
    default: None
    inputBinding:
      position: 101
      prefix: --kb_down
  - id: kb_range
    type:
      - 'null'
      - string
    doc: How many kb upstream and downstream of the selected CDS to extract. 
      Starting from the ends of the CDS.
    default: None
    inputBinding:
      position: 101
      prefix: --kb_range
  - id: kb_up
    type:
      - 'null'
      - string
    doc: How many kb upstream of the selected CDS to extract. Starting from the 
      end of the CDS.
    default: None
    inputBinding:
      position: 101
      prefix: --kb_up
  - id: keep_direction
    type:
      - 'null'
      - boolean
    doc: by default extracted regions will be flipped so that the focus cds is 
      on the forward strand. Setting this option will keep the focus cds on 
      whatever strand it started on.
    default: false
    inputBinding:
      position: 101
      prefix: --keep_direction
  - id: max_hits
    type:
      - 'null'
      - int
    doc: 'the maximum number of CDSs returned by the search. Prioritized by bitscore
      of best scoring profile. [default: return all hits passing the evalue threshold]'
    default: None
    inputBinding:
      position: 101
      prefix: --max_hits
  - id: max_mode
    type:
      - 'null'
      - boolean
    doc: Run hmmsearch/phmmer in maximum sensitivity mode, which is much slower,
      but more sensitive.
    default: false
    inputBinding:
      position: 101
      prefix: --max_mode
  - id: max_overlap
    type:
      - 'null'
      - float
    doc: the maximum fractional overlap between domains to be included in the 
      annotated genbank. If >= 1, then no overlap filtering will be done. 
      [default 1]
    default: 1
    inputBinding:
      position: 101
      prefix: --max_overlap
  - id: max_region_overlap
    type:
      - 'null'
      - float
    doc: the maximum fractional of overlap between any two output regions. If >=
      1, then no overlap filtering will be done. Regions are output in a greedy 
      fashion based on CDS start site. New regions are output if less than this 
      fraction of them overlaps with any previously output region.
    default: 1.0
    inputBinding:
      position: 101
      prefix: --max_region_overlap
  - id: min_evalue
    type:
      - 'null'
      - float
    doc: hits with E value lower than this will be filtered out. Not frequently 
      used. Use only if you want to eliminate close matches. Must be >=0. 
      [default 0]
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
  - id: pad
    type:
      - 'null'
      - boolean
    doc: If set, then ends of sequences will be padded so that the focus CDS 
      aligns.
    default: false
    inputBinding:
      position: 101
      prefix: --pad
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
  - id: references
    type:
      - 'null'
      - type: array
        items: File
    doc: the names of the HMM files with profiles to search. Or protein query 
      files.
    default: None
    inputBinding:
      position: 101
      prefix: --references
  - id: strand
    type:
      - 'null'
      - string
    doc: Only extract regions around CDSs on the specified strand.
    default: None
    inputBinding:
      position: 101
      prefix: --strand
  - id: taxonomy_update
    type:
      - 'null'
      - boolean
    doc: If taxonomy database exists, check it against the version on the ncbi 
      server and update if there is a newer version.
    default: false
    inputBinding:
      position: 101
      prefix: --taxonomy_update
  - id: translate
    type:
      - 'null'
      - boolean
    doc: by default, nucleotide databases will return nucleotide hits. When 
      --translate is set, CDS hits will be translated before writing. Note that 
      --translate is incompatble with neighborhood extraction.
    default: false
    inputBinding:
      position: 101
      prefix: --translate
  - id: whole_contig
    type:
      - 'null'
      - boolean
    doc: If set, then return the entire matching contigs.
    default: false
    inputBinding:
      position: 101
      prefix: --whole_contig
  - id: z_param
    type:
      - 'null'
      - int
    doc: "Passed as the -Z parameter to hmmsearch: Assert that the total number of
      targets in your searches is <x>, for the purposes of per-sequence E-value calculations,
      rather than the actual number of targets seen. Default: 1000\nSet to 0 to use
      the number actual target sequences (currently this does does not account for
      taxonomic filtering).Supplying -Z is recommended for most use cases of domainate,
      as it will speed up the search and make comparisons between searches more meaningful."
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
