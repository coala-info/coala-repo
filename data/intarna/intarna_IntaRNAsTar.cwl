cwlVersion: v1.2
class: CommandLineTool
baseCommand: intarna_IntaRNAsTar
label: intarna_IntaRNAsTar
doc: "IntaRNA predicts RNA-RNA interactions.\n\nTool homepage: https://github.com/BackofenLab/IntaRNA"
inputs:
  - id: acc
    type:
      - 'null'
      - string
    doc: "accessibility computation : 'N' no accessibility contributions 'C' computation
      of accessibilities (see --accW and --accL)"
    default: C
    inputBinding:
      position: 101
      prefix: --acc
  - id: helix_full_e
    type:
      - 'null'
      - boolean
    doc: if given (or true), the overall energy of a helix (including E_init, 
      ED, dangling ends, ..) will be used for helixMaxE checks; otherwise only 
      loop-terms are considered.
    default: false
    inputBinding:
      position: 101
      prefix: --helixFullE
  - id: helix_max_bp
    type:
      - 'null'
      - int
    doc: maximal number of base pairs inside a helix (arg in range [2,20])
    default: 10
    inputBinding:
      position: 101
      prefix: --helixMaxBP
  - id: helix_max_e
    type:
      - 'null'
      - int
    doc: maximal energy (excluding) a helix may have (arg in range [-999,999]).
    default: 0
    inputBinding:
      position: 101
      prefix: --helixMaxE
  - id: helix_max_il
    type:
      - 'null'
      - int
    doc: maximal size for each internal loop size in a helix (arg in range 
      [0,2]).
    default: 0
    inputBinding:
      position: 101
      prefix: --helixMaxIL
  - id: helix_min_bp
    type:
      - 'null'
      - int
    doc: minimal number of base pairs inside a helix (arg in range [2,4])
    default: 2
    inputBinding:
      position: 101
      prefix: --helixMinBP
  - id: helix_min_pu
    type:
      - 'null'
      - float
    doc: minimal unpaired probability (per sequence) of considered helices (arg 
      in range [0,1]).
    default: 0.0
    inputBinding:
      position: 101
      prefix: --helixMinPu
  - id: int_len_max
    type:
      - 'null'
      - int
    doc: 'interaction site : maximal window size to be considered for interaction
      (arg in range [0,99999]; 0 refers to the full sequence length). If --accW is
      provided, the smaller window size of both is used.'
    default: 60
    inputBinding:
      position: 101
      prefix: --intLenMax
  - id: int_loop_max
    type:
      - 'null'
      - int
    doc: 'interaction site : maximal number of unpaired bases between neighbored interacting
      bases to be considered in interactions (arg in range [0,30]; 0 enforces stackings
      only)'
    default: 8
    inputBinding:
      position: 101
      prefix: --intLoopMax
  - id: mode
    type:
      - 'null'
      - string
    doc: "prediction mode : 'H' = heuristic (fast and low memory), 'M' = exact (slow),
      'S' = seed-only"
    default: H
    inputBinding:
      position: 101
      prefix: --mode
  - id: model
    type:
      - 'null'
      - string
    doc: "interaction model : 'S' = single-site, minimum-free-energy interaction (interior
      loops only), 'X' = single-site, minimum-free-energy interaction via seed-extension
      (interior loops only), 'B' = single-site, helix-block-based, minimum-free-energy
      interaction (blocks of stable helices and interior loops only), 'P' = single-site
      interaction with minimal free ensemble energy per site (interior loops only)"
    default: X
    inputBinding:
      position: 101
      prefix: --model
  - id: no_seed
    type:
      - 'null'
      - boolean
    doc: if given (or true), no seed is enforced within the predicted 
      interactions
    default: false
    inputBinding:
      position: 101
      prefix: --noSeed
  - id: out
    type:
      - 'null'
      - type: array
        items: string
    doc: "output (multi-arg) : provide a file name for output (will be overwritten)
      or 'STDOUT/STDERR' to write to the according stream (according to --outMode).
      Use one of the following PREFIXES (colon-separated) to generate ADDITIONAL output:
      'qMinE:' (query) for each position the minimal energy of any interaction covering
      the position (CSV format) 'qSpotProb:' (query) for each position the probability
      that is is covered by an interaction covering (CSV format) 'qAcc:' (query) ED
      accessibility values ('qPu'-like format). 'qPu:' (query) unpaired probabilities
      values (RNAplfold format). 'tMinE:' (target) for each position the minimal energy
      of any interaction covering the position (CSV format) 'tSpotProb:' (target)
      for each position the probability that is is covered by an interaction covering
      (CSV format) 'tAcc:' (target) ED accessibility values ('tPu'-like format). 'tPu:'
      (target) unpaired probabilities values (RNAplfold format). 'pMinE:' (target+query)
      for each index pair the minimal energy of any interaction covering the pair
      (CSV format) 'spotProb:' (target+query) tracks for a given set of interaction
      spots their probability to be covered by an interaction. If no spots are provided,
      probabilities for all index combinations are computed. Spots are encoded by
      comma-separated 'idxT&idxQ' pairs (target-query). For each spot a probability
      is provided in concert with the probability that none of the spots (encoded
      by '0&0') is covered (CSV format). The spot encoding is followed colon-separated
      by the output stream/file name, eg. '--out=\"spotProb:3&76,59&2:STDERR\"'. NOTE:
      value has to be quoted due to '&' symbol! For each, provide a file name or STDOUT/STDERR
      to write to the respective output stream."
    default: STDOUT
    inputBinding:
      position: 101
      prefix: --out
  - id: out_mode
    type:
      - 'null'
      - string
    doc: "output mode : 'N' normal output (ASCII char + energy), 'D' detailed output
      (ASCII char + energy/position details), 'C' CSV output (see --outCsvCols), 'E'
      ensemble information"
    default: C
    inputBinding:
      position: 101
      prefix: --outMode
  - id: out_number
    type:
      - 'null'
      - int
    doc: number of (sub)optimal interactions to report (arg in range [0,1000])
    default: 1
    inputBinding:
      position: 101
      prefix: --outNumber
  - id: out_overlap
    type:
      - 'null'
      - string
    doc: "suboptimal output : interactions can overlap 'N' in none of the sequences,
      'T' in the target only, 'Q' in the query only, 'B' in both sequences"
    default: Q
    inputBinding:
      position: 101
      prefix: --outOverlap
  - id: out_sep
    type:
      - 'null'
      - string
    doc: column separator to be used in tabular CSV output
    default: ;
    inputBinding:
      position: 101
      prefix: --outSep
  - id: parameter_file
    type:
      - 'null'
      - File
    doc: file from where to read additional command line arguments
    inputBinding:
      position: 101
      prefix: --parameterFile
  - id: personality
    type:
      - 'null'
      - string
    doc: IntaRNA personality to be used, which defines default values, available
      program arguments and tool behavior
    inputBinding:
      position: 101
      prefix: --personality
  - id: query
    type:
      - 'null'
      - string
    doc: either an RNA sequence or the stream/file name from where to read the 
      query sequences (should be the shorter sequences to increase efficiency); 
      use 'STDIN' to read from standard input stream; sequences have to use 
      IUPAC nucleotide encoding; output alias is [seq2]
    inputBinding:
      position: 101
      prefix: --query
  - id: seed_bp
    type:
      - 'null'
      - int
    doc: number of inter-molecular base pairs within the seed region (arg in 
      range [2,20])
    default: 7
    inputBinding:
      position: 101
      prefix: --seedBP
  - id: seed_tq
    type:
      - 'null'
      - string
    doc: comma separated list of explicit seed base pair encoding(s) in the 
      format startTbpsT&startQbpsQ, e.g. '3|||.|&7||.||', where 'startT/Q' are 
      the indices of the 5' seed ends in target/query sequence and 'bpsT/Q' the 
      respective dot-bar base pair encodings. This disables all other seed 
      constraints and seed identification.
    inputBinding:
      position: 101
      prefix: --seedTQ
  - id: target
    type:
      - 'null'
      - string
    doc: either an RNA sequence or the stream/file name from where to read the 
      target sequences (should be the longer sequences to increase efficiency); 
      use 'STDIN' to read from standard input stream; sequences have to use 
      IUPAC nucleotide encoding; output alias is [seq1]
    inputBinding:
      position: 101
      prefix: --target
  - id: threads
    type:
      - 'null'
      - int
    doc: maximal number of threads to be used for parallel computation of 
      query-target combinations. A value of 0 requests all available CPUs. Note,
      the number of threads multiplies the required memory used for computation!
      (arg in range [0,20])
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/intarna:3.4.1--pl5321h077b44d_3
stdout: intarna_IntaRNAsTar.out
