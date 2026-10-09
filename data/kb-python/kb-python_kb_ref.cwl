cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kb
  - ref
label: kb-python_kb_ref
doc: "Build a kallisto index and transcript-to-gene mapping\n\nTool homepage: https://github.com/pachterlab/kb_python"
inputs:
  - id: fasta
    type:
      type: array
      items: File
    doc: "Genomic FASTA file(s), comma-delimited"
    inputBinding:
      position: 1
      itemSeparator: ','
  - id: gtf
    type:
      - 'null'
      - type: array
        items: File
    doc: "Reference GTF file(s), comma-delimited [not required with --aa]"
    inputBinding:
      position: 2
      itemSeparator: ','
  - id: feature
    type:
      - 'null'
      - File
    doc: "[`kite` workflow only] Path to TSV containing barcodes and feature names."
    inputBinding:
      position: 3
  - id: tmp
    type:
      - 'null'
      - string
    doc: "Override default temporary directory"
    inputBinding:
      position: 104
      prefix: --tmp
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: "Do not delete the tmp directory"
    inputBinding:
      position: 104
      prefix: --keep-tmp
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Print debugging information"
    inputBinding:
      position: 104
      prefix: --verbose
  - id: index
    type: string
    doc: "Path to the kallisto index to be constructed."
    inputBinding:
      position: 104
      prefix: -i
  - id: t2g
    type: string
    doc: "Path to transcript-to-gene mapping to be generated"
    inputBinding:
      position: 104
      prefix: -g
  - id: fasta1
    type:
      - 'null'
      - string
    doc: "Path to the cDNA FASTA (standard, nac) or mismatch FASTA (kite) to be generated [Optional with -d] [Optional with --aa when no GTF file(s) provided] [Not used with --workflow=custom]"
    inputBinding:
      position: 104
      prefix: -f1
  - id: include_attribute
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --include-attribute
          separate: true
    doc: "Only process GTF entries that have the provided KEY:VALUE attribute. May be specified multiple times."
    inputBinding:
      position: 104
  - id: exclude_attribute
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --exclude-attribute
          separate: true
    doc: "Only process GTF entires that do not have the provided KEY:VALUE attribute. May be specified multiple times."
    inputBinding:
      position: 104
  - id: fasta2
    type:
      - 'null'
      - string
    doc: "Path to the unprocessed transcripts FASTA to be generated (nac workflow)"
    inputBinding:
      position: 104
      prefix: -f2
  - id: t2c1
    type:
      - 'null'
      - string
    doc: "Path to generate cDNA transcripts-to-capture (nac workflow)"
    inputBinding:
      position: 104
      prefix: -c1
  - id: t2c2
    type:
      - 'null'
      - string
    doc: "Path to generate unprocessed transcripts-to-capture (nac workflow)"
    inputBinding:
      position: 104
      prefix: -c2
  - id: download_index
    type:
      - 'null'
      - string
    doc: "Download a pre-built kallisto index (along with all necessary files) instead of building it locally"
    inputBinding:
      position: 104
      prefix: -d
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: "Use this option to override the k-mer length of the index."
    inputBinding:
      position: 104
      prefix: -k
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use (default: 8)"
    inputBinding:
      position: 104
      prefix: -t
  - id: d_list
    type:
      - 'null'
      - type: array
        items: File
    doc: "D-list file(s) (default: the Genomic FASTA file(s) for standard/nac workflow)"
    inputBinding:
      position: 104
      prefix: --d-list
      itemSeparator: ','
  - id: aa
    type:
      - 'null'
      - boolean
    doc: "Generate index from a FASTA-file containing amino acid sequences"
    inputBinding:
      position: 104
      prefix: --aa
  - id: workflow
    type:
      - 'null'
      - string
    doc: "The type of index to create: standard, nac, kite or custom (default: standard)"
    inputBinding:
      position: 104
      prefix: --workflow
  - id: make_unique
    type:
      - 'null'
      - boolean
    doc: "Replace repeated target names with unique names"
    inputBinding:
      position: 104
      prefix: --make-unique
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: "Overwrite existing kallisto index"
    inputBinding:
      position: 104
      prefix: --overwrite
  - id: kallisto
    type:
      - 'null'
      - string
    doc: "Path to kallisto binary to use (inside the container)"
    inputBinding:
      position: 104
      prefix: --kallisto
  - id: bustools
    type:
      - 'null'
      - string
    doc: "Path to bustools binary to use (inside the container)"
    inputBinding:
      position: 104
      prefix: --bustools
  - id: opt_off
    type:
      - 'null'
      - boolean
    doc: "Disable performance optimizations"
    inputBinding:
      position: 104
      prefix: --opt-off
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: index_file
    type:
      - 'null'
      - File
    doc: "The kallisto index"
    outputBinding:
      glob: $(inputs.index)
  - id: t2g_file
    type:
      - 'null'
      - File
    doc: "The transcript-to-gene mapping"
    outputBinding:
      glob: $(inputs.t2g)
  - id: cdna_fasta
    type:
      - 'null'
      - File
    doc: "The cDNA FASTA"
    outputBinding:
      glob: $(inputs.fasta1)
  - id: unprocessed_fasta
    type:
      - 'null'
      - File
    doc: "The unprocessed transcripts FASTA (nac workflow)"
    outputBinding:
      glob: $(inputs.fasta2)
  - id: t2c_mature_file
    type:
      - 'null'
      - File
    doc: "cDNA transcripts-to-capture (nac workflow)"
    outputBinding:
      glob: $(inputs.t2c1)
  - id: t2c_nascent_file
    type:
      - 'null'
      - File
    doc: "Unprocessed transcripts-to-capture (nac workflow)"
    outputBinding:
      glob: $(inputs.t2c2)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kb-python:0.30.0--pyh7e72e81_0
stdout: kb-python_kb_ref.out
