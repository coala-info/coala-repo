cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fermi
  - correct
label: fermi_correct
doc: "Correct errors in reads using an FMD-index.\n\nTool homepage: https://github.com/quantumlib/OpenFermion"
inputs:
  - id: reads_fmd
    type: File
    doc: FMD-index of the reference genome
    inputBinding:
      position: 1
  - id: reads_fq
    type: File
    doc: Input reads in FASTQ format
    inputBinding:
      position: 2
  - id: jumping_heuristic_step_size
    type:
      - 'null'
      - int
    doc: step size for the jumping heuristic; 0 to disable
    default: 5
    inputBinding:
      position: 103
      prefix: -s
  - id: keep_bad_reads
    type:
      - 'null'
      - boolean
    doc: keep bad/unfixable reads
    inputBinding:
      position: 103
      prefix: -K
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: k-mer length; -1 for auto
    default: -1
    inputBinding:
      position: 103
      prefix: -k
  - id: max_corrected_bases_fraction
    type:
      - 'null'
      - float
    doc: max fraction of corrected bases
    default: 0.3
    inputBinding:
      position: 103
      prefix: -C
  - id: min_kplus1mer_occurrences
    type:
      - 'null'
      - int
    doc: minimum (k+1)-mer occurrences
    default: 3
    inputBinding:
      position: 103
      prefix: -O
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    default: 1
    inputBinding:
      position: 103
      prefix: -t
  - id: trim_length
    type:
      - 'null'
      - int
    doc: trim read down to INT bp; 0 to disable
    default: 0
    inputBinding:
      position: 103
      prefix: -l
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermi:1.1_r751_beta--h577a1d6_9
stdout: fermi_correct.out
