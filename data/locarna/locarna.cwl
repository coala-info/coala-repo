cwlVersion: v1.2
class: CommandLineTool
baseCommand: locarna
label: locarna
doc: "pairwise (global and local) alignment of RNA.\n\nTool homepage: https://s-will.github.io/LocARNA"
inputs:
  - id: input_1
    type: File
    doc: First input sequence or alignment file.
    inputBinding:
      position: 1
  - id: input_2
    type: File
    doc: Second input sequence or alignment file.
    inputBinding:
      position: 2
  - id: alifold_consensus_dp
    type:
      - 'null'
      - boolean
    doc: 'Compute consensus dot plot by alifold (warning: this may fail for long sequences).'
    inputBinding:
      position: 103
      prefix: --alifold-consensus-dp
  - id: alignment_width
    type:
      - 'null'
      - int
    doc: Width of alignment output.
    default: 120
    inputBinding:
      position: 103
      prefix: --width
  - id: better_threshold
    type:
      - 'null'
      - int
    doc: Enumerate alignments better threshold t
    default: -1000000
    inputBinding:
      position: 103
      prefix: --better
  - id: consensus_gamma
    type:
      - 'null'
      - float
    doc: Base pair weight for mea consensus computation. For MEA, base pairs are
      scored by their pair probability times 2 gamma; unpaired bases, by their 
      unpaired probability.
    default: 1.0
    inputBinding:
      position: 103
      prefix: --consensus-gamma
  - id: consensus_structure
    type:
      - 'null'
      - string
    doc: 'Type of consensus structures written to screen and stockholm output [alifold|mea|none]
      (default: none).'
    default: none
    inputBinding:
      position: 103
      prefix: --consensus-structure
  - id: exclusion_score
    type:
      - 'null'
      - int
    doc: Score contribution per exclusion in structure local alignment. Set to 
      zero for unrestricted structure locality.
    default: 0
    inputBinding:
      position: 103
      prefix: --exclusion
  - id: exp_prob
    type:
      - 'null'
      - float
    doc: 'Expected base pair probability. Used as background probability for base
      pair scoring [default: calculated from sequence length].'
    inputBinding:
      position: 103
      prefix: --exp-prob
  - id: extended_pf
    type:
      - 'null'
      - boolean
    doc: Use extended precision for the computation of sequence envelopes. This 
      enables handling significantly larger instances. [default]
    default: true
    inputBinding:
      position: 103
      prefix: --extended-pf
  - id: free_endgaps
    type:
      - 'null'
      - string
    doc: Control where end gaps are allowed for free. String of four +/- 
      symbols, allowing/disallowing free end gaps at the four sequence ends in 
      the order left end of first sequence, right end of first sequence, left 
      end of second sequence, right end of second sequence. For example, "+---" 
      allows free end gaps at the left end of the first alignment string; "----"
      forbids free end gaps [default].
    default: '----'
    inputBinding:
      position: 103
      prefix: --free-endgaps
  - id: galaxy_xml
    type:
      - 'null'
      - boolean
    doc: Print galaxy xml wrapper.
    inputBinding:
      position: 103
      prefix: --galaxy-xml
  - id: indel_opening_score
    type:
      - 'null'
      - int
    doc: Indel opening score. Score contribution of opening an insertion or 
      deletion, i.e. score for a consecutive run of deletions or insertions. 
      Indel opening score and indel score define the affine scoring of gaps.
    default: -750
    inputBinding:
      position: 103
      prefix: --indel-opening
  - id: indel_score
    type:
      - 'null'
      - int
    doc: Indel score. Score contribution of each single base insertion or 
      deletion. Indel opening score and indel score define the affine scoring of
      gaps.
    default: -150
    inputBinding:
      position: 103
      prefix: --indel
  - id: kbest
    type:
      - 'null'
      - int
    doc: Enumerate k-best alignments
    default: -1
    inputBinding:
      position: 103
      prefix: --kbest
  - id: local_file_output
    type:
      - 'null'
      - boolean
    doc: Write only local sub-alignment to output files.
    inputBinding:
      position: 103
      prefix: --local-file-output
  - id: local_output
    type:
      - 'null'
      - boolean
    doc: Output only local sub-alignment (to std out).
    inputBinding:
      position: 103
      prefix: --local-output
  - id: match_prob_method
    type:
      - 'null'
      - int
    doc: 'Select method for computing sequence-based base match probablities (to be
      used for mea-type alignment scores). Methods: 1=probcons-style from HMM, 2=probalign-style
      from PFs, 3=from PFs, local'
    default: 0
    inputBinding:
      position: 103
      prefix: --match-prob-method
  - id: match_score
    type:
      - 'null'
      - int
    doc: Set score contribution of a base match (unless ribosum scoring).
    default: 50
    inputBinding:
      position: 103
      prefix: --match
  - id: maxBPspan
    type:
      - 'null'
      - int
    doc: Limit maximum base pair span [default=off].
    default: -1
    inputBinding:
      position: 103
      prefix: --maxBPspan
  - id: max_bps_length_ratio
    type:
      - 'null'
      - float
    doc: 'Maximal ratio of #base pairs divided by sequence length. This serves as
      a second filter on the "significant" base pairs. [default: 0.0 = no effect].'
    default: 0.0
    inputBinding:
      position: 103
      prefix: --max-bps-length-ratio
  - id: max_diff
    type:
      - 'null'
      - int
    doc: Maximal difference for positions of alignment traces (and aligned 
      bases). [-1=off]
    default: -1
    inputBinding:
      position: 103
      prefix: --max-diff
  - id: max_diff_aln_file
    type:
      - 'null'
      - File
    doc: Maximal difference relative to given alignment (file in clustalw 
      format)
    inputBinding:
      position: 103
      prefix: --max-diff-aln
  - id: max_diff_am
    type:
      - 'null'
      - int
    doc: Maximal difference for sizes of matched arcs. [-1=off]
    default: -1
    inputBinding:
      position: 103
      prefix: --max-diff-am
  - id: max_diff_at_am
    type:
      - 'null'
      - int
    doc: Maximal difference for positions of alignment traces at arc match ends.
      [-1=off]
    default: -1
    inputBinding:
      position: 103
      prefix: --max-diff-at-am
  - id: max_diff_pw_aln
    type:
      - 'null'
      - string
    doc: Maximal difference relative to given alignment (string, 
      delim=AMPERSAND)
    inputBinding:
      position: 103
      prefix: --max-diff-pw-aln
  - id: max_diff_relax
    type:
      - 'null'
      - boolean
    doc: Relax deviation constraints in multiple aligmnent
    inputBinding:
      position: 103
      prefix: --max-diff-relax
  - id: mea_alignment
    type:
      - 'null'
      - boolean
    doc: Perform maximum expected accuracy alignment (instead of using the 
      default similarity scoring).
    inputBinding:
      position: 103
      prefix: --mea-alignment
  - id: mea_alpha
    type:
      - 'null'
      - int
    doc: Weight alpha for MEA
    default: 0
    inputBinding:
      position: 103
      prefix: --mea-alpha
  - id: mea_beta
    type:
      - 'null'
      - int
    doc: Weight beta for MEA
    default: 200
    inputBinding:
      position: 103
      prefix: --mea-beta
  - id: mea_gamma
    type:
      - 'null'
      - int
    doc: Weight gamma for MEA
    default: 100
    inputBinding:
      position: 103
      prefix: --mea-gamma
  - id: mea_gapcost
    type:
      - 'null'
      - boolean
    doc: Use gap cost in mea alignment
    inputBinding:
      position: 103
      prefix: --mea-gapcost
  - id: min_prob
    type:
      - 'null'
      - float
    doc: Minimal probability. Only base pairs of at least this probability are 
      taken into account.
    default: 0.001
    inputBinding:
      position: 103
      prefix: --min-prob
  - id: min_trace_probability
    type:
      - 'null'
      - float
    doc: Minimal sequence alignment probability of potential traces 
      (probability-based sequence alignment envelope) [default=1e-4].
    default: 0.0001
    inputBinding:
      position: 103
      prefix: --min-trace-probability
  - id: mismatch_score
    type:
      - 'null'
      - int
    doc: Set score contribution of a base mismatch (unless ribosum scoring).
    default: 0
    inputBinding:
      position: 103
      prefix: --mismatch
  - id: new_stacking
    type:
      - 'null'
      - boolean
    doc: Use new stacking terms (requires stack-probs by RNAfold -p2)
    inputBinding:
      position: 103
      prefix: --new-stacking
  - id: noLP
    type:
      - 'null'
      - boolean
    doc: Disallow lonely pairs in prediction and alignment.
    inputBinding:
      position: 103
      prefix: --noLP
  - id: normalized_local_alignment
    type:
      - 'null'
      - int
    doc: Perform normalized local alignment with parameter L. This causes 
      locarna to compute the best local alignment according to 'Score' / ( L + 
      'length' ), where length is the sum of the lengths of the two locally 
      aligned subsequences. Thus, the larger L, the larger the local alignment; 
      the size of value L is in the order of local alignment lengths. Verbose 
      yields info on the iterative optimizations.
    default: 0
    inputBinding:
      position: 103
      prefix: --normalized
  - id: penalized_local_alignment
    type:
      - 'null'
      - int
    doc: Penalized local alignment with penalty PP
    default: 0
    inputBinding:
      position: 103
      prefix: --penalized
  - id: pf_struct_weight
    type:
      - 'null'
      - int
    doc: Structure weight in PF computations (for the computation of 
      sequence-based match probabilties from partition functions).
    default: 200
    inputBinding:
      position: 103
      prefix: --pf-struct-weight
  - id: pos_output
    type:
      - 'null'
      - boolean
    doc: Output only local sub-alignment positions.
    inputBinding:
      position: 103
      prefix: --pos-output
  - id: probability_scale
    type:
      - 'null'
      - int
    doc: Scale for probabilities/resolution of mea score
    default: 10000
    inputBinding:
      position: 103
      prefix: --probability-scale
  - id: probcons_file
    type:
      - 'null'
      - File
    doc: Read parameters for probcons-like calculation of match probabilities 
      from probcons parameter file.
    inputBinding:
      position: 103
      prefix: --probcons-file
  - id: quad_pf
    type:
      - 'null'
      - boolean
    doc: Use quad precision for partition function values. Even more precision 
      than extended pf, but usually much slower (overrides extended-pf).
    inputBinding:
      position: 103
      prefix: --quad-pf
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Be quiet.
    inputBinding:
      position: 103
      prefix: --quiet
  - id: read_arcmatch_probs_file
    type:
      - 'null'
      - File
    doc: Read arcmatch probabilities (weighted by factor mea_beta/100)
    inputBinding:
      position: 103
      prefix: --read-arcmatch-probs
  - id: read_arcmatch_scores_file
    type:
      - 'null'
      - File
    doc: Read arcmatch scores.
    inputBinding:
      position: 103
      prefix: --read-arcmatch-scores
  - id: read_match_probs_file
    type:
      - 'null'
      - File
    doc: Read match probabilities from file.
    inputBinding:
      position: 103
      prefix: --read-match-probs
  - id: relaxed_anchors
    type:
      - 'null'
      - boolean
    doc: Use relaxed semantics of anchor constraints [default=strict semantics].
    inputBinding:
      position: 103
      prefix: --relaxed-anchors
  - id: ribosum_file
    type:
      - 'null'
      - File
    doc: 'File specifying the Ribosum base and base-pair similarities. [default: use
      RIBOSUM85_60 without requiring a Ribosum file.]'
    default: RIBOSUM85_60
    inputBinding:
      position: 103
      prefix: --ribosum-file
  - id: score_components
    type:
      - 'null'
      - boolean
    doc: Output components of the score (experimental).
    inputBinding:
      position: 103
      prefix: --score-components
  - id: sequ_local
    type:
      - 'null'
      - boolean
    doc: Turn on/off sequence locality. Find best alignment of arbitrary 
      subsequences of the input sequences.
    default: false
    inputBinding:
      position: 103
      prefix: --sequ-local
  - id: stacking
    type:
      - 'null'
      - boolean
    doc: Use stacking terms (requires stack-probs by RNAfold -p2)
    inputBinding:
      position: 103
      prefix: --stacking
  - id: stopwatch
    type:
      - 'null'
      - boolean
    doc: Print run time informations.
    inputBinding:
      position: 103
      prefix: --stopwatch
  - id: struct_local
    type:
      - 'null'
      - boolean
    doc: Turn on/off structure locality. Allow exclusions in alignments of 
      connected substructures.
    default: false
    inputBinding:
      position: 103
      prefix: --struct-local
  - id: struct_weight
    type:
      - 'null'
      - int
    doc: Maximal weight of 1/2 arc match. Balances structure vs. sequence score 
      contributions.
    default: 200
    inputBinding:
      position: 103
      prefix: --struct-weight
  - id: tau
    type:
      - 'null'
      - int
    doc: Tau factor. Factor for contribution of sequence similarity in an arc 
      match (in percent). tau=0 does not penalize any sequence information 
      including compensatory mutations at arc matches, while tau=100 scores 
      sequence similarity at ends of base matches (if a scoring matrix like 
      ribosum is used, this adds the contributions for base pair match from the 
      matrix). [default tau=0!]
    default: 50
    inputBinding:
      position: 103
      prefix: --tau
  - id: temperature_alipf
    type:
      - 'null'
      - int
    doc: Temperature for the /sequence alignment/ partition functions used by 
      the probcons-like sequence-based match/trace probability computation (this
      temperature is different from the 'physical' temperature of RNA folding!).
    default: 300
    inputBinding:
      position: 103
      prefix: --temperature-alipf
  - id: unpaired_penalty
    type:
      - 'null'
      - int
    doc: Penalty for unpaired bases
    default: 0
    inputBinding:
      position: 103
      prefix: --unpaired-penalty
  - id: use_ribosum
    type:
      - 'null'
      - boolean
    doc: Use ribosum scores for scoring base matches and base pair matches; note
      that tau=0 suppresses any effect on the latter.
    default: true
    inputBinding:
      position: 103
      prefix: --use-ribosum
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Be verbose. Prints input parameters, sequences and size information.
    inputBinding:
      position: 103
      prefix: --verbose
  - id: write_structure
    type:
      - 'null'
      - boolean
    doc: Write guidance structure in output.
    inputBinding:
      position: 103
      prefix: --write-structure
outputs:
  - id: clustal_output_file
    type:
      - 'null'
      - File
    doc: Write alignment in ClustalW (aln) format to given file.
    outputBinding:
      glob: $(inputs.clustal_output_file)
  - id: stockholm_output_file
    type:
      - 'null'
      - File
    doc: Write alignment Stockholm format to given file.
    outputBinding:
      glob: $(inputs.stockholm_output_file)
  - id: pp_output_file
    type:
      - 'null'
      - File
    doc: Write alignment in PP format to given file.
    outputBinding:
      glob: $(inputs.pp_output_file)
  - id: write_match_probs_file
    type:
      - 'null'
      - File
    doc: Write match probs to file (don't align!).
    outputBinding:
      glob: $(inputs.write_match_probs_file)
  - id: write_trace_probs_file
    type:
      - 'null'
      - File
    doc: Write trace probs to file (don't align!).
    outputBinding:
      glob: $(inputs.write_trace_probs_file)
  - id: write_arcmatch_scores_file
    type:
      - 'null'
      - File
    doc: Write arcmatch scores (don't align!)
    outputBinding:
      glob: $(inputs.write_arcmatch_scores_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/locarna:2.0.1--pl5321h4ac6f70_0
