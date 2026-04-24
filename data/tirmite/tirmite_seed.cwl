cwlVersion: v1.2
class: CommandLineTool
baseCommand: tirmite_seed
label: tirmite_seed
doc: "Build HMM models from seed sequences for TIRmite\n\nTool homepage: https://github.com/Adamtaranto/TIRmite"
inputs:
  - id: flank_size
    type:
      - 'null'
      - int
    doc: Extract BLAST hits with flanking sequence of N bases and create 
      additional alignment (optional)
    inputBinding:
      position: 101
      prefix: --flank-size
  - id: genome
    type:
      - 'null'
      - File
    doc: Single genome FASTA file to search
    inputBinding:
      position: 101
      prefix: --genome
  - id: genome_list
    type:
      - 'null'
      - File
    doc: File containing list of genome paths (one per line)
    inputBinding:
      position: 101
      prefix: --genome-list
  - id: keep_temp
    type:
      - 'null'
      - boolean
    doc: Keep temporary files after completion
    inputBinding:
      position: 101
      prefix: --keep-temp
  - id: left_seed
    type: File
    doc: FASTA file containing left terminal seed sequence(s)
    inputBinding:
      position: 101
      prefix: --left-seed
  - id: loglevel
    type:
      - 'null'
      - string
    doc: Set logging level
    inputBinding:
      position: 101
      prefix: --loglevel
  - id: max_gap
    type:
      - 'null'
      - int
    doc: Maximum gap size for chaining fragmented hits
    inputBinding:
      position: 101
      prefix: --max-gap
  - id: min_coverage
    type:
      - 'null'
      - float
    doc: Minimum query coverage threshold as fraction 0.0-1.0
    inputBinding:
      position: 101
      prefix: --min-coverage
  - id: min_identity
    type:
      - 'null'
      - float
    doc: Minimum sequence identity threshold as percentage
    inputBinding:
      position: 101
      prefix: --min-identity
  - id: model_name
    type: string
    doc: Base name for the HMM model(s)
    inputBinding:
      position: 101
      prefix: --model-name
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory for results
    inputBinding:
      position: 101
      prefix: --outdir
  - id: right_seed
    type:
      - 'null'
      - File
    doc: FASTA file containing right terminal seed sequence(s) (optional for 
      asymmetric elements)
    inputBinding:
      position: 101
      prefix: --right-seed
  - id: save_blast_hits
    type:
      - 'null'
      - boolean
    doc: Save all BLAST hits in tabular format
    inputBinding:
      position: 101
      prefix: --save-blast-hits
  - id: tempdir
    type:
      - 'null'
      - Directory
    doc: 'Directory for temporary files (default: system temp)'
    inputBinding:
      position: 101
      prefix: --tempdir
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU threads to use for MAFFT alignment
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tirmite:1.3.0--pyhdfd78af_0
stdout: tirmite_seed.out
