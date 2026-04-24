cwlVersion: v1.2
class: CommandLineTool
baseCommand: argo
label: argo
doc: "species-resolved profiling of antibiotic resistance genes in complex metagenomes
  through long-read overlapping\n\nTool homepage: https://github.com/xinehc/argo"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input fasta <*.fa|*.fasta> or fastq <*.fq|*.fastq> file, gzip optional 
      <*.gz>.
    inputBinding:
      position: 1
  - id: db_dir
    type: Directory
    doc: Unzipped database folder, should contains <prot.fa|sarg.fa>, 
      <nucl.*.fa|sarg.*.fa> and metadata files.
    inputBinding:
      position: 102
      prefix: --db
  - id: evalue
    type:
      - 'null'
      - float
    doc: Max. expected value to report alignments (--evalue/-e in diamond).
    inputBinding:
      position: 102
      prefix: -e
  - id: max_arg_reads_per_chunk
    type:
      - 'null'
      - int
    doc: Max. number of ARG-containing reads per chunk for overlapping. If "0" 
      then use a single chunk.
    inputBinding:
      position: 102
      prefix: -u
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
  - id: mcl_expansion
    type:
      - 'null'
      - float
    doc: MCL parameter - expansion.
    inputBinding:
      position: 102
      prefix: -y
  - id: mcl_inflation
    type:
      - 'null'
      - float
    doc: MCL parameter - inflation.
    inputBinding:
      position: 102
      prefix: -x
  - id: mcl_max_iterations
    type:
      - 'null'
      - int
    doc: Terminal condition - max. iterations.
    inputBinding:
      position: 102
      prefix: -b
  - id: min_genome_copies
    type:
      - 'null'
      - float
    doc: Min. estimated genome copies of a species to report it ARG copies and 
      abundances.
    inputBinding:
      position: 102
      prefix: -z
  - id: min_identity
    type:
      - 'null'
      - float
    doc: Min. identity in percentage to report alignments. If "0" then set 90 - 
      2.5 * 100 * median sequence divergence.
    inputBinding:
      position: 102
      prefix: -i
  - id: min_secondary_primary_ratio
    type:
      - 'null'
      - float
    doc: Min. secondary-to-primary score ratio to report secondary alignments 
      (-p in minimap2).
    inputBinding:
      position: 102
      prefix: -p
  - id: min_subject_cover
    type:
      - 'null'
      - float
    doc: Min. subject cover within a read cluster to report alignments.
    inputBinding:
      position: 102
      prefix: -s
  - id: plasmid
    type:
      - 'null'
      - boolean
    doc: List ARGs carried by plasmids.
    inputBinding:
      position: 102
      prefix: --plasmid
  - id: skip_clean
    type:
      - 'null'
      - boolean
    doc: Skip cleaning, keep all temporary <*.tmp> files.
    inputBinding:
      position: 102
      prefix: --skip-clean
  - id: skip_melon
    type:
      - 'null'
      - boolean
    doc: Skip Melon for genome copy estimation.
    inputBinding:
      position: 102
      prefix: --skip-melon
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads.
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output_dir
    type: Directory
    doc: Output folder.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/argo:0.2.1--pyhdfd78af_0
