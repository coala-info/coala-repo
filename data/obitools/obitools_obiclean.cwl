cwlVersion: v1.2
class: CommandLineTool
baseCommand: obiclean
label: obitools_obiclean
doc: "The obiclean program is used to clean a set of sequences by looking for PCR
  errors. It tags each sequence record as head, internal or singleton using sequence
  counts and similarities.\n\nTool homepage: http://metabarcoding.org/obitools"
inputs:
  - id: input_file
    type: File
    doc: Input sequence file (for example in fasta or fastq format).
    inputBinding:
      position: 1
  - id: distance
    type:
      - 'null'
      - int
    doc: Maximum numbers of errors between two variant sequences.
    inputBinding:
      position: 102
      prefix: --distance
  - id: sample
    type:
      - 'null'
      - string
    doc: Tag containing sample descriptions.
    inputBinding:
      position: 102
      prefix: --sample
  - id: graph
    type:
      - 'null'
      - string
    doc: File name where the clustering graphs are saved.
    inputBinding:
      position: 102
      prefix: --graph
  - id: ratio
    type:
      - 'null'
      - float
    doc: Minimum ratio between counts of two sequence records so that the less abundant one can be considered as a variant of the more abundant.
    inputBinding:
      position: 102
      prefix: --ratio
  - id: head
    type:
      - 'null'
      - boolean
    doc: Outputs only head tagged sequence records.
    inputBinding:
      position: 102
      prefix: --head
  - id: cluster
    type:
      - 'null'
      - boolean
    doc: Set obiclean in clustering mode.
    inputBinding:
      position: 102
      prefix: --cluster
  - id: skip
    type:
      - 'null'
      - int
    doc: Skip the N first sequences.
    inputBinding:
      position: 102
      prefix: --skip
  - id: only
    type:
      - 'null'
      - int
    doc: Treat only N sequences.
    inputBinding:
      position: 102
      prefix: --only
  - id: genbank
    type:
      - 'null'
      - boolean
    doc: Input file is in genbank format.
    inputBinding:
      position: 102
      prefix: --genbank
  - id: embl
    type:
      - 'null'
      - boolean
    doc: Input file is in embl format.
    inputBinding:
      position: 102
      prefix: --embl
  - id: skip_on_error
    type:
      - 'null'
      - boolean
    doc: Skip sequence entries with parse error.
    inputBinding:
      position: 102
      prefix: --skip-on-error
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: Input file is in fasta nucleic format (including obitools fasta extentions).
    inputBinding:
      position: 102
      prefix: --fasta
  - id: ecopcr
    type:
      - 'null'
      - boolean
    doc: Input file is in ecopcr format.
    inputBinding:
      position: 102
      prefix: --ecopcr
  - id: raw_fasta
    type:
      - 'null'
      - boolean
    doc: Input file is in fasta format (but more tolerant to format variant).
    inputBinding:
      position: 102
      prefix: --raw-fasta
  - id: sanger
    type:
      - 'null'
      - boolean
    doc: Input file is in sanger fastq nucleic format (standard fastq).
    inputBinding:
      position: 102
      prefix: --sanger
  - id: solexa
    type:
      - 'null'
      - boolean
    doc: Input file is in fastq nucleic format produced by solexa sequencer.
    inputBinding:
      position: 102
      prefix: --solexa
  - id: ecopcrdb
    type:
      - 'null'
      - boolean
    doc: Input file is an ecopcr database.
    inputBinding:
      position: 102
      prefix: --ecopcrdb
  - id: nuc
    type:
      - 'null'
      - boolean
    doc: Input file contains nucleic sequences.
    inputBinding:
      position: 102
      prefix: --nuc
  - id: prot
    type:
      - 'null'
      - boolean
    doc: Input file contains protein sequences.
    inputBinding:
      position: 102
      prefix: --prot
  - id: fasta_output
    type:
      - 'null'
      - boolean
    doc: Output sequences in obitools fasta format.
    inputBinding:
      position: 102
      prefix: --fasta-output
  - id: fastq_output
    type:
      - 'null'
      - boolean
    doc: Output sequences in sanger fastq format.
    inputBinding:
      position: 102
      prefix: --fastq-output
  - id: ecopcrdb_output
    type:
      - 'null'
      - string
    doc: Output sequences in ecopcr database format (sequence records are not printed on standard output).
    inputBinding:
      position: 102
      prefix: --ecopcrdb-output
  - id: uppercase
    type:
      - 'null'
      - boolean
    doc: Print sequences in upper case (default is lower case).
    inputBinding:
      position: 102
      prefix: --uppercase
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Set logging in debug mode.
    inputBinding:
      position: 102
      prefix: --DEBUG
  - id: without_progress_bar
    type:
      - 'null'
      - boolean
    doc: Deactivate progress bar.
    inputBinding:
      position: 102
      prefix: --without-progress-bar
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: graph_files
    type:
      type: array
      items: File
    doc: Clustering graph files written when graph is given
    outputBinding:
      glob: "$(inputs.graph ? inputs.graph + '*' : 'no_graph_given')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/obitools:1.2.13--py27h516909a_0
stdout: obitools_obiclean.out
