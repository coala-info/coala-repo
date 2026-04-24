cwlVersion: v1.2
class: CommandLineTool
baseCommand: melon
label: melon
doc: "Melon v0.3.0: metagenomic long-read-based taxonomic identification and quantification
  using marker genes\n\nTool homepage: https://github.com/xinehc/melon"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input fasta <*.fa|*.fasta> or fastq <*.fq|*.fastq> file, gzip optional 
      <*.gz>.
    inputBinding:
      position: 1
  - id: db
    type: Directory
    doc: Unzipped database folder, should contains <prot.fa>, <nucl.*.fa> and 
      <metadata.tsv>.
    inputBinding:
      position: 102
      prefix: --db
  - id: db_kraken
    type:
      - 'null'
      - Directory
    doc: Unzipped kraken2 database for pre-filtering of non-prokaryotic reads. 
      Skip if not given.
    inputBinding:
      position: 102
      prefix: --db-kraken
  - id: em_epsilon
    type:
      - 'null'
      - float
    doc: Terminal condition for EM - epsilon (precision).
    inputBinding:
      position: 102
      prefix: -c
  - id: em_max_iterations
    type:
      - 'null'
      - int
    doc: Terminal condition for EM - max. iterations.
    inputBinding:
      position: 102
      prefix: -a
  - id: evalue
    type:
      - 'null'
      - float
    doc: Max. expected value to report alignments (--evalue/-e in diamond).
    inputBinding:
      position: 102
      prefix: -e
  - id: max_secondary_alignments
    type:
      - 'null'
      - int
    doc: Max. number of secondary alignments to report (-N in minimap2).
    inputBinding:
      position: 102
      prefix: -n
  - id: max_target_seqs
    type:
      - 'null'
      - int
    doc: Max. number of target sequences to report (--max-target-seqs/-k in 
      diamond).
    inputBinding:
      position: 102
      prefix: -m
  - id: min_identity
    type:
      - 'null'
      - float
    doc: Min. identity in percentage to report alignments (--id in diamond).
    inputBinding:
      position: 102
      prefix: -i
  - id: min_unique_marker_genes
    type:
      - 'null'
      - int
    doc: Min. number of unique marker genes required for a species to report its
      genome copies.
    inputBinding:
      position: 102
      prefix: -g
  - id: secondary_to_primary_ratio
    type:
      - 'null'
      - float
    doc: Min. secondary-to-primary score ratio to report secondary alignments 
      (-p in minimap2).
    inputBinding:
      position: 102
      prefix: -p
  - id: skip_clean
    type:
      - 'null'
      - boolean
    doc: Skip cleaning, keep all temporary <*.tmp> files.
    inputBinding:
      position: 102
      prefix: --skip-clean
  - id: skip_profile
    type:
      - 'null'
      - boolean
    doc: Skip profiling, output only total genome copies.
    inputBinding:
      position: 102
      prefix: --skip-profile
  - id: subject_cover
    type:
      - 'null'
      - float
    doc: Min. subject cover to report alignments (--subject-cover in diamond).
    inputBinding:
      position: 102
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads.
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output
    type: Directory
    doc: Output folder.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/melon:0.3.0--pyhdfd78af_0
