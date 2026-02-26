cwlVersion: v1.2
class: CommandLineTool
baseCommand: matam_assembly.py
label: matam_matam_assembly.py
doc: "MATAM assembly\n\nTool homepage: https://github.com/bonsai-team/matam"
inputs:
  - id: assembler
    type:
      - 'null'
      - string
    doc: Select the assembler to be used. Default is SGA
    default: SGA
    inputBinding:
      position: 101
      prefix: --assembler
  - id: best
    type:
      - 'null'
      - int
    doc: "Get up to --best good alignments per read.\n                           \
      \                                              Default is 10"
    default: 10
    inputBinding:
      position: 101
      prefix: --best
  - id: contigs_binning
    type:
      - 'null'
      - boolean
    doc: "Experimental. Perform contigs binning during\n                         \
      \                                                scaffolding."
    inputBinding:
      position: 101
      prefix: --contigs_binning
  - id: coverage_threshold
    type:
      - 'null'
      - int
    doc: "Ref coverage threshold. By default set to 0 to\n                       \
      \                                                  desactivate filtering"
    default: 0
    inputBinding:
      position: 101
      prefix: --coverage_threshold
  - id: cpu
    type:
      - 'null'
      - int
    doc: Max number of CPU to use. Default is 1 cpu
    default: 1
    inputBinding:
      position: 101
      prefix: --cpu
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Output debug infos
    inputBinding:
      position: 101
      prefix: --debug
  - id: evalue
    type:
      - 'null'
      - float
    doc: "Max e-value to keep an alignment for. Default\n                        \
      \                                                 is 1e-05"
    default: '1e-05'
    inputBinding:
      position: 101
      prefix: --evalue
  - id: filter_only
    type:
      - 'null'
      - boolean
    doc: "Perform only the first step of MATAM (i.e Reads\n                      \
      \                                                   mapping against ref db with
      sortmerna to filter\n                                                      \
      \                   the reads). Relevant options for this step\n           \
      \                                                              correspond to
      the \"Read mapping\" section."
    inputBinding:
      position: 101
      prefix: --filter_only
  - id: input_fastq
    type: File
    doc: Input reads file (fasta or fastq format)
    inputBinding:
      position: 101
      prefix: --input_fastq
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: Do not remove tmp files
    inputBinding:
      position: 101
      prefix: --keep_tmp
  - id: max_memory
    type:
      - 'null'
      - int
    doc: "Maximum memory to use (in MBi). Default is\n                           \
      \                                              10000 MBi"
    default: 10000
    inputBinding:
      position: 101
      prefix: --max_memory
  - id: min_identity
    type:
      - 'null'
      - float
    doc: Minimum identity of an overlap between 2 reads. Default is 1.0
    default: 1.0
    inputBinding:
      position: 101
      prefix: --min_identity
  - id: min_overlap_edge
    type:
      - 'null'
      - int
    doc: "Minimum number of overlap to keep an edge.\n                           \
      \                                              Default is 1"
    default: 1
    inputBinding:
      position: 101
      prefix: --min_overlap_edge
  - id: min_overlap_length
    type:
      - 'null'
      - int
    doc: Minimum length of an overlap. Default is 50
    default: 50
    inputBinding:
      position: 101
      prefix: --min_overlap_length
  - id: min_read_node
    type:
      - 'null'
      - int
    doc: "Minimum number of read to keep a node. Default\n                       \
      \                                                  is 1"
    default: 1
    inputBinding:
      position: 101
      prefix: --min_read_node
  - id: min_scaffold_length
    type:
      - 'null'
      - int
    doc: Filter out small scaffolds
    inputBinding:
      position: 101
      prefix: --min_scaffold_length
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: "Output directory.Default will be\n                                     \
      \                                    \"matam_assembly\""
    default: matam_assembly
    inputBinding:
      position: 101
      prefix: --out_dir
  - id: perform_taxonomic_assignment
    type:
      - 'null'
      - boolean
    doc: Do the taxonomic assignment
    inputBinding:
      position: 101
      prefix: --perform_taxonomic_assignment
  - id: quorum
    type:
      - 'null'
      - float
    doc: "Quorum for LCA computing. Has to be between\n                          \
      \                                               0.51 and 1. Default is 0.51"
    default: 0.51
    inputBinding:
      position: 101
      prefix: --quorum
  - id: rdp_cutoff
    type:
      - 'null'
      - float
    doc: "Sequences assigned (by RDP) with a confidence\n                        \
      \                                                 score < 0.8 (at genus level)
      will be tagged as\n                                                        \
      \                 an artificial \"unclassified\" taxon"
    inputBinding:
      position: 101
      prefix: --rdp_cutoff
  - id: read_correction
    type:
      - 'null'
      - string
    doc: "Set the assembler read correction step. 'auto'\n                       \
      \                                                  means assemble the components
      with read\n                                                                \
      \         correction enabled when the components coverage\n                \
      \                                                         are sufficient (20X)
      and assemble the other\n                                                   \
      \                      components without read correction. Default is\n    \
      \                                                                     auto"
    default: auto
    inputBinding:
      position: 101
      prefix: --read_correction
  - id: ref_db
    type:
      - 'null'
      - Directory
    doc: "MATAM ref db. Default is\n                                             \
      \                            $MATAM_DIR/db/SILVA_128_SSURef_NR95"
    default: $MATAM_DIR/db/SILVA_128_SSURef_NR95
    inputBinding:
      position: 101
      prefix: --ref_db
  - id: resume_from
    type:
      - 'null'
      - string
    doc: "Try to resume from given step. Steps are:\n                            \
      \                                             reads_mapping, alignments_filtering,\n\
      \                                                                         overlap_graph_building,
      graph_compaction,\n                                                        \
      \                 contigs_assembly, scaffolding,\n                         \
      \                                                abundance_calculation, taxonomic_assignment"
    inputBinding:
      position: 101
      prefix: --resume_from
  - id: score_threshold
    type:
      - 'null'
      - float
    doc: "Score threshold (real between 0 and 1). Default\n                      \
      \                                                   is 0.9"
    default: 0.9
    inputBinding:
      position: 101
      prefix: --score_threshold
  - id: seed
    type:
      - 'null'
      - int
    doc: "Seed to initialize random generator. Default is\n                      \
      \                                                   picking seed from system
      time"
    inputBinding:
      position: 101
      prefix: --seed
  - id: straight_mode
    type:
      - 'null'
      - boolean
    doc: "Use straight mode filtering. Default is\n                              \
      \                                           geometric mode"
    inputBinding:
      position: 101
      prefix: --straight_mode
  - id: training_model
    type:
      - 'null'
      - string
    doc: "The training model used for taxonomic\n                                \
      \                                         assignment. Default is 16srrna"
    default: 16srrna
    inputBinding:
      position: 101
      prefix: --training_model
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase verbosity
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/matam:1.6.2--haf24da9_0
stdout: matam_matam_assembly.py.out
