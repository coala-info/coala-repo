cwlVersion: v1.2
class: CommandLineTool
baseCommand: ultra
label: ultra
doc: "Locates Tandemly Repetitive Areas\n\nTool homepage: https://github.com/TravisWheelerLab/ULTRA"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: DNA FASTA input file
    inputBinding:
      position: 1
  - id: acgt_freq
    type:
      - 'null'
      - type: array
        items: float
    doc: Expected frequency of A C G T
    inputBinding:
      position: 102
      prefix: --acgt
  - id: at_content
    type:
      - 'null'
      - float
    doc: Expected AT content
    default: 0.5
    inputBinding:
      position: 102
      prefix: --at
  - id: bed
    type:
      - 'null'
      - boolean
    doc: Use BED output format
    inputBinding:
      position: 102
      prefix: --bed
  - id: dd
    type:
      - 'null'
      - float
    doc: Probability of consecutive deletions occurring
    default: 0.02
    inputBinding:
      position: 102
      prefix: --dd
  - id: decay
    type:
      - 'null'
      - float
    doc: Decay penalty applied to repetitive states
    default: 0.85
    inputBinding:
      position: 102
      prefix: --decay
  - id: deletes
    type:
      - 'null'
      - int
    doc: Maximum number of deletion states
    default: 10
    inputBinding:
      position: 102
      prefix: --deletes
  - id: disable_streaming_out
    type:
      - 'null'
      - boolean
    doc: Disables streaming output; no output will be created until all analysis
      has been completed
    inputBinding:
      position: 102
      prefix: --disable_streaming_out
  - id: disable_summary
    type:
      - 'null'
      - boolean
    doc: Disable summary statistics
    inputBinding:
      position: 102
      prefix: --disable_summary
  - id: fdr
    type:
      - 'null'
      - boolean
    doc: Estimate the False Discovery rate (runtime will be twice as long)
    inputBinding:
      position: 102
      prefix: --fdr
  - id: hide_settings
    type:
      - 'null'
      - boolean
    doc: Do not output settings
    inputBinding:
      position: 102
      prefix: --hide_settings
  - id: ii
    type:
      - 'null'
      - float
    doc: Probability of consecutive insertions occurring
    default: 0.02
    inputBinding:
      position: 102
      prefix: --ii
  - id: inserts
    type:
      - 'null'
      - int
    doc: Maximum number of insertion states
    default: 10
    inputBinding:
      position: 102
      prefix: --inserts
  - id: json
    type:
      - 'null'
      - boolean
    doc: Use JSON output format
    inputBinding:
      position: 102
      prefix: --json
  - id: match
    type:
      - 'null'
      - float
    doc: Expected conservation in repeats
    default: 0.7
    inputBinding:
      position: 102
      prefix: --match
  - id: max_consensus
    type:
      - 'null'
      - int
    doc: The maximum length of consensus pattern to include in output
    default: 1000000
    inputBinding:
      position: 102
      prefix: --max_consensus
  - id: max_split
    type:
      - 'null'
      - int
    doc: The maximum repeat period to perform repeat splitting
    default: 10
    inputBinding:
      position: 102
      prefix: --max_split
  - id: mem
    type:
      - 'null'
      - boolean
    doc: Display memory requirements for current settings and exit
    inputBinding:
      position: 102
      prefix: --mem
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum reportable repeat length
    default: 10
    inputBinding:
      position: 102
      prefix: --min_length
  - id: min_split_window
    type:
      - 'null'
      - int
    doc: Minimum repeat split window size
    default: 15
    inputBinding:
      position: 102
      prefix: --min_split_window
  - id: min_unit
    type:
      - 'null'
      - int
    doc: Minimum reportable number of repeat units
    default: 2
    inputBinding:
      position: 102
      prefix: --min_unit
  - id: nmask
    type:
      - 'null'
      - boolean
    doc: Use n masking instead of case masking
    inputBinding:
      position: 102
      prefix: --nmask
  - id: no_split
    type:
      - 'null'
      - boolean
    doc: Do not perform repeat splitting
    inputBinding:
      position: 102
      prefix: --no_split
  - id: nr
    type:
      - 'null'
      - float
    doc: Probability of a repeat starting
    default: 0.01
    inputBinding:
      position: 102
      prefix: --nr
  - id: overlap
    type:
      - 'null'
      - int
    doc: Manually set sequence window overlap size
    inputBinding:
      position: 102
      prefix: --overlap
  - id: period
    type:
      - 'null'
      - int
    doc: Maximum detectable repeat period
    default: 100
    inputBinding:
      position: 102
      prefix: --period
  - id: pval
    type:
      - 'null'
      - boolean
    doc: Use p-values instead of scores in BED output
    inputBinding:
      position: 102
      prefix: --pval
  - id: pval_loc
    type:
      - 'null'
      - string
    doc: The exponential location used for converting scores to p-values.
    inputBinding:
      position: 102
      prefix: --pval_loc
  - id: pval_scale
    type:
      - 'null'
      - string
    doc: The exponential scale used for converting scores to p-values
    inputBinding:
      position: 102
      prefix: --pval_scale
  - id: rd
    type:
      - 'null'
      - float
    doc: Probability of a deletion occurring
    default: 0.02
    inputBinding:
      position: 102
      prefix: --rd
  - id: read_all
    type:
      - 'null'
      - boolean
    doc: Read entire input file into memory (disables streaming input)
    inputBinding:
      position: 102
      prefix: --read_all
  - id: ri
    type:
      - 'null'
      - float
    doc: Probability of an insertion occurring
    default: 0.02
    inputBinding:
      position: 102
      prefix: --ri
  - id: rn
    type:
      - 'null'
      - float
    doc: Probability of a repeat stopping
    default: 0.05
    inputBinding:
      position: 102
      prefix: --rn
  - id: score
    type:
      - 'null'
      - float
    doc: Minimum reportable repeat score
    default: -100.0
    inputBinding:
      position: 102
      prefix: --score
  - id: show_counts
    type:
      - 'null'
      - boolean
    doc: 'Output #copies, #substitutions, #insertions, #deletions'
    inputBinding:
      position: 102
      prefix: --show_counts
  - id: show_delta
    type:
      - 'null'
      - boolean
    doc: Show positional score deltas in JSON output
    inputBinding:
      position: 102
      prefix: --show_delta
  - id: show_logo
    type:
      - 'null'
      - boolean
    doc: Show logo numbers in JSON output
    inputBinding:
      position: 102
      prefix: --show_logo
  - id: show_seq
    type:
      - 'null'
      - boolean
    doc: Output repetitive region
    inputBinding:
      position: 102
      prefix: --show_seq
  - id: show_trace
    type:
      - 'null'
      - boolean
    doc: Show Viterbi trace in JSON output
    inputBinding:
      position: 102
      prefix: --show_trace
  - id: show_wid
    type:
      - 'null'
      - boolean
    doc: Show sequence window IDs in JSON output
    inputBinding:
      position: 102
      prefix: --show_wid
  - id: split_depth
    type:
      - 'null'
      - int
    doc: Number of repeat units to use in repeat splitting
    default: 5
    inputBinding:
      position: 102
      prefix: --split_depth
  - id: split_threshold
    type:
      - 'null'
      - float
    doc: Split threshold value
    default: 3.5
    inputBinding:
      position: 102
      prefix: --split_threshold
  - id: suppress
    type:
      - 'null'
      - boolean
    doc: Do not output BED or JSON annotation
    inputBinding:
      position: 102
      prefix: --suppress
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: tsv
    type:
      - 'null'
      - boolean
    doc: Use TSV output format
    inputBinding:
      position: 102
      prefix: --tsv
  - id: tune
    type:
      - 'null'
      - boolean
    doc: Tune parameters using a small search grid before running (see README)
    inputBinding:
      position: 102
      prefix: --tune
  - id: tune_fdr
    type:
      - 'null'
      - float
    doc: FDR to be tuned against (see README)
    default: 0.05
    inputBinding:
      position: 102
      prefix: --tune_fdr
  - id: tune_file
    type:
      - 'null'
      - string
    doc: Use custom parameter search during tuning (see README)
    inputBinding:
      position: 102
      prefix: --tune_file
  - id: tune_indel
    type:
      - 'null'
      - boolean
    doc: Enable indels while tuning
    inputBinding:
      position: 102
      prefix: --tune_indel
  - id: tune_large
    type:
      - 'null'
      - boolean
    doc: Tune parameters using a larger search grid before running (see README)
    inputBinding:
      position: 102
      prefix: --tune_large
  - id: tune_medium
    type:
      - 'null'
      - boolean
    doc: Tune parameters before running (see README)
    inputBinding:
      position: 102
      prefix: --tune_medium
  - id: tune_only
    type:
      - 'null'
      - boolean
    doc: Tune parameters and don't run (see README)
    inputBinding:
      position: 102
      prefix: --tune_only
  - id: win_size
    type:
      - 'null'
      - int
    doc: Manually set sequence window size
    inputBinding:
      position: 102
      prefix: --win_size
  - id: windows
    type:
      - 'null'
      - int
    doc: Number of sequence windows to store at once
    default: 1024
    inputBinding:
      position: 102
      prefix: --windows
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file path
    outputBinding:
      glob: $(inputs.output_file)
  - id: mask
    type:
      - 'null'
      - File
    doc: File path to save a masked FASTA
    outputBinding:
      glob: $(inputs.mask)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ultra:1.2.1--h9948957_0
