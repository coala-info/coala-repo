cwlVersion: v1.2
class: CommandLineTool
baseCommand: exonerate
label: exonerate
doc: "A generic sequence comparison tool\n\nTool homepage: https://www.ebi.ac.uk/about/vertebrate-genomics/software/exonerate"
inputs:
  - id: annotation
    type:
      - 'null'
      - File
    doc: Path to sequence annotation file
    inputBinding:
      position: 101
      prefix: --annotation
  - id: best_n
    type:
      - 'null'
      - int
    doc: Report best N results per query
    inputBinding:
      position: 101
      prefix: --bestn
  - id: bigseq
    type:
      - 'null'
      - boolean
    doc: Allow rapid comparison between big sequences
    inputBinding:
      position: 101
      prefix: --bigseq
  - id: compiled
    type:
      - 'null'
      - boolean
    doc: Use compiled viterbi implementations
    inputBinding:
      position: 101
      prefix: --compiled
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of cores/CPUs/threads for alignment computation
    inputBinding:
      position: 101
      prefix: --cores
  - id: custom_server
    type:
      - 'null'
      - string
    doc: Custom command to send non-standard server
    inputBinding:
      position: 101
      prefix: --customserver
  - id: dna_sub_mat
    type:
      - 'null'
      - string
    doc: DNA substitution matrix
    inputBinding:
      position: 101
      prefix: --dnasubmat
  - id: dp_memory
    type:
      - 'null'
      - int
    doc: Maximum memory to use for DP tracebacks (Mb)
    inputBinding:
      position: 101
      prefix: --dpmemory
  - id: exhaustive
    type:
      - 'null'
      - boolean
    doc: Perform exhaustive alignment (slow)
    inputBinding:
      position: 101
      prefix: --exhaustive
  - id: extension_threshold
    type:
      - 'null'
      - int
    doc: Gapped extension threshold
    inputBinding:
      position: 101
      prefix: --extensionthreshold
  - id: fasta_suffix
    type:
      - 'null'
      - string
    doc: Fasta file suffix filter (in subdirectories)
    inputBinding:
      position: 101
      prefix: --fastasuffix
  - id: forcescan
    type:
      - 'null'
      - string
    doc: Force FSM scan on query or target sequences
    inputBinding:
      position: 101
      prefix: --forcescan
  - id: frameshift
    type:
      - 'null'
      - int
    doc: Frameshift creation penalty
    inputBinding:
      position: 101
      prefix: --frameshift
  - id: fsm_memory
    type:
      - 'null'
      - int
    doc: Memory limit for FSM scanning
    inputBinding:
      position: 101
      prefix: --fsmmemory
  - id: gap_extend
    type:
      - 'null'
      - int
    doc: Affine gap extend penalty
    inputBinding:
      position: 101
      prefix: --gapextend
  - id: gap_open
    type:
      - 'null'
      - int
    doc: Affine gap open penalty
    inputBinding:
      position: 101
      prefix: --gapopen
  - id: gapped_extension
    type:
      - 'null'
      - boolean
    doc: Use gapped extension (default is SDP)
    inputBinding:
      position: 101
      prefix: --gappedextension
  - id: genetic_code
    type:
      - 'null'
      - string
    doc: Use built-in or custom genetic code
    inputBinding:
      position: 101
      prefix: --geneticcode
  - id: intron_penalty
    type:
      - 'null'
      - int
    doc: Intron Opening penalty
    inputBinding:
      position: 101
      prefix: --intronpenalty
  - id: model
    type:
      - 'null'
      - string
    doc: Specify alignment model type
    inputBinding:
      position: 101
      prefix: --model
  - id: percent
    type:
      - 'null'
      - float
    doc: Percent self-score threshold
    inputBinding:
      position: 101
      prefix: --percent
  - id: protein_sub_mat
    type:
      - 'null'
      - string
    doc: Protein substitution matrix
    inputBinding:
      position: 101
      prefix: --proteinsubmat
  - id: query
    type: File
    doc: Specify query sequences as a fasta format file
    inputBinding:
      position: 101
      prefix: --query
  - id: query_chunk_id
    type:
      - 'null'
      - int
    doc: Specify query job number
    inputBinding:
      position: 101
      prefix: --querychunkid
  - id: query_chunk_total
    type:
      - 'null'
      - int
    doc: Specify total number of query jobs
    inputBinding:
      position: 101
      prefix: --querychunktotal
  - id: query_type
    type:
      - 'null'
      - string
    doc: Specify query alphabet type
    inputBinding:
      position: 101
      prefix: --querytype
  - id: refine
    type:
      - 'null'
      - string
    doc: Alignment refinement strategy [none|full|region]
    inputBinding:
      position: 101
      prefix: --refine
  - id: refine_boundary
    type:
      - 'null'
      - int
    doc: Refinement region boundary
    inputBinding:
      position: 101
      prefix: --refineboundary
  - id: revcomp
    type:
      - 'null'
      - boolean
    doc: Also search reverse complement of query and target
    inputBinding:
      position: 101
      prefix: --revcomp
  - id: ryo
    type:
      - 'null'
      - string
    doc: Roll-your-own printf-esque output format
    inputBinding:
      position: 101
      prefix: --ryo
  - id: saturate_threshold
    type:
      - 'null'
      - int
    doc: Word saturation threshold
    inputBinding:
      position: 101
      prefix: --saturatethreshold
  - id: score
    type:
      - 'null'
      - int
    doc: Score threshold for gapped alignment
    inputBinding:
      position: 101
      prefix: --score
  - id: show_alignment
    type:
      - 'null'
      - boolean
    doc: Include (human readable) alignment in results
    inputBinding:
      position: 101
      prefix: --showalignment
  - id: show_cigar
    type:
      - 'null'
      - boolean
    doc: Include 'cigar' format output in results
    inputBinding:
      position: 101
      prefix: --showcigar
  - id: show_query_gff
    type:
      - 'null'
      - boolean
    doc: Include GFF output on query in results
    inputBinding:
      position: 101
      prefix: --showquerygff
  - id: show_sugar
    type:
      - 'null'
      - boolean
    doc: Include 'sugar' format output in results
    inputBinding:
      position: 101
      prefix: --showsugar
  - id: show_target_gff
    type:
      - 'null'
      - boolean
    doc: Include GFF output on target in results
    inputBinding:
      position: 101
      prefix: --showtargetgff
  - id: show_vulgar
    type:
      - 'null'
      - boolean
    doc: Include 'vulgar' format output in results
    inputBinding:
      position: 101
      prefix: --showvulgar
  - id: single_pass
    type:
      - 'null'
      - boolean
    doc: Generate suboptimal alignment in a single pass
    inputBinding:
      position: 101
      prefix: --singlepass
  - id: softmask_query
    type:
      - 'null'
      - boolean
    doc: Allow softmasking on the query sequence
    inputBinding:
      position: 101
      prefix: --softmaskquery
  - id: softmask_target
    type:
      - 'null'
      - boolean
    doc: Allow softmasking on the target sequence
    inputBinding:
      position: 101
      prefix: --softmasktarget
  - id: subopt
    type:
      - 'null'
      - boolean
    doc: Search for suboptimal alignments
    inputBinding:
      position: 101
      prefix: --subopt
  - id: target
    type: File
    doc: Specify target sequences as a fasta format file
    inputBinding:
      position: 101
      prefix: --target
  - id: target_chunk_id
    type:
      - 'null'
      - int
    doc: Specify target job number
    inputBinding:
      position: 101
      prefix: --targetchunkid
  - id: target_chunk_total
    type:
      - 'null'
      - int
    doc: Specify total number of target jobs
    inputBinding:
      position: 101
      prefix: --targetchunktotal
  - id: target_type
    type:
      - 'null'
      - string
    doc: Specify target alphabet type
    inputBinding:
      position: 101
      prefix: --targettype
  - id: verbose
    type:
      - 'null'
      - int
    doc: Show search progress
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/exonerate:v2.4.0-4-deb_cv1
stdout: exonerate.out
