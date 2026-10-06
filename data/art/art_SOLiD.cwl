cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - art_SOLiD
label: art_SOLiD
doc: "Simulation of Applied Biosystems' SOLiD sequencing reads (ART_SOLiD version\
  \ 1.3.3): single-end, mate-pair, paired-end and amplicon read simulation.\n\nTool\
  \ homepage: https://www.niehs.nih.gov/research/resources/software/biostatistics/art"
inputs:
  - id: amplicon_read_type
    type:
      - 'null'
      - string
    doc: 'specify the read type for amplicon sequencing simulation (s: single-end,
      m: matepair, p: paired-end)'
    inputBinding:
      position: 1
      prefix: -A
  - id: cigar_m
    type:
      - 'null'
      - boolean
    doc: indicate to use CIGAR 'M' instead of '=/X' for alignment match/mismatch
    inputBinding:
      position: 1
      prefix: -M
  - id: sam_out
    type:
      - 'null'
      - boolean
    doc: indicate to generate a SAM alignment file
    inputBinding:
      position: 1
      prefix: -s
  - id: rand_seed
    type:
      - 'null'
      - int
    doc: specify the random seed for the simulation
    inputBinding:
      position: 1
      prefix: -r
  - id: error_scale_factor
    type:
      - 'null'
      - float
    doc: specify the scale factor adjusting error rate (e.g., -f 0 for zero-error
      rate simulation)
    inputBinding:
      position: 1
      prefix: -f
  - id: read_profile
    type:
      - 'null'
      - File
    doc: specify user's own read profile for simulation
    inputBinding:
      position: 1
      prefix: -p
  - id: input_seq_file
    type: File
    doc: filename of DNA/RNA reference sequences in FASTA format
    inputBinding:
      position: 10
  - id: output_file_prefix
    type: string
    doc: prefix for all output read data files
    inputBinding:
      position: 11
  - id: len_read
    type: int
    doc: length of F3/R3 reads (LEN_READ), or of F3 reads for paired-end simulation
      (LEN_READ_F3)
    inputBinding:
      position: 12
  - id: len_read_f5
    type:
      - 'null'
      - int
    doc: length of F5 reads for paired-end (F3-F5) read simulation
    inputBinding:
      position: 13
  - id: fold_coverage
    type:
      - 'null'
      - float
    doc: fold of read coverage over the reference sequences (not used for amplicon
      simulation)
    inputBinding:
      position: 14
  - id: reads_per_amplicon
    type:
      - 'null'
      - int
    doc: number of reads or read pairs per amplicon, for amplicon sequencing simulation
    inputBinding:
      position: 14
  - id: mean_frag_len
    type:
      - 'null'
      - int
    doc: mean DNA/RNA fragment size for matepair/paired-end read simulation
    inputBinding:
      position: 15
  - id: std_dev
    type:
      - 'null'
      - int
    doc: standard deviation of the DNA/RNA fragment sizes for matepair/paired-end
      read simulation
    inputBinding:
      position: 16
outputs:
  - id: reads
    type: File[]
    doc: Simulated reads in FASTQ format.
    outputBinding:
      glob: $(inputs.output_file_prefix)*.fq
  - id: map_alignments
    type: File[]
    doc: Read alignment files in ART MAP format.
    outputBinding:
      glob: $(inputs.output_file_prefix)*.map
  - id: sam_alignment
    type: File[]
    doc: Read alignment file in SAM format (with -s).
    outputBinding:
      glob: $(inputs.output_file_prefix)*.sam
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/art:2016.06.05--h0704011_13
