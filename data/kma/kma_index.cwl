cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kma
  - index
label: kma_index
doc: "kma_index creates the databases needed to run KMA, from a list of fasta files\
  \ given.\n\nTool homepage: https://bitbucket.org/genomicepidemiology/kma"
inputs:
  - id: input_fasta
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: -i
    doc: Input/query file name (fasta templates); can be given several times
    inputBinding:
      position: 1
  - id: output_prefix
    type: string
    doc: Output file prefix (default is the input/template file name)
    inputBinding:
      position: 2
      prefix: -o
  - id: batch_input
    type:
      - 'null'
      - File
    doc: Batch input file
    inputBinding:
      position: 3
      prefix: -batch
  - id: decon_file
    type:
      - 'null'
      - File
    doc: File with contamination
    inputBinding:
      position: 3
      prefix: -deCon
  - id: batch_decon
    type:
      - 'null'
      - File
    doc: Batch decon file
    inputBinding:
      position: 3
      prefix: -batchD
  - id: existing_db_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files of an existing database to add to (staged in the working directory so
      that add_to_db can name them)
  - id: add_to_db
    type:
      - 'null'
      - string
    doc: Add to existing DB (prefix of an existing database in the working directory)
    inputBinding:
      position: 3
      prefix: -t_db
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: Kmersize (default 16)
    inputBinding:
      position: 3
      prefix: -k
  - id: minimizer_size
    type:
      - 'null'
      - int
    doc: Minimizer size (default 16/False)
    inputBinding:
      position: 3
      prefix: -m
  - id: homopolymer_compression
    type:
      - 'null'
      - boolean
    doc: Homopolymer compression
    inputBinding:
      position: 3
      prefix: -hc
  - id: templates_are_orfs
    type:
      - 'null'
      - boolean
    doc: Templates are open reading frames
    inputBinding:
      position: 3
      prefix: -c
  - id: templates_are_cds
    type:
      - 'null'
      - boolean
    doc: Templates are CDSs
    inputBinding:
      position: 3
      prefix: -C
  - id: min_template_length
    type:
      - 'null'
      - int
    doc: Minimum length of templates (default kmersize)
    inputBinding:
      position: 3
      prefix: -ML
  - id: start_chain_size
    type:
      - 'null'
      - string
    doc: Start chain size (default 1 M)
    inputBinding:
      position: 3
      prefix: -CS
  - id: mega_db
    type:
      - 'null'
      - boolean
    doc: Mega DB
    inputBinding:
      position: 3
      prefix: -ME
  - id: no_index_dump
    type:
      - 'null'
      - boolean
    doc: Do not dump *.index.b
    inputBinding:
      position: 3
      prefix: -NI
  - id: sparse_prefix
    type:
      - 'null'
      - string
    doc: Make Sparse DB ('-' for no prefix)
    inputBinding:
      position: 3
      prefix: -Sparse
  - id: homology_template
    type:
      - 'null'
      - float
    doc: Homology template (default 1.0)
    inputBinding:
      position: 3
      prefix: -ht
  - id: homology_query
    type:
      - 'null'
      - float
    doc: Homology query (default 1.0)
    inputBinding:
      position: 3
      prefix: -hq
  - id: both_homology_thresholds
    type:
      - 'null'
      - boolean
    doc: Both homology thresholds have to be reached
    inputBinding:
      position: 3
      prefix: -and
  - id: no_bias_print
    type:
      - 'null'
      - boolean
    doc: No bias print
    inputBinding:
      position: 3
      prefix: -nbp
outputs:
  - id: db_files
    type:
      type: array
      items: File
    doc: Database files (*.comp.b, *.index.b, *.length.b, *.name, *.seq.b)
    outputBinding:
      glob: $(inputs.output_prefix).*
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.existing_db_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kma:1.6.8--h577a1d6_0
stdout: kma_index.out
