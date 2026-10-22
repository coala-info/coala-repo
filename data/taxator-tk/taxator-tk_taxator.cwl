cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxator
label: taxator-tk_taxator
doc: "Predict taxonomic ids of query sequence segments from alignments (read from standard input) against a taxonomically labelled reference.\n\nTool homepage: https://github.com/fungs/taxator-tk"
inputs:
  - id: alignments
    type: File
    doc: Alignments in the taxator-tk tab-separated format (query id, query start, query stop, query length, reference id, reference start, reference stop, score, e-value, identities, alignment length), read from standard input
  - id: taxonomy_dir
    type: Directory
    doc: NCBI taxonomy dump directory (nodes.dmp, names.dmp, merged.dmp); given to the tool by the environment variable TAXATORTK_TAXONOMY_NCBI
  - id: advanced_options
    type:
      - 'null'
      - boolean
    doc: show advanced program options
    inputBinding:
      position: 101
      prefix: --advanced-options
  - id: algorithm
    type:
      - 'null'
      - string
    doc: set the algorithm that is used to predict taxonomic ids from alignments
    inputBinding:
      position: 101
      prefix: --algorithm
  - id: citation
    type:
      - 'null'
      - boolean
    doc: show citation info
    inputBinding:
      position: 101
      prefix: --citation
  - id: logfile
    type:
      - 'null'
      - string
    doc: specify name of file for logging (appending lines)
    inputBinding:
      position: 101
      prefix: --logfile
  - id: processors
    type:
      - 'null'
      - int
    doc: sets number of threads, number > 2 will heavily profit from multi-core 
      architectures, set to 0 for max. performance
    inputBinding:
      position: 101
      prefix: --processors
  - id: query_sequences
    type: File
    doc: query sequences FASTA
    inputBinding:
      position: 101
      prefix: --query-sequences
  - id: query_sequences_index
    type:
      - 'null'
      - string
    doc: query sequences FASTA index, for out-of-memory operation; is created if
      not existing
    inputBinding:
      position: 101
      prefix: --query-sequences-index
  - id: ref_sequences
    type: File
    doc: reference sequences FASTA
    inputBinding:
      position: 101
      prefix: --ref-sequences
  - id: ref_sequences_index
    type:
      - 'null'
      - string
    doc: FASTA file index, for out-of-memory operation; is created if not 
      existing
    inputBinding:
      position: 101
      prefix: --ref-sequences-index
  - id: seqid_taxid_mapping
    type: File
    doc: filename of seqid->taxid mapping for reference
    inputBinding:
      position: 101
      prefix: --seqid-taxid-mapping
  - id: ranks
    type:
      - 'null'
      - type: array
        items: string
    doc: "set node ranks at which to do predictions (advanced option)"
    inputBinding:
      position: 101
      prefix: --ranks
  - id: split_alignments
    type:
      - 'null'
      - int
    doc: "decompose alignments into disjunct segments and treat them separately (advanced option, default 1)"
    inputBinding:
      position: 101
      prefix: --split-alignments
  - id: alignments_sorted
    type:
      - 'null'
      - int
    doc: "avoid sorting if alignments are sorted (advanced option, default 0)"
    inputBinding:
      position: 101
      prefix: --alignments-sorted
  - id: delete_notranks
    type:
      - 'null'
      - int
    doc: "delete all nodes that don't have any of the given ranks (advanced option, default 1)"
    inputBinding:
      position: 101
      prefix: --delete-notranks
  - id: heuristic_cutoff
    type:
      - 'null'
      - float
    doc: "filter out alignments, increase means faster run-time whereas 0 means no filtering at all (advanced option, default 0.5)"
    inputBinding:
      position: 101
      prefix: --heuristic-cutoff
  - id: toppercent
    type:
      - 'null'
      - float
    doc: "RPA re-evaluation band or top percent parameter for LCA methods (advanced option, default 0.05)"
    inputBinding:
      position: 101
      prefix: --toppercent
  - id: max_evalue
    type:
      - 'null'
      - float
    doc: "set maximum evalue for filtering (advanced option, default 1000)"
    inputBinding:
      position: 101
      prefix: --max-evalue
  - id: min_support
    type:
      - 'null'
      - int
    doc: "set minimum number of hits an alignment needs to have (after filtering) for MEGAN algorithm (advanced option, default 1)"
    inputBinding:
      position: 101
      prefix: --min-support
  - id: minscore
    type:
      - 'null'
      - float
    doc: "min score parameter for MEGAN classification (advanced option, default 0)"
    inputBinding:
      position: 101
      prefix: --minscore
  - id: nbest
    type:
      - 'null'
      - int
    doc: "n-best LCA classification parameter (advanced option, default 1)"
    inputBinding:
      position: 101
      prefix: --nbest
  - id: ignore_unclassified
    type:
      - 'null'
      - boolean
    doc: "alignments for partly unclassified taxa will be ignored (advanced option)"
    inputBinding:
      position: 101
      prefix: --ignore-unclassified
  - id: db_whitelist
    type:
      - 'null'
      - File
    doc: "list of sequence identifiers in reference to be used to reduce memory footprint, RPA algorithm (advanced option)"
    inputBinding:
      position: 101
      prefix: --db-whitelist
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: TAXATORTK_TAXONOMY_NCBI
        envValue: $(inputs.taxonomy_dir.path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxator-tk:1.3.3e--0
stdout: taxator-tk_taxator.out
stdin: $(inputs.alignments.path)
