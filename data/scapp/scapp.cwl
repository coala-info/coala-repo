cwlVersion: v1.2
class: CommandLineTool
baseCommand: scapp
label: scapp
doc: "SCAPP extracts likely plasmids from de novo assembly graphs\n\nTool homepage:
  https://github.com/Shamir-Lab/SCAPP"
inputs:
  - id: bam
    type:
      - 'null'
      - File
    doc: BAM file resulting from aligning reads to contigs file, filtering for 
      best matches
    inputBinding:
      position: 101
      prefix: --bam
  - id: chromosome_len_thresh
    type:
      - 'null'
      - int
    doc: threshold for high confidence chromosome node length
    default: 10000
    inputBinding:
      position: 101
      prefix: --chromosome_len_thresh
  - id: chromosome_score_thresh
    type:
      - 'null'
      - float
    doc: threshold for high confidence chromosome node score
    default: 0.2
    inputBinding:
      position: 101
      prefix: --chromosome_score_thresh
  - id: classification_thresh
    type:
      - 'null'
      - float
    doc: threshold for classifying potential plasmid
    default: 0.5
    inputBinding:
      position: 101
      prefix: --classification_thresh
  - id: gene_match_thresh
    type:
      - 'null'
      - float
    doc: threshold for % identity and fraction of length to match plasmid genes
    default: 0.75
    inputBinding:
      position: 101
      prefix: --gene_match_thresh
  - id: good_cyc_dominated_thresh
    type:
      - 'null'
      - float
    doc: 'threshold for # of mate-pairs off the cycle in dominated node'
    default: 0.5
    inputBinding:
      position: 101
      prefix: --good_cyc_dominated_thresh
  - id: graph
    type: File
    doc: Assembly graph FASTG file to process
    inputBinding:
      position: 101
      prefix: --graph
  - id: max_cv
    type:
      - 'null'
      - float
    doc: 'Coefficient of variation used for pre-selection [default: 0.5, higher-->
      less restrictive]'
    default: 0.5
    inputBinding:
      position: 101
      prefix: --max_CV
  - id: max_k
    type:
      - 'null'
      - int
    doc: Integer reflecting maximum k value used by the assembler
    inputBinding:
      position: 101
      prefix: --max_k
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum length required for reporting
    default: 1000
    inputBinding:
      position: 101
      prefix: --min_length
  - id: num_processes
    type:
      - 'null'
      - int
    doc: Number of processes to use
    inputBinding:
      position: 101
      prefix: --num_processes
  - id: plasclass
    type:
      - 'null'
      - File
    doc: PlasClass score file with scores of the assembly graph nodes
    inputBinding:
      position: 101
      prefix: --plasclass
  - id: plasflow
    type:
      - 'null'
      - File
    doc: PlasFlow score file with scores of the assembly graph nodes
    inputBinding:
      position: 101
      prefix: --plasflow
  - id: plasmid_len_thresh
    type:
      - 'null'
      - int
    doc: threshold for high confidence plasmid node length
    default: 10000
    inputBinding:
      position: 101
      prefix: --plasmid_len_thresh
  - id: plasmid_score_thresh
    type:
      - 'null'
      - float
    doc: threshold for high confidence plasmid node score
    default: 0.9
    inputBinding:
      position: 101
      prefix: --plasmid_score_thresh
  - id: reads1
    type:
      - 'null'
      - File
    doc: 1st paired-end read file path
    inputBinding:
      position: 101
      prefix: --reads1
  - id: reads2
    type:
      - 'null'
      - File
    doc: 1st paired-end read file path
    inputBinding:
      position: 101
      prefix: --reads2
  - id: selfloop_mate_thresh
    type:
      - 'null'
      - float
    doc: threshold for self-loop off loop mates
    default: 0.1
    inputBinding:
      position: 101
      prefix: --selfloop_mate_thresh
  - id: selfloop_score_thresh
    type:
      - 'null'
      - float
    doc: threshold for self-loop plasmid score
    default: 0.9
    inputBinding:
      position: 101
      prefix: --selfloop_score_thresh
  - id: use_gene_hits
    type:
      - 'null'
      - boolean
    doc: Boolean flag of whether to use plasmid-specific gene hits in plasmid 
      assembly
    inputBinding:
      position: 101
      prefix: --use_gene_hits
  - id: use_scores
    type:
      - 'null'
      - boolean
    doc: Boolean flag of whether to use sequence classification scores in 
      plasmid assembly
    inputBinding:
      position: 101
      prefix: --use_scores
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scapp:0.1.4--py_0
