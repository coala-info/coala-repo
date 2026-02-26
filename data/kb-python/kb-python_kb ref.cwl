cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kb
  - ref
label: kb-python_kb ref
doc: "Build a kallisto index and transcript-to-gene mapping\n\nTool homepage: https://github.com/pachterlab/kb_python"
inputs:
  - id: fasta
    type:
      type: array
      items: File
    doc: Genomic FASTA file(s), comma-delimited
    inputBinding:
      position: 1
  - id: gtf
    type:
      - 'null'
      - type: array
        items: File
    doc: Reference GTF file(s), comma-delimited [not required with --aa]
    inputBinding:
      position: 2
  - id: feature
    type:
      - 'null'
      - string
    doc: '[`kite` workflow only] Path to TSV containing barcodes and feature names.'
    inputBinding:
      position: 3
  - id: aa
    type:
      - 'null'
      - boolean
    doc: Generate index from a FASTA-file containing amino acid sequences
    inputBinding:
      position: 104
      prefix: --aa
  - id: bustools
    type:
      - 'null'
      - File
    doc: 'Path to bustools binary to use (default: /usr/local/lib/python3.12/site-packages/kb_python/bins/linux/bustools/bustools)'
    inputBinding:
      position: 104
      prefix: --bustools
  - id: d_list
    type:
      - 'null'
      - type: array
        items: File
    doc: 'D-list file(s) (default: the Genomic FASTA file(s) for standard/nac workflow)'
    inputBinding:
      position: 104
      prefix: --d-list
  - id: download_index
    type:
      - 'null'
      - string
    doc: Download a pre-built kallisto index (along with all necessary files) 
      instead of building it locally
    inputBinding:
      position: 104
      prefix: -d
  - id: exclude_attribute
    type:
      - 'null'
      - type: array
        items: string
    doc: Only process GTF entires that do not have the provided KEY:VALUE 
      attribute. May be specified multiple times.
    inputBinding:
      position: 104
      prefix: --exclude-attribute
  - id: fasta1
    type: File
    doc: '[Optional with -d] Path to the cDNA FASTA (standard, nac) or mismatch FASTA
      (kite) to be generated [Optional with --aa when no GTF file(s) provided] [Not
      used with --workflow=custom]'
    inputBinding:
      position: 104
      prefix: -f1
  - id: fasta2
    type:
      - 'null'
      - File
    doc: Path to the unprocessed transcripts FASTA to be generated
    inputBinding:
      position: 104
      prefix: -f2
  - id: include_attribute
    type:
      - 'null'
      - type: array
        items: string
    doc: Only process GTF entries that have the provided KEY:VALUE attribute. 
      May be specified multiple times.
    inputBinding:
      position: 104
      prefix: --include-attribute
  - id: index
    type: File
    doc: Path to the kallisto index to be constructed.
    inputBinding:
      position: 104
      prefix: -i
  - id: kallisto
    type:
      - 'null'
      - File
    doc: 'Path to kallisto binary to use (default: /usr/local/lib/python3.12/site-packages/kb_python/bins/linux/kallisto/kallisto)'
    inputBinding:
      position: 104
      prefix: --kallisto
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: Do not delete the tmp directory
    inputBinding:
      position: 104
      prefix: --keep-tmp
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: Use this option to override the k-mer length of the index. Usually, the
      k-mer length automatically calculated by `kb` provides the best results.
    inputBinding:
      position: 104
      prefix: -k
  - id: make_unique
    type:
      - 'null'
      - boolean
    doc: Replace repeated target names with unique names
    inputBinding:
      position: 104
      prefix: --make-unique
  - id: opt_off
    type:
      - 'null'
      - boolean
    doc: Disable performance optimizations
    inputBinding:
      position: 104
      prefix: --opt-off
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite existing kallisto index
    inputBinding:
      position: 104
      prefix: --overwrite
  - id: t2c1
    type:
      - 'null'
      - File
    doc: Path to generate cDNA transcripts-to-capture
    inputBinding:
      position: 104
      prefix: -c1
  - id: t2c2
    type:
      - 'null'
      - File
    doc: Path to generate unprocessed transcripts-to-capture
    inputBinding:
      position: 104
      prefix: -c2
  - id: t2g
    type: File
    doc: Path to transcript-to-gene mapping to be generated
    inputBinding:
      position: 104
      prefix: -g
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to use (default: 8)'
    default: 8
    inputBinding:
      position: 104
      prefix: -t
  - id: tmp
    type:
      - 'null'
      - Directory
    doc: Override default temporary directory
    inputBinding:
      position: 104
      prefix: --tmp
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print debugging information
    inputBinding:
      position: 104
      prefix: --verbose
  - id: workflow
    type:
      - 'null'
      - string
    doc: 'The type of index to create. Use `nac` for an index type that can quantify
      nascent and mature RNA. Use `custom` for indexing targets directly. Use `kite`
      for feature barcoding. (default: standard)'
    default: standard
    inputBinding:
      position: 104
      prefix: --workflow
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kb-python:0.30.0--pyh7e72e81_0
stdout: kb-python_kb ref.out
