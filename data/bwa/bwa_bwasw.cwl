cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bwa
  - bwasw
label: bwa_bwasw
doc: "BWA-SW alignment algorithm for long reads, supporting Smith-Waterman alignment
  and chimeric read detection.\n\nTool homepage: https://github.com/lh3/bwa"
inputs:
  - id: target_prefix
    type: File
    doc: The bwa index of the target, given as its .bwt file (for example ref.fa.bwt from bwa_index) or
      as the file named like the index prefix (for example ref.fa); the .amb, .ann,
      .bwt, .pac and .sa files must sit beside it
    secondaryFiles:
      - pattern: "${ var b = self.basename.replace(/\\.bwt$/, ''); var s = ['.amb', '.ann', '.pac', '.sa']; if (b === self.basename) { s.push('.bwt'); } return s.map(function (e) { return b + e; }); }"
        required: true
    inputBinding:
      position: 201
      valueFrom: $(self.path.replace(/\.bwt$/, ''))
  - id: query_fa
    type: File
    doc: Query FASTA/FASTQ file
    inputBinding:
      position: 202
  - id: query2_fa
    type:
      - 'null'
      - File
    doc: Second query FASTA/FASTQ file for paired-end alignment
    inputBinding:
      position: 203
  - id: band_width
    type:
      - 'null'
      - int
    doc: band width
    inputBinding:
      position: 104
      prefix: -w
  - id: copy_comment
    type:
      - 'null'
      - boolean
    doc: copy FASTA/Q comment to SAM output
    inputBinding:
      position: 104
      prefix: -C
  - id: gap_extension_penalty
    type:
      - 'null'
      - int
    doc: gap extension penalty
    inputBinding:
      position: 104
      prefix: -r
  - id: gap_open_penalty
    type:
      - 'null'
      - int
    doc: gap open penalty
    inputBinding:
      position: 104
      prefix: -q
  - id: hard_clipping
    type:
      - 'null'
      - boolean
    doc: in SAM output, use hard clipping instead of soft clipping
    inputBinding:
      position: 104
      prefix: -H
  - id: ignore_pairs_insert_size
    type:
      - 'null'
      - int
    doc: ignore pairs with insert >=INT for inferring the size distr
    inputBinding:
      position: 104
      prefix: -I
  - id: length_threshold_adjustment
    type:
      - 'null'
      - float
    doc: coefficient of length-threshold adjustment
    inputBinding:
      position: 104
      prefix: -c
  - id: mark_secondary
    type:
      - 'null'
      - boolean
    doc: mark multi-part alignments as secondary
    inputBinding:
      position: 104
      prefix: -M
  - id: mask_level
    type:
      - 'null'
      - float
    doc: mask level
    inputBinding:
      position: 104
      prefix: -m
  - id: match_score
    type:
      - 'null'
      - int
    doc: score for a match
    inputBinding:
      position: 104
      prefix: -a
  - id: max_gap_size
    type:
      - 'null'
      - int
    doc: maximum gap size during chaining
    inputBinding:
      position: 104
      prefix: -G
  - id: max_seeding_interval
    type:
      - 'null'
      - int
    doc: maximum seeding interval size
    inputBinding:
      position: 104
      prefix: -s
  - id: mismatch_penalty
    type:
      - 'null'
      - int
    doc: mismatch penalty
    inputBinding:
      position: 104
      prefix: -b
  - id: num_seeds
    type:
      - 'null'
      - int
    doc: '# seeds to trigger rev aln; 2*INT is also the chaining threshold'
    inputBinding:
      position: 104
      prefix: -N
  - id: score_threshold
    type:
      - 'null'
      - int
    doc: score threshold divided by a
    inputBinding:
      position: 104
      prefix: -T
  - id: skip_sw_pairing
    type:
      - 'null'
      - boolean
    doc: skip Smith-Waterman read pairing
    inputBinding:
      position: 104
      prefix: -S
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 104
      prefix: -t
  - id: z_best
    type:
      - 'null'
      - int
    doc: Z-best
    inputBinding:
      position: 104
      prefix: -z
  - id: output_file_path
    type: string
    doc: Name of the SAM file to write; any directory part is dropped
    inputBinding:
      position: 150
      prefix: -f
      valueFrom: $(self.split('/').pop())
outputs:
  - id: output_file
    type: File
    doc: The SAM file with the alignments
    outputBinding:
      glob: $(inputs.output_file_path.split('/').pop())
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwa:0.7.19--h577a1d6_1
