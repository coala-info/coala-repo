cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - anvi-gen-contigs-database
label: anvio-minimal_anvi-gen-contigs-database
doc: "Generate an anvi'o contigs database from a FASTA file. This tool parses a FASTA
  file and creates a database that stores essential information about your contigs,
  such as k-mer frequencies and functional/taxonomic annotations.\n\nTool homepage:
  http://merenlab.org/software/anvio/index.html"
inputs:
  - id: description
    type:
      - 'null'
      - string
    doc: A plain text file containing a description of the project.
    inputBinding:
      position: 101
      prefix: --description
  - id: external_gene_calls
    type:
      - 'null'
      - File
    doc: A file containing external gene calls to be imported into the database.
    inputBinding:
      position: 101
      prefix: --external-gene-calls
  - id: fasta_file
    type: File
    doc: A FASTA-formatted input file containing your sequences.
    inputBinding:
      position: 101
      prefix: --fasta-file
  - id: ignore_internal_stop_codons
    type:
      - 'null'
      - boolean
    doc: Ignore internal stop codons in gene calls.
    inputBinding:
      position: 101
      prefix: --ignore-internal-stop-codons
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: K-mer size to be used for calculating k-mer frequencies.
    default: 4
    inputBinding:
      position: 101
      prefix: --kmer-size
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for parallel processes.
    default: 1
    inputBinding:
      position: 101
      prefix: --num-threads
  - id: project_name
    type:
      - 'null'
      - string
    doc: A name for the project.
    inputBinding:
      position: 101
      prefix: --project-name
  - id: skip_gene_calling
    type:
      - 'null'
      - boolean
    doc: Skip the gene calling step (useful if you are providing external gene calls).
    inputBinding:
      position: 101
      prefix: --skip-gene-calling
  - id: skip_mindful_splitting
    type:
      - 'null'
      - boolean
    doc: By default, anvi'o tries to split contigs without cutting through genes.
      This flag disables that behavior.
    inputBinding:
      position: 101
      prefix: --skip-mindful-splitting
  - id: split_length
    type:
      - 'null'
      - int
    doc: The size of the splits for each contig.
    default: 20000
    inputBinding:
      position: 101
      prefix: --split-length
outputs:
  - id: output_db
    type:
      - 'null'
      - File
    doc: The output contigs database file (usually ends in .db).
    outputBinding:
      glob: $(inputs.output_db)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/anvio-minimal:9--pyhdfd78af_0
