cwlVersion: v1.2
class: CommandLineTool
baseCommand: sga_preprocess
label: sga_preprocess
doc: "Prepare READS1, READS2, ... data files for assembly\n\nTool homepage: https://github.com/jts/sga"
inputs:
  - id: reads1
    type: File
    doc: First read file
    inputBinding:
      position: 1
  - id: reads2
    type:
      - 'null'
      - type: array
        items: File
    doc: Additional read files (pairs with reads1)
    inputBinding:
      position: 2
  - id: discard_quality
    type:
      - 'null'
      - boolean
    doc: do not output quality scores
    inputBinding:
      position: 103
      prefix: --discard-quality
  - id: dust
    type:
      - 'null'
      - boolean
    doc: Perform dust-style filtering of low complexity reads.
    inputBinding:
      position: 103
      prefix: --dust
  - id: dust_threshold
    type:
      - 'null'
      - float
    doc: 'filter out reads that have a dust score higher than FLOAT (default: 4.0).'
    inputBinding:
      position: 103
      prefix: --dust-threshold
  - id: hard_clip
    type:
      - 'null'
      - int
    doc: "clip all reads to be length INT. In most cases it is better to use\n   \
      \                                    the soft clip (quality-trim) option."
    inputBinding:
      position: 103
      prefix: --hard-clip
  - id: min_length
    type:
      - 'null'
      - int
    doc: "discard sequences that are shorter than INT\n                          \
      \             this is most useful when used in conjunction with --quality-trim.
      Default: 40"
    inputBinding:
      position: 103
      prefix: --min-length
  - id: no_primer_check
    type:
      - 'null'
      - boolean
    doc: disable the default check for primer sequences
    inputBinding:
      position: 103
      prefix: --no-primer-check
  - id: pe_mode
    type:
      - 'null'
      - int
    doc: "0 - do not treat reads as paired (default)\n                           \
      \            1 - reads are paired with the first read in READS1 and the second\n\
      \                                       read in READS2. The paired reads will
      be interleaved in the output file\n                                       2
      - reads are paired and the records are interleaved within a single file."
    inputBinding:
      position: 103
      prefix: --pe-mode
  - id: pe_orphans
    type:
      - 'null'
      - File
    doc: if one half of a read pair fails filtering, write the passed half to 
      FILE
    inputBinding:
      position: 103
      prefix: --pe-orphans
  - id: permute_ambiguous
    type:
      - 'null'
      - boolean
    doc: "Randomly change ambiguous base calls to one of possible bases.\n       \
      \                                If this option is not specified, the entire
      read will be discarded."
    inputBinding:
      position: 103
      prefix: --permute-ambiguous
  - id: phred64
    type:
      - 'null'
      - boolean
    doc: convert quality values from phred-64 to phred-33.
    inputBinding:
      position: 103
      prefix: --phred64
  - id: quality_filter
    type:
      - 'null'
      - int
    doc: "discard the read if it contains more than INT low-quality bases. \n    \
      \                                   Bases with phred score <= 3 are considered
      low quality. Default: no filtering.\n                                      \
      \ The filtering is applied after trimming so bases removed are not counted.\n\
      \                                       Do not use this option if you are planning
      to use the BCR algorithm for indexing."
    inputBinding:
      position: 103
      prefix: --quality-filter
  - id: quality_trim
    type:
      - 'null'
      - int
    doc: "perform Heng Li's BWA quality trim algorithm. \n                       \
      \                Reads are trimmed according to the formula:\n             \
      \                          argmax_x{\\sum_{i=x+1}^l(INT-q_i)} if q_l<INT\n \
      \                                      where l is the original read length."
    inputBinding:
      position: 103
      prefix: --quality-trim
  - id: remove_adapter_fwd
    type:
      - 'null'
      - string
    doc: Remove the adapter STRING from input reads.
    inputBinding:
      position: 103
      prefix: --remove-adapter-fwd
  - id: remove_adapter_rev
    type:
      - 'null'
      - string
    doc: Remove the adapter STRING from input reads.
    inputBinding:
      position: 103
      prefix: --remove-adapter-rev
  - id: sample
    type:
      - 'null'
      - float
    doc: Randomly sample reads or pairs with acceptance probability FLOAT.
    inputBinding:
      position: 103
      prefix: --sample
  - id: seed
    type:
      - 'null'
      - int
    doc: set random seed
    inputBinding:
      position: 103
      prefix: --seed
  - id: suffix
    type:
      - 'null'
      - string
    doc: append SUFFIX to each read ID
    inputBinding:
      position: 103
      prefix: --suffix
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: display verbose output
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: 'write the reads to FILE (default: stdout)'
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sga:v0.10.15-4-deb_cv1
