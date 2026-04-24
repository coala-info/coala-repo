cwlVersion: v1.2
class: CommandLineTool
baseCommand: upimapi
label: upimapi
doc: "UniProt Id Mapping through API\n\nTool homepage: https://github.com/iquasere/UPIMAPI"
inputs:
  - id: bitscore
    type:
      - 'null'
      - string
    doc: Minimum bit score to report annotations for (overrides e-value).
    inputBinding:
      position: 101
      prefix: --bitscore
  - id: blast
    type:
      - 'null'
      - boolean
    doc: If input file is in BLAST TSV format (will consider one ID per line if 
      not set)
    inputBinding:
      position: 101
      prefix: --blast
  - id: block_size
    type:
      - 'null'
      - string
    doc: Billions of sequence letters to be processed at a time
    inputBinding:
      position: 101
      prefix: --block-size
  - id: columns
    type:
      - 'null'
      - string
    doc: List of UniProt columns to obtain information from (separated by &)
    inputBinding:
      position: 101
      prefix: --columns
  - id: database
    type:
      - 'null'
      - string
    doc: How the reference database is inputted to UPIMAPI. 1. uniprot - UPIMAPI
      will download the entire UniProt and use it as reference 2. swissprot - 
      UPIMAPI will download SwissProt and use it as reference 3. taxids - 
      Reference proteomes will be downloaded for the taxa specified with the 
      --taxids, and those will be used as reference 4. a custom database - Input
      will be considered as the database, and will be used as reference
    inputBinding:
      position: 101
      prefix: --database
  - id: diamond_mode
    type:
      - 'null'
      - string
    doc: Mode to run DIAMOND with
    inputBinding:
      position: 101
      prefix: --diamond-mode
  - id: evalue
    type:
      - 'null'
      - string
    doc: Maximum e-value to report annotations for
    inputBinding:
      position: 101
      prefix: --evalue
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: Output will be generated in FASTA format
    inputBinding:
      position: 101
      prefix: --fasta
  - id: from_db
    type:
      - 'null'
      - string
    doc: Which database are the IDs from. If from UniProt, default is fine
    inputBinding:
      position: 101
      prefix: --from-db
  - id: full_id
    type:
      - 'null'
      - string
    doc: "If IDs in database are in 'full' format: tr|XXX|XXX"
    inputBinding:
      position: 101
      prefix: --full-id
  - id: index_chunks
    type:
      - 'null'
      - string
    doc: Number of chunks for processing the seed index
    inputBinding:
      position: 101
      prefix: --index-chunks
  - id: input
    type:
      - 'null'
      - string
    doc: 'Input filename - can be: 1. a file containing a list of IDs (comma-separated
      values, no spaces) 2. a BLAST TSV result file (requires to be specified with
      the --blast parameter 3. a protein FASTA file to be annotated (requires the
      -db parameter) 4. nothing! If so, will read input from command line, and parse
      as CSV (id1,id2,...)'
    inputBinding:
      position: 101
      prefix: --input
  - id: local_id_mapping
    type:
      - 'null'
      - boolean
    doc: Perform local ID mapping of SwissProt IDs. Advisable if many IDs of 
      SwissProt are present
    inputBinding:
      position: 101
      prefix: --local-id-mapping
  - id: max_memory
    type:
      - 'null'
      - string
    doc: Maximum memory to use (in Gb)
    inputBinding:
      position: 101
      prefix: --max-memory
  - id: max_target_seqs
    type:
      - 'null'
      - int
    doc: Number of annotations to output per sequence inputed
    inputBinding:
      position: 101
      prefix: --max-target-seqs
  - id: max_tries
    type:
      - 'null'
      - int
    doc: How many times to try obtaining information from UniProt before giving 
      up
    inputBinding:
      position: 101
      prefix: --max-tries
  - id: mirror
    type:
      - 'null'
      - string
    doc: From where to download UniProt database
    inputBinding:
      position: 101
      prefix: --mirror
  - id: no_annotation
    type:
      - 'null'
      - boolean
    doc: Do not perform annotation - input must be in one of BLAST result or TXT
      IDs file or STDIN
    inputBinding:
      position: 101
      prefix: --no-annotation
  - id: output
    type:
      - 'null'
      - Directory
    doc: Folder to store outputs
    inputBinding:
      position: 101
      prefix: --output
  - id: pident
    type:
      - 'null'
      - string
    doc: Minimum pident to report annotations for.
    inputBinding:
      position: 101
      prefix: --pident
  - id: resources_directory
    type:
      - 'null'
      - Directory
    doc: Directory to store resources of UPIMAPI
    inputBinding:
      position: 101
      prefix: --resources-directory
  - id: show_available_fields
    type:
      - 'null'
      - boolean
    doc: Outputs the fields available from the API.
    inputBinding:
      position: 101
      prefix: --show-available-fields
  - id: skip_db_check
    type:
      - 'null'
      - boolean
    doc: So UPIMAPI doesn't check for (FASTA) database existence
    inputBinding:
      position: 101
      prefix: --skip-db-check
  - id: skip_id_checking
    type:
      - 'null'
      - boolean
    doc: If true, UPIMAPI will not check if IDs are valid before mapping
    inputBinding:
      position: 101
      prefix: --skip-id-checking
  - id: skip_id_mapping
    type:
      - 'null'
      - boolean
    doc: If true, UPIMAPI will not perform ID mapping
    inputBinding:
      position: 101
      prefix: --skip-id-mapping
  - id: sleep
    type:
      - 'null'
      - float
    doc: Time between requests (in seconds)
    inputBinding:
      position: 101
      prefix: --sleep
  - id: step
    type:
      - 'null'
      - int
    doc: How many IDs to submit per request to the API
    inputBinding:
      position: 101
      prefix: --step
  - id: taxids
    type:
      - 'null'
      - string
    doc: Tax IDs to obtain protein sequences of for building a reference 
      database.
    inputBinding:
      position: 101
      prefix: --taxids
  - id: threads
    type:
      - 'null'
      - string
    doc: Number of threads to use in annotation steps
    inputBinding:
      position: 101
      prefix: --threads
  - id: to_db
    type:
      - 'null'
      - string
    doc: To which database the IDs should be mapped. If only interested in 
      columns information (which include cross-references), default is fine
    inputBinding:
      position: 101
      prefix: --to-db
outputs:
  - id: output_table
    type:
      - 'null'
      - File
    doc: Filename of table output, where UniProt info is stored. If set, will 
      override 'output' parameter just for that specific file
    outputBinding:
      glob: $(inputs.output_table)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/upimapi:1.13.3--hdfd78af_0
