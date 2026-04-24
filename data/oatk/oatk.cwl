cwlVersion: v1.2
class: CommandLineTool
baseCommand: oatk
label: oatk
doc: "Assembly and annotation of mitochondrial and plastid genomes\n\nTool homepage:
  https://github.com/c-zhou/oatk"
inputs:
  - id: target_fasta
    type:
      type: array
      items: File
    doc: Input FASTA/FASTQ file(s) (can be gzipped)
    inputBinding:
      position: 1
  - id: batch_size
    type:
      - 'null'
      - int
    doc: batch size
    inputBinding:
      position: 102
      prefix: -b
  - id: edge_c_tag
    type:
      - 'null'
      - string
    doc: edge coverage tag in the GFA file
    inputBinding:
      position: 102
      prefix: --edge-c-tag
  - id: include_rrn
    type:
      - 'null'
      - boolean
    doc: include rRNA genes for sequence classification
    inputBinding:
      position: 102
      prefix: --include-rrn
  - id: include_trn
    type:
      - 'null'
      - boolean
    doc: include tRNA genes for sequence classification
    inputBinding:
      position: 102
      prefix: --include-trn
  - id: kmer_c_tag
    type:
      - 'null'
      - string
    doc: kmer coverage tag in the GFA file
    inputBinding:
      position: 102
      prefix: --kmer-c-tag
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: kmer size
    inputBinding:
      position: 102
      prefix: -k
  - id: max_bubble
    type:
      - 'null'
      - int
    doc: maximum bubble size for assembly graph clean
    inputBinding:
      position: 102
      prefix: --max-bubble
  - id: max_copy_number
    type:
      - 'null'
      - int
    doc: maximum copy number to consider
    inputBinding:
      position: 102
      prefix: -C
  - id: max_core_gene_evalue
    type:
      - 'null'
      - float
    doc: maximum E-value of a core gene
    inputBinding:
      position: 102
      prefix: -e
  - id: max_data_amount
    type:
      - 'null'
      - int
    doc: maximum amount of data to use; suffix K/M/G recognized
    inputBinding:
      position: 102
      prefix: -D
  - id: max_tip
    type:
      - 'null'
      - int
    doc: maximum tip size for assembly graph clean
    inputBinding:
      position: 102
      prefix: --max-tip
  - id: min_arc_coverage
    type:
      - 'null'
      - float
    doc: minimum arc coverage
    inputBinding:
      position: 102
      prefix: -a
  - id: min_core_gene_gain
    type:
      - 'null'
      - string
    doc: minimum number of core gene gain; the second INT for mitochondria
    inputBinding:
      position: 102
      prefix: -g
  - id: min_core_gene_score
    type:
      - 'null'
      - float
    doc: minimum annotation score of a core gene
    inputBinding:
      position: 102
      prefix: -S
  - id: min_kmer_coverage
    type:
      - 'null'
      - int
    doc: minimum kmer coverage
    inputBinding:
      position: 102
      prefix: -c
  - id: min_sequence_coverage_ratio
    type:
      - 'null'
      - float
    doc: minimum coverage of a sequence compared to the subgraph average
    inputBinding:
      position: 102
      prefix: -q
  - id: min_singleton_length
    type:
      - 'null'
      - int
    doc: minimum length of a singleton sequence to keep
    inputBinding:
      position: 102
      prefix: -l
  - id: minicircle_mode
    type:
      - 'null'
      - boolean
    doc: run minicircle mode for small animal mitochondria or plasmid
    inputBinding:
      position: 102
      prefix: -M
  - id: mito_hmm_db
    type:
      - 'null'
      - File
    doc: mitochondria gene annotation HMM profile database
    inputBinding:
      position: 102
      prefix: -m
  - id: nhmmscan_path
    type:
      - 'null'
      - string
    doc: nhmmscan executable path
    inputBinding:
      position: 102
      prefix: --nhmmscan
  - id: no_graph_clean
    type:
      - 'null'
      - boolean
    doc: do not do assembly graph clean
    inputBinding:
      position: 102
      prefix: --no-graph-clean
  - id: no_read_ec
    type:
      - 'null'
      - boolean
    doc: do not do read error correction
    inputBinding:
      position: 102
      prefix: --no-read-ec
  - id: plastid_hmm_db
    type:
      - 'null'
      - File
    doc: plastid gene annotation HMM profile database
    inputBinding:
      position: 102
      prefix: -p
  - id: prefer_circular_path
    type:
      - 'null'
      - float
    doc: prefer circular path to longest if >= FLOAT sequence covered
    inputBinding:
      position: 102
      prefix: -f
  - id: seq_c_tag
    type:
      - 'null'
      - string
    doc: sequence coverage tag in the GFA file
    inputBinding:
      position: 102
      prefix: --seq-c-tag
  - id: smer_size
    type:
      - 'null'
      - int
    doc: smer size (no larger than 31)
    inputBinding:
      position: 102
      prefix: -s
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: temporary directory
    inputBinding:
      position: 102
      prefix: -T
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 102
      prefix: -t
  - id: unzip_round
    type:
      - 'null'
      - int
    doc: maximum round of assembly graph unzipping
    inputBinding:
      position: 102
      prefix: --unzip-round
  - id: use_assembly_graph
    type:
      - 'null'
      - boolean
    doc: using input FILE as assembly graph file instead of raw reads for 
      Syncasm
    inputBinding:
      position: 102
      prefix: -G
  - id: verbose_level
    type:
      - 'null'
      - int
    doc: verbose level
    inputBinding:
      position: 102
      prefix: -v
  - id: weak_cross
    type:
      - 'null'
      - float
    doc: maximum relative edge coverage for weak crosslink clean
    inputBinding:
      position: 102
      prefix: --weak-cross
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: prefix of output files
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oatk:1.0--h577a1d6_1
