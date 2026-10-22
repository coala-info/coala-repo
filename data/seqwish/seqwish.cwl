cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqwish
label: seqwish
doc: 'seqwish: a variation graph inducer


  Tool homepage: https://github.com/ekg/seqwish'
inputs:
  - id: paf_alns
    type: File
    doc: 'Induce the graph from these PAF formatted alignments (gzip supported). Optionally a list of filenames and minimum match lengths: [file_1][:min_match_length_1],...'
    inputBinding:
      position: 1
      prefix: --paf-alns
  - id: seqs
    type: File
    doc: The sequences used to generate the alignments (FASTA, FASTQ, .seq).
    inputBinding:
      position: 2
      prefix: --seqs
  - id: gfa_path
    type: string
    doc: Write the graph in GFA to FILE.
    inputBinding:
      position: 3
      prefix: --gfa
  - id: temp_dir
    type:
      - 'null'
      - string
    doc: 'Directory for temporary files. It must exist. Default: working directory.'
    inputBinding:
      position: 4
      prefix: --temp-dir
  - id: match_list
    type:
      - 'null'
      - File
    doc: Use the sequence match list in FILE to subset the input alignments.
    inputBinding:
      position: 5
      prefix: --match-list
  - id: threads
    type:
      - 'null'
      - int
    doc: Use this many threads during parallel steps.
    inputBinding:
      position: 6
      prefix: --threads
  - id: repeat_max
    type:
      - 'null'
      - int
    doc: Limit transitive closure to include no more than N copies of a given input base.
    inputBinding:
      position: 7
      prefix: --repeat-max
  - id: min_repeat_distance
    type:
      - 'null'
      - int
    doc: Prevent transitive closure for bases at least this far apart in input sequences.
    inputBinding:
      position: 8
      prefix: --min-repeat-distance
  - id: min_match_len
    type:
      - 'null'
      - int
    doc: Filter exact matches below this length.
    inputBinding:
      position: 9
      prefix: --min-match-len
  - id: sparse_factor
    type:
      - 'null'
      - float
    doc: Sparsify input matches, keeping the fraction that minimize a hash function.
    inputBinding:
      position: 10
      prefix: --sparse-factor
  - id: transclose_batch
    type:
      - 'null'
      - string
    doc: Number of bp to use for transitive closure batch (1k = 1000, 1m = 10^6, 1g = 10^9). Default 1M.
    inputBinding:
      position: 11
      prefix: --transclose-batch
  - id: keep_temp
    type:
      - 'null'
      - boolean
    doc: Keep intermediate files generated during graph induction.
    inputBinding:
      position: 12
      prefix: --keep-temp
  - id: show_progress
    type:
      - 'null'
      - boolean
    doc: Log algorithm progress.
    inputBinding:
      position: 13
      prefix: --show-progress
  - id: verbose_debug
    type:
      - 'null'
      - boolean
    doc: Enable verbose debugging.
    inputBinding:
      position: 14
      prefix: --verbose-debug
outputs:
  - id: gfa
    type: File
    doc: The variation graph in GFA format.
    outputBinding:
      glob: $(inputs.gfa_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqwish:0.7.11--h5ca1c30_1
