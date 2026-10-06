cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - art_454
label: art_454
doc: "Simulation of 454 Pyrosequencing reads (ART_454 version 2.6.0): single-end,\
  \ paired-end and amplicon read simulation.\n\nTool homepage: https://www.niehs.nih.gov/research/resources/software/biostatistics/art"
inputs:
  - id: single_amplicon
    type:
      - 'null'
      - boolean
    doc: indicate to perform single-end amplicon sequencing simulation
    inputBinding:
      position: 1
      prefix: -A
  - id: paired_amplicon
    type:
      - 'null'
      - boolean
    doc: indicate to perform paired-end amplicon sequencing simulation
    inputBinding:
      position: 1
      prefix: -B
  - id: cigar_m
    type:
      - 'null'
      - boolean
    doc: indicate to use CIGAR 'M' instead of '=/X' for alignment match/mismatch
    inputBinding:
      position: 1
      prefix: -M
  - id: aln_out
    type:
      - 'null'
      - boolean
    doc: indicate to output the ALN alignment file
    inputBinding:
      position: 1
      prefix: -a
  - id: sam_out
    type:
      - 'null'
      - boolean
    doc: indicate to output the SAM alignment file
    inputBinding:
      position: 1
      prefix: -s
  - id: debug
    type:
      - 'null'
      - boolean
    doc: print out warning messages for debugging
    inputBinding:
      position: 1
      prefix: -d
  - id: titanium
    type:
      - 'null'
      - boolean
    doc: 'indicate to simulate reads from the built-in GS FLX Titanium profile [default:
      GS FLX profile]'
    inputBinding:
      position: 1
      prefix: -t
  - id: rand_seed
    type:
      - 'null'
      - int
    doc: specify a fixed random seed for the simulation
    inputBinding:
      position: 1
      prefix: -r
  - id: num_flow_cycles
    type:
      - 'null'
      - int
    doc: 'specify the number of flow cycles by the sequencer [default: 100 for GS-FLX,
      and 200 for GS-FLX Titanium]'
    inputBinding:
      position: 1
      prefix: -c
  - id: read_profile
    type:
      - 'null'
      - Directory
    doc: specify user's own read profile for simulation (the directory containing
      the read profile data files)
    inputBinding:
      position: 1
      prefix: -p
  - id: input_seq_file
    type: File
    doc: the filename of DNA/RNA reference sequences in FASTA format
    inputBinding:
      position: 10
  - id: output_file_prefix
    type: string
    doc: the prefix of output read data file (*.fq) and read alignment file (*.aln)
    inputBinding:
      position: 11
  - id: fold_coverage
    type:
      - 'null'
      - float
    doc: the fold of read coverage over the reference sequences (not used for amplicon
      simulation)
    inputBinding:
      position: 12
  - id: reads_per_amplicon
    type:
      - 'null'
      - int
    doc: number of reads (-A) or read pairs (-B) per amplicon, for amplicon sequencing
      simulation
    inputBinding:
      position: 12
  - id: mean_frag_len
    type:
      - 'null'
      - int
    doc: the average DNA fragment size for paired-end read simulation
    inputBinding:
      position: 13
  - id: std_dev
    type:
      - 'null'
      - int
    doc: the standard deviation of the DNA fragment size for paired-end read simulation
    inputBinding:
      position: 14
outputs:
  - id: reads
    type: File[]
    doc: Simulated reads in FASTQ format (one file for single-end, two for paired-end).
    outputBinding:
      glob: $(inputs.output_file_prefix)*.fq
  - id: aln_alignments
    type: File[]
    doc: Read alignment files in ALN format.
    outputBinding:
      glob: $(inputs.output_file_prefix)*.aln
  - id: sam_alignment
    type: File[]
    doc: Read alignment file in SAM format (with -s).
    outputBinding:
      glob: $(inputs.output_file_prefix)*.sam
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/art:2016.06.05--h0704011_13
