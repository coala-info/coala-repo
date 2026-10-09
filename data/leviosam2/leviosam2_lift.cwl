cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - leviosam2
  - lift
label: leviosam2_lift
doc: "Lift over alignments in SAM/BAM/CRAM formats using a levioSAM2 chain index.\n\nTool homepage: https://github.com/milkschen/leviosam2"
inputs:
  - id: chainmap
    type: File
    doc: 'Path to an indexed ChainMap.'
    inputBinding:
      position: 1
      prefix: -C
  - id: alignments
    type:
      - 'null'
      - File
    doc: 'Path to the SAM/BAM/CRAM file to be lifted.'
    inputBinding:
      position: 2
      prefix: -a
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads used. If -t is not set, the value would be the sum of hts_threads and lift_threads. [1]'
    inputBinding:
      position: 3
      prefix: -t
  - id: lift_threads
    type:
      - 'null'
      - int
    doc: 'Number of threads used for lifting reads. If -t is set, the value should be left unset. [1]'
    inputBinding:
      position: 4
      prefix: --lift_threads
  - id: hts_threads
    type:
      - 'null'
      - int
    doc: 'Number of threads used to compress/decompress HTS files. If -t is set, the value should be left unset. [0]'
    inputBinding:
      position: 5
      prefix: --hts_threads
  - id: add_md_nm
    type:
      - 'null'
      - boolean
    doc: 'Add MD and NM to output alignment records (requires the reference option).'
    inputBinding:
      position: 6
      prefix: -m
  - id: reference
    type:
      - 'null'
      - File
    doc: 'Path to the FASTA file of the target reference.'
    inputBinding:
      position: 7
      prefix: -f
  - id: realignment_preset
    type:
      - 'null'
      - File
    doc: 'Re-alignment preset.'
    inputBinding:
      position: 8
      prefix: -x
  - id: allowed_cigar_changes
    type:
      - 'null'
      - int
    doc: 'Number of allowed CIGAR changes (in base pairs) for one alignment. [0]'
    inputBinding:
      position: 9
      prefix: -G
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: 'Chunk size for each thread. [256]'
    inputBinding:
      position: 10
      prefix: -T
  - id: split_rules
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -S
    doc: 'Key-value pair of a split rule, repeated for several rules (mapq:<int>, aln_score:<int>, isize:<int>, hdist:<int>, clipped_frac:<float>, lifted).'
    inputBinding:
      position: 11
  - id: bed_commit_source
    type:
      - 'null'
      - File
    doc: 'Path to a BED file (source coordinates). Reads overlapping the regions are always committed.'
    inputBinding:
      position: 12
      prefix: -r
  - id: bed_defer_dest
    type:
      - 'null'
      - File
    doc: 'Path to a BED file (dest coordinates). Reads overlapping the regions are always deferred.'
    inputBinding:
      position: 13
      prefix: -D
  - id: bed_threshold
    type:
      - 'null'
      - float
    doc: 'Threshold for BED record intersection. If <= 0: any overlap; if > 1: more than this many bp; if between 0 and 1: more than this fraction of the alignment. [0]'
    inputBinding:
      position: 14
      prefix: -B
  - id: prefix
    type: string
    doc: 'Prefix of the output files.'
    inputBinding:
      position: 15
      prefix: -p
  - id: out_format
    type:
      - 'null'
      - string
    doc: 'Output format (bam, sam or cram).'
    inputBinding:
      position: 16
      prefix: -O
  - id: verbose_level
    type:
      - 'null'
      - int
    doc: 'Verbose level [0]'
    inputBinding:
      position: 17
      prefix: -V
outputs:
  - id: lifted_files
    type: File[]
    doc: 'Lifted alignment files written with the prefix given in prefix'
    outputBinding:
      glob: $(inputs.prefix)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/leviosam2:0.5.0--h9948957_1
