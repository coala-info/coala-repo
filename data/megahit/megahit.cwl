cwlVersion: v1.2
class: CommandLineTool
baseCommand: megahit
label: megahit
doc: "MEGAHIT v1.2.9\n\nTool homepage: https://github.com/voutcn/megahit"
inputs:
  - id: bubble_level
    type:
      - 'null'
      - int
    doc: intensity of bubble merging (0-2), 0 to disable
    inputBinding:
      position: 101
      prefix: --bubble-level
  - id: cleaning_rounds
    type:
      - 'null'
      - int
    doc: number of rounds for graph cleanning
    inputBinding:
      position: 101
      prefix: --cleaning-rounds
  - id: continue_run
    type:
      - 'null'
      - boolean
    doc: "continue a MEGAHIT run from its last available check point.\n          \
      \                                  please set the output directory correctly
      when using this option."
    inputBinding:
      position: 101
      prefix: --continue
  - id: disconnect_ratio
    type:
      - 'null'
      - float
    doc: "disconnect unitigs if its depth is less than this ratio times \n       \
      \                                     the total depth of itself and its siblings"
    inputBinding:
      position: 101
      prefix: --disconnect-ratio
  - id: k_list
    type:
      - 'null'
      - string
    doc: "comma-separated list of kmer size\n                                    \
      \        all must be odd, in the range 15-255, increment <= 28)"
    inputBinding:
      position: 101
      prefix: --k-list
  - id: k_max
    type:
      - 'null'
      - int
    doc: maximum kmer size (<= 255), must be odd number
    inputBinding:
      position: 101
      prefix: --k-max
  - id: k_min
    type:
      - 'null'
      - int
    doc: minimum kmer size (<= 255), must be odd number
    inputBinding:
      position: 101
      prefix: --k-min
  - id: k_step
    type:
      - 'null'
      - int
    doc: increment of kmer size of each iteration (<= 28), must be even number
    inputBinding:
      position: 101
      prefix: --k-step
  - id: keep_tmp_files
    type:
      - 'null'
      - boolean
    doc: keep all temporary files
    inputBinding:
      position: 101
      prefix: --keep-tmp-files
  - id: kmin_1pass
    type:
      - 'null'
      - boolean
    doc: use 1pass mode to build SdBG of k_min
    inputBinding:
      position: 101
      prefix: --kmin-1pass
  - id: low_local_ratio
    type:
      - 'null'
      - float
    doc: "remove unitigs if its depth is less than this ratio times\n            \
      \                                the average depth of the neighborhoods"
    inputBinding:
      position: 101
      prefix: --low-local-ratio
  - id: max_tip_len
    type:
      - 'null'
      - string
    doc: remove tips less than this value
    inputBinding:
      position: 101
      prefix: --max-tip-len
  - id: mem_flag
    type:
      - 'null'
      - int
    doc: "SdBG builder memory mode. 0: minimum; 1: moderate;\n                   \
      \                         others: use all memory specified by '-m/--memory'"
    inputBinding:
      position: 101
      prefix: --mem-flag
  - id: memory
    type:
      - 'null'
      - float
    doc: "max memory in byte to be used in SdBG construction\n                   \
      \                         (if set between 0-1, fraction of the machine's total
      memory)"
    inputBinding:
      position: 101
      prefix: --memory
  - id: merge_level
    type:
      - 'null'
      - string
    doc: merge complex bubbles of length <= l*kmer_size and similarity >= s
    inputBinding:
      position: 101
      prefix: --merge-level
  - id: min_contig_len
    type:
      - 'null'
      - int
    doc: minimum length of contigs to output
    inputBinding:
      position: 101
      prefix: --min-contig-len
  - id: min_count
    type:
      - 'null'
      - int
    doc: minimum multiplicity for filtering (k_min+1)-mers
    inputBinding:
      position: 101
      prefix: --min-count
  - id: no_hw_accel
    type:
      - 'null'
      - boolean
    doc: run MEGAHIT without BMI2 and POPCNT hardware instructions
    inputBinding:
      position: 101
      prefix: --no-hw-accel
  - id: no_local
    type:
      - 'null'
      - boolean
    doc: disable local assembly
    inputBinding:
      position: 101
      prefix: --no-local
  - id: no_mercy
    type:
      - 'null'
      - boolean
    doc: do not add mercy kmers
    inputBinding:
      position: 101
      prefix: --no-mercy
  - id: num_cpu_threads
    type:
      - 'null'
      - int
    doc: number of CPU threads [# of logical processors]
    inputBinding:
      position: 101
      prefix: --num-cpu-threads
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: output directory
    inputBinding:
      position: 101
      prefix: --out-dir
  - id: out_prefix
    type:
      - 'null'
      - string
    doc: output prefix (the contig file will be OUT_DIR/OUT_PREFIX.contigs.fa)
    inputBinding:
      position: 101
      prefix: --out-prefix
  - id: pe1
    type:
      - 'null'
      - string
    doc: 'comma-separated list of fasta/q paired-end #1 files, paired with files in
      <pe2>'
    inputBinding:
      position: 101
      prefix: '-1'
  - id: pe12
    type:
      - 'null'
      - string
    doc: comma-separated list of interleaved fasta/q paired-end files
    inputBinding:
      position: 101
      prefix: --12
  - id: pe2
    type:
      - 'null'
      - string
    doc: 'comma-separated list of fasta/q paired-end #2 files, paired with files in
      <pe1>'
    inputBinding:
      position: 101
      prefix: '-2'
  - id: presets
    type:
      - 'null'
      - string
    doc: "override a group of parameters; possible values:\n                     \
      \                       meta-sensitive: '--min-count 1 --k-list 21,29,39,49,...,129,141'\n\
      \                                            meta-large: '--k-min 27 --k-max
      127 --k-step 10'\n                                            (large & complex
      metagenomes, like soil)"
    inputBinding:
      position: 101
      prefix: --presets
  - id: prune_depth
    type:
      - 'null'
      - int
    doc: remove unitigs with avg kmer depth less than this value
    inputBinding:
      position: 101
      prefix: --prune-depth
  - id: prune_level
    type:
      - 'null'
      - int
    doc: strength of low depth pruning (0-3)
    inputBinding:
      position: 101
      prefix: --prune-level
  - id: se
    type:
      - 'null'
      - string
    doc: comma-separated list of fasta/q single-end files
    inputBinding:
      position: 101
      prefix: --read
  - id: test
    type:
      - 'null'
      - boolean
    doc: run MEGAHIT on a toy test dataset
    inputBinding:
      position: 101
      prefix: --test
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: set temp directory
    inputBinding:
      position: 101
      prefix: --tmp-dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/megahit:1.2.9--haf24da9_8
stdout: megahit.out
