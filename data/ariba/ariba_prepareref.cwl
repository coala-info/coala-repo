cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ariba
  - prepareref
label: ariba_prepareref
doc: "Prepare reference data for running the pipeline with \"ariba run\"\n\nTool homepage: https://github.com/sanger-pathogens/ariba"
inputs:
  - id: outdir
    type: string
    doc: "Output directory (must not already exist)"
    default: prepareref_out
    inputBinding:
      position: 10
  - id: fasta
    type:
      type: array
      items: File
      inputBinding:
        prefix: --fasta
    doc: "REQUIRED. Name of fasta file. Can be used more than once if your sequences are spread over more than one file"
    inputBinding:
      position: 1
  - id: metadata
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --metadata
    doc: "Name of tsv file of metadata about the input sequences. Can be used more than once. Incompatible with --all_coding"
    inputBinding:
      position: 1
  - id: all_coding
    type:
      - 'null'
      - string
    doc: "Use this if you only have a fasta of presence absence sequences as input, and no metadata. Use \"yes\" if all sequences are coding, or \"no\" if they are all non-coding. Incompatible with -m/--metadata"
    inputBinding:
      position: 1
      prefix: --all_coding
  - id: no_cdhit
    type:
      - 'null'
      - boolean
    doc: "Do not run cd-hit. Each input sequence is put into its own \"cluster\". Incompatible with --cdhit_clusters."
    inputBinding:
      position: 1
      prefix: --no_cdhit
  - id: cdhit_clusters
    type:
      - 'null'
      - File
    doc: "File specifying how the sequences should be clustered. Will be used instead of running cdhit. Incompatible with --no_cdhit"
    inputBinding:
      position: 1
      prefix: --cdhit_clusters
  - id: cdhit_min_id
    type:
      - 'null'
      - float
    doc: "Sequence identity threshold (cd-hit option -c) [0.9]"
    inputBinding:
      position: 1
      prefix: --cdhit_min_id
  - id: cdhit_min_length
    type:
      - 'null'
      - float
    doc: "Length difference cutoff (cd-hit option -s) [0.0]"
    inputBinding:
      position: 1
      prefix: --cdhit_min_length
  - id: cdhit_max_memory
    type:
      - 'null'
      - int
    doc: "Memory limit in MB (cd-hit option -M). Use 0 for unlimited."
    inputBinding:
      position: 1
      prefix: --cdhit_max_memory
  - id: min_gene_length
    type:
      - 'null'
      - int
    doc: "Minimum allowed length in nucleotides of reference genes [6]"
    inputBinding:
      position: 1
      prefix: --min_gene_length
  - id: max_gene_length
    type:
      - 'null'
      - int
    doc: "Maximum allowed length in nucleotides of reference genes [10000]"
    inputBinding:
      position: 1
      prefix: --max_gene_length
  - id: min_noncoding_length
    type:
      - 'null'
      - int
    doc: "Minimum allowed length in nucleotides of non-coding sequences [6]"
    inputBinding:
      position: 1
      prefix: --min_noncoding_length
  - id: max_noncoding_length
    type:
      - 'null'
      - int
    doc: "Maximum allowed length in nucleotides of non-coding sequences [20000]"
    inputBinding:
      position: 1
      prefix: --max_noncoding_length
  - id: genetic_code
    type:
      - 'null'
      - int
    doc: "Number of genetic code to use. Currently supported 1,4,11 [11]"
    inputBinding:
      position: 1
      prefix: --genetic_code
  - id: force
    type:
      - 'null'
      - boolean
    doc: "Overwrite output directory, if it already exists"
    inputBinding:
      position: 1
      prefix: --force
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads (currently only applies to cdhit) [1]"
    inputBinding:
      position: 1
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Be verbose"
    inputBinding:
      position: 1
      prefix: --verbose
outputs:
  - id: prepareref_dir
    type: Directory
    doc: Prepared reference directory, input to ariba run
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ariba:2.14.7--py310h5140242_0
