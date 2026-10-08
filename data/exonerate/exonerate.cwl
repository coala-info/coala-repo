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
      - string
    doc: Use compiled viterbi implementations (yes or no; default yes)
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
      - string
    doc: Use gapped extension (default is SDP) (yes or no; default yes)
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
      - string
    doc: Also search reverse complement of query and target (yes or no; default yes)
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
      - string
    doc: Include (human readable) alignment in results (yes or no; default yes)
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
      - string
    doc: Include 'vulgar' format output in results (yes or no; default yes)
    inputBinding:
      position: 101
      prefix: --showvulgar
  - id: single_pass
    type:
      - 'null'
      - string
    doc: Generate suboptimal alignment in a single pass (yes or no; default yes)
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
      - string
    doc: Search for suboptimal alignments (yes or no; default yes)
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
  - id: terminalrangeint
    type:
      - 'null'
      - int
    doc: Value for --terminalrangeint
    inputBinding:
      position: 101
      prefix: --terminalrangeint
  - id: terminalrangeext
    type:
      - 'null'
      - int
    doc: Value for --terminalrangeext
    inputBinding:
      position: 101
      prefix: --terminalrangeext
  - id: joinrangeint
    type:
      - 'null'
      - int
    doc: Value for --joinrangeint
    inputBinding:
      position: 101
      prefix: --joinrangeint
  - id: joinrangeext
    type:
      - 'null'
      - int
    doc: Value for --joinrangeext
    inputBinding:
      position: 101
      prefix: --joinrangeext
  - id: spanrangeint
    type:
      - 'null'
      - int
    doc: Value for --spanrangeint
    inputBinding:
      position: 101
      prefix: --spanrangeint
  - id: spanrangeext
    type:
      - 'null'
      - int
    doc: Value for --spanrangeext
    inputBinding:
      position: 101
      prefix: --spanrangeext
  - id: joinfilter
    type:
      - 'null'
      - int
    doc: Value for --joinfilter
    inputBinding:
      position: 101
      prefix: --joinfilter
  - id: wordjump
    type:
      - 'null'
      - int
    doc: Value for --wordjump
    inputBinding:
      position: 101
      prefix: --wordjump
  - id: wordambiguity
    type:
      - 'null'
      - int
    doc: Value for --wordambiguity
    inputBinding:
      position: 101
      prefix: --wordambiguity
  - id: codongapopen
    type:
      - 'null'
      - int
    doc: Value for --codongapopen
    inputBinding:
      position: 101
      prefix: --codongapopen
  - id: codongapextend
    type:
      - 'null'
      - int
    doc: Value for --codongapextend
    inputBinding:
      position: 101
      prefix: --codongapextend
  - id: minner
    type:
      - 'null'
      - int
    doc: Value for --minner
    inputBinding:
      position: 101
      prefix: --minner
  - id: maxner
    type:
      - 'null'
      - int
    doc: Value for --maxner
    inputBinding:
      position: 101
      prefix: --maxner
  - id: neropen
    type:
      - 'null'
      - int
    doc: Value for --neropen
    inputBinding:
      position: 101
      prefix: --neropen
  - id: minintron
    type:
      - 'null'
      - int
    doc: Value for --minintron
    inputBinding:
      position: 101
      prefix: --minintron
  - id: maxintron
    type:
      - 'null'
      - int
    doc: Value for --maxintron
    inputBinding:
      position: 101
      prefix: --maxintron
  - id: hspfilter
    type:
      - 'null'
      - int
    doc: Value for --hspfilter
    inputBinding:
      position: 101
      prefix: --hspfilter
  - id: seedrepeat
    type:
      - 'null'
      - int
    doc: Value for --seedrepeat
    inputBinding:
      position: 101
      prefix: --seedrepeat
  - id: dnawordlen
    type:
      - 'null'
      - int
    doc: Value for --dnawordlen
    inputBinding:
      position: 101
      prefix: --dnawordlen
  - id: proteinwordlen
    type:
      - 'null'
      - int
    doc: Value for --proteinwordlen
    inputBinding:
      position: 101
      prefix: --proteinwordlen
  - id: codonwordlen
    type:
      - 'null'
      - int
    doc: Value for --codonwordlen
    inputBinding:
      position: 101
      prefix: --codonwordlen
  - id: dnahspdropoff
    type:
      - 'null'
      - int
    doc: Value for --dnahspdropoff
    inputBinding:
      position: 101
      prefix: --dnahspdropoff
  - id: proteinhspdropoff
    type:
      - 'null'
      - int
    doc: Value for --proteinhspdropoff
    inputBinding:
      position: 101
      prefix: --proteinhspdropoff
  - id: codonhspdropoff
    type:
      - 'null'
      - int
    doc: Value for --codonhspdropoff
    inputBinding:
      position: 101
      prefix: --codonhspdropoff
  - id: dnahspthreshold
    type:
      - 'null'
      - int
    doc: Value for --dnahspthreshold
    inputBinding:
      position: 101
      prefix: --dnahspthreshold
  - id: proteinhspthreshold
    type:
      - 'null'
      - int
    doc: Value for --proteinhspthreshold
    inputBinding:
      position: 101
      prefix: --proteinhspthreshold
  - id: codonhspthreshold
    type:
      - 'null'
      - int
    doc: Value for --codonhspthreshold
    inputBinding:
      position: 101
      prefix: --codonhspthreshold
  - id: dnawordlimit
    type:
      - 'null'
      - int
    doc: Value for --dnawordlimit
    inputBinding:
      position: 101
      prefix: --dnawordlimit
  - id: proteinwordlimit
    type:
      - 'null'
      - int
    doc: Value for --proteinwordlimit
    inputBinding:
      position: 101
      prefix: --proteinwordlimit
  - id: codonwordlimit
    type:
      - 'null'
      - int
    doc: Value for --codonwordlimit
    inputBinding:
      position: 101
      prefix: --codonwordlimit
  - id: geneseed
    type:
      - 'null'
      - int
    doc: Value for --geneseed
    inputBinding:
      position: 101
      prefix: --geneseed
  - id: geneseedrepeat
    type:
      - 'null'
      - int
    doc: Value for --geneseedrepeat
    inputBinding:
      position: 101
      prefix: --geneseedrepeat
  - id: alignmentwidth
    type:
      - 'null'
      - int
    doc: Value for --alignmentwidth
    inputBinding:
      position: 101
      prefix: --alignmentwidth
  - id: quality
    type:
      - 'null'
      - int
    doc: Value for --quality
    inputBinding:
      position: 101
      prefix: --quality
  - id: forcefsm
    type:
      - 'null'
      - string
    doc: Force FSM word index on query or target (none, query, target)
    inputBinding:
      position: 101
      prefix: --forcefsm
  - id: useaatla
    type:
      - 'null'
      - string
    doc: Use three-letter amino acid codes in alignments (yes or no; default yes)
    inputBinding:
      position: 101
      prefix: --useaatla
  - id: useworddropoff
    type:
      - 'null'
      - string
    doc: Use word neighbourhood dropoff (yes or no; default yes)
    inputBinding:
      position: 101
      prefix: --useworddropoff
  - id: forwardcoordinates
    type:
      - 'null'
      - string
    doc: Report coordinates on the forward strand (yes or no; default yes)
    inputBinding:
      position: 101
      prefix: --forwardcoordinates
  - id: splice3
    type:
      - 'null'
      - string
    doc: Splice site model for the 3 prime site (default primate)
    inputBinding:
      position: 101
      prefix: --splice3
  - id: splice5
    type:
      - 'null'
      - string
    doc: Splice site model for the 5 prime site (default primate)
    inputBinding:
      position: 101
      prefix: --splice5
  - id: forcegtag
    type:
      - 'null'
      - boolean
    doc: Force GT/AG splice sites at intron boundaries
    inputBinding:
      position: 101
      prefix: --forcegtag
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/exonerate:v2.4.0-4-deb_cv1
stdout: exonerate.out
