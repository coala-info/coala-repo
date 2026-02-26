cwlVersion: v1.2
class: CommandLineTool
baseCommand: liftoff
label: liftoff
doc: "Lift features from one genome assembly to another\n\nTool homepage: https://github.com/agshumate/Liftoff"
inputs:
  - id: target
    type: File
    doc: target fasta genome to lift genes to
    inputBinding:
      position: 1
  - id: reference
    type: File
    doc: reference fasta genome to lift genes from
    inputBinding:
      position: 2
  - id: annotate_cds_status
    type:
      - 'null'
      - boolean
    doc: annotate status of each CDS (partial, missing start, missing stop, 
      inframe stop codon)
    inputBinding:
      position: 103
      prefix: -cds
  - id: chromosomes_file
    type:
      - 'null'
      - File
    doc: comma seperated file with corresponding chromosomes in the 
      reference,target sequences
    inputBinding:
      position: 103
      prefix: -chroms
  - id: coverage_threshold
    type:
      - 'null'
      - float
    doc: designate a feature mapped only if it aligns with coverage ≥A; by 
      default A=0.5
    default: 0.5
    inputBinding:
      position: 103
      prefix: -a
  - id: db
    type: string
    doc: name of feature database; if not specified, the -g argument must be 
      provided and a database will be built automatically
    inputBinding:
      position: 103
      prefix: -db
  - id: distance_scaling_factor
    type:
      - 'null'
      - float
    doc: distance scaling factor; alignment nodes separated by more than a 
      factor of D in the target genome will not be connected in the graph; by 
      default D=2.0
    default: 2.0
    inputBinding:
      position: 103
      prefix: -d
  - id: exclude_partial
    type:
      - 'null'
      - boolean
    doc: write partial mappings below -s and -a threshold to 
      unmapped_features.txt; if true partial/low sequence identity mappings will
      be included in the gff file with partial_mapping=True, low_identity=True 
      in comments
    inputBinding:
      position: 103
      prefix: -exclude_partial
  - id: feature_types
    type:
      - 'null'
      - type: array
        items: string
    doc: list of feature types to lift over
    inputBinding:
      position: 103
      prefix: -f
  - id: flank_sequence_fraction
    type:
      - 'null'
      - float
    doc: amount of flanking sequence to align as a fraction [0.0-1.0] of gene 
      length. This can improve gene alignment where gene structure differs 
      between target and reference; by default F=0.0
    default: 0.0
    inputBinding:
      position: 103
      prefix: -flank
  - id: gap_extend_penalty
    type:
      - 'null'
      - int
    doc: gap extend penalty in exons when finding best mapping; by default GE=1
    default: 1
    inputBinding:
      position: 103
      prefix: -gap_extend
  - id: gap_open_penalty
    type:
      - 'null'
      - int
    doc: gap open penalty in exons when finding best mapping; by default GO=2
    default: 2
    inputBinding:
      position: 103
      prefix: -gap_open
  - id: gff_file
    type: File
    doc: annotation file to lift over in GFF or GTF format
    inputBinding:
      position: 103
      prefix: -g
  - id: infer_genes
    type:
      - 'null'
      - boolean
    doc: use if annotation file only includes transcripts, exon/CDS features
    inputBinding:
      position: 103
      prefix: -infer_genes
  - id: infer_transcripts
    type:
      - 'null'
      - boolean
    doc: use if annotation file only includes exon/CDS features and does not 
      include transcripts/mRNA
    inputBinding:
      position: 103
      prefix: -infer_transcripts
  - id: intermediate_dir
    type:
      - 'null'
      - Directory
    doc: name of directory to save intermediate fasta and SAM files; default is 
      "intermediate_files"
    default: intermediate_files
    inputBinding:
      position: 103
      prefix: -dir
  - id: look_for_copies
    type:
      - 'null'
      - boolean
    doc: look for extra gene copies in the target genome
    inputBinding:
      position: 103
      prefix: -copies
  - id: max_overlap_fraction
    type:
      - 'null'
      - float
    doc: maximum fraction [0.0-1.0] of overlap allowed by 2 features; by default
      O=0.1
    default: 0.1
    inputBinding:
      position: 103
      prefix: -overlap
  - id: min_copy_sequence_identity
    type:
      - 'null'
      - float
    doc: with -copies, minimum sequence identity in exons/CDS for which a gene 
      is considered a copy; must be greater than -s; default is 1.0
    inputBinding:
      position: 103
      prefix: -sc
  - id: minimap2_path
    type:
      - 'null'
      - string
    doc: Minimap2 path
    inputBinding:
      position: 103
      prefix: -m
  - id: mismatch_penalty
    type:
      - 'null'
      - int
    doc: mismatch penalty in exons when finding best mapping; by default M=2
    default: 2
    inputBinding:
      position: 103
      prefix: -mismatch
  - id: mm2_options
    type:
      - 'null'
      - string
    doc: space delimited minimap2 parameters. By default ="-a --end-bonus 5 
      --eqx -N 50 -p 0.5"
    default: '"-a --end-bonus 5 --eqx -N 50 -p 0.5"'
    inputBinding:
      position: 103
      prefix: -mm2_options
  - id: parallel_processes
    type:
      - 'null'
      - int
    doc: use p parallel processes to accelerate alignment; by default p=1
    default: 1
    inputBinding:
      position: 103
      prefix: -p
  - id: polish
    type:
      - 'null'
      - boolean
    doc: polish
    inputBinding:
      position: 103
      prefix: -polish
  - id: sequence_identity_threshold
    type:
      - 'null'
      - float
    doc: designate a feature mapped only if its child features (usually 
      exons/CDS) align with sequence identity ≥S; by default S=0.5
    default: 0.5
    inputBinding:
      position: 103
      prefix: -s
  - id: unplaced_sequences_file
    type:
      - 'null'
      - File
    doc: text file with name(s) of unplaced sequences to map genes from after 
      genes from chromosomes in chroms.txt are mapped; default is 
      "unplaced_seq_names.txt"
    default: unplaced_seq_names.txt
    inputBinding:
      position: 103
      prefix: -unplaced
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: write output to FILE in same format as input; by default, output is 
      written to terminal (stdout)
    outputBinding:
      glob: $(inputs.output_file)
  - id: unmapped_file
    type:
      - 'null'
      - File
    doc: write unmapped features to FILE; default is "unmapped_features.txt"
    outputBinding:
      glob: $(inputs.unmapped_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/liftoff:1.6.3--pyhdfd78af_2
