cwlVersion: v1.2
class: CommandLineTool
baseCommand: leviosam2
label: leviosam2_lift
doc: "lift over alignments using a chain file\n\nTool homepage: https://github.com/milkschen/leviosam2"
inputs:
  - id: command
    type: string
    doc: Command to execute (index, lift, bed, collate, reconcile)
    inputBinding:
      position: 1
  - id: add_md_nm
    type:
      - 'null'
      - boolean
    doc: Add MD and NM to output alignment records (requires -f)
    inputBinding:
      position: 102
      prefix: -m
  - id: allowed_cigar_changes
    type:
      - 'null'
      - int
    doc: Number of allowed CIGAR changes (in base pairs) for one alignment.
    default: 0
    inputBinding:
      position: 102
      prefix: -G
  - id: bed_threshold
    type:
      - 'null'
      - float
    doc: 'Threshold for BED record intersection. If <= 0: consider any overlap (>0
      bp). If > 1: consider >`-B`-bp overlap. If 1>=`-B`>0: consider overlap with
      a fraction of >`-B` of the alignment.'
    default: 0
    inputBinding:
      position: 102
      prefix: -B
  - id: chain_file
    type: File
    doc: Path to the chain file to index
    inputBinding:
      position: 102
      prefix: -c
  - id: chainmap_file
    type: File
    doc: Path to an indexed ChainMap
    inputBinding:
      position: 102
      prefix: -C
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: Chunk size for each thread. Each thread queries <-T> reads, lifts, and 
      writes. Setting a larger -T uses slightly more memory but might benefit 
      thread scaling.
    default: 256
    inputBinding:
      position: 102
      prefix: -T
  - id: commit_bed_file
    type:
      - 'null'
      - File
    doc: Path to a BED file (source coordinates). Reads overlap with the regions
      are always committed.
    default: none
    inputBinding:
      position: 102
      prefix: -r
  - id: defer_bed_file
    type:
      - 'null'
      - File
    doc: Path to a BED file (dest coordinates). Reads overlap with the regions 
      are always deferred.
    default: none
    inputBinding:
      position: 102
      prefix: -D
  - id: hts_threads
    type:
      - 'null'
      - int
    doc: Number of threads used to compress/decompress HTS files. This can 
      improve thread scaling. If -t is set, the value should be left unset. The 
      value would be inferred as `max(1, t/4)`.
    default: 0
    inputBinding:
      position: 102
      prefix: --hts_threads
  - id: input_alignment_file
    type:
      - 'null'
      - File
    doc: Path to the SAM/BAM/CRAM file to be lifted. Leave empty or set to "-" 
      to read from stdin.
    inputBinding:
      position: 102
      prefix: -a
  - id: lift_threads
    type:
      - 'null'
      - int
    doc: Number of threads used for lifting reads. If -t is set, the value 
      should be left unset. The value would be inferred as `t - max(1, t/4)`.
    default: 1
    inputBinding:
      position: 102
      prefix: --lift_threads
  - id: output_prefix
    type: string
    doc: Prefix of the output file
    inputBinding:
      position: 102
      prefix: -p
  - id: realignment_preset
    type:
      - 'null'
      - string
    doc: Re-alignment preset.
    default: '[]'
    inputBinding:
      position: 102
      prefix: -x
  - id: split_rule
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Key-value pair of a split rule. We allow appending multiple `-S` options.
      Options: mapq:<int>, aln_score:<int>, isize:<int>, hdist:<int>, clipped_frac:<float>.
      lifted. [none]'
    default: none
    inputBinding:
      position: 102
      prefix: -S
  - id: target_fai
    type: File
    doc: Path to the FAI (FASTA index) file of the target reference
    inputBinding:
      position: 102
      prefix: -F
  - id: target_fasta
    type:
      - 'null'
      - File
    doc: Path to the FASTA file of the target reference.
    inputBinding:
      position: 102
      prefix: -f
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads used. If -t is not set, the value would be the sum of
      --hts_threads and --lift_threads.
    default: 1
    inputBinding:
      position: 102
      prefix: -t
  - id: verbose_level
    type:
      - 'null'
      - int
    doc: Verbose level
    default: 0
    inputBinding:
      position: 102
      prefix: -V
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/leviosam2:0.5.0--h9948957_1
stdout: leviosam2_lift.out
