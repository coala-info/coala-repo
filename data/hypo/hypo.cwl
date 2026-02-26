cwlVersion: v1.2
class: CommandLineTool
baseCommand: hypo
label: hypo
doc: "Polishes draft genomes using short and/or long reads.\n\nTool homepage: https://github.com/kensung-lab/hypo"
inputs:
  - id: bam_lr
    type:
      - 'null'
      - File
    doc: "Input file name containing the alignments of long reads against the draft
      (in bam/sam format; must have CIGAR information).\n\t[Only Short reads polishing
      will be performed if this argument is not given]"
    inputBinding:
      position: 101
      prefix: --bam-lr
  - id: bam_sr
    type: File
    doc: Input file name containing the alignments of short reads against the 
      draft (in bam/sam format; must have CIGAR information).
    inputBinding:
      position: 101
      prefix: --bam-sr
  - id: coverage_short
    type: int
    doc: Approximate mean coverage of the short reads.
    inputBinding:
      position: 101
      prefix: --coverage-short
  - id: draft
    type: File
    doc: Input file name containing the draft contigs (in fasta/fastq format; 
      can be compressed).
    inputBinding:
      position: 101
      prefix: --draft
  - id: gap_lr
    type:
      - 'null'
      - int
    doc: Gap penalty for long reads (must be negative).
    default: -4
    inputBinding:
      position: 101
      prefix: --gap-lr
  - id: gap_sr
    type:
      - 'null'
      - int
    doc: Gap penalty for short reads (must be negative).
    default: -8
    inputBinding:
      position: 101
      prefix: --gap-sr
  - id: intermed
    type:
      - 'null'
      - boolean
    doc: "Store or use (if already exist) the intermediate files.\n\t[Currently, only
      Solid kmers are stored as an intermediate file.]."
    inputBinding:
      position: 101
      prefix: --intermed
  - id: kind_sr
    type:
      - 'null'
      - string
    doc: "Kind of the short reads.\n\t[Valid Values] \n\t\tsr\t(Corresponding to NGS
      reads like Illumina reads) \n\t\tccs\t(Corresponding to HiFi reads like PacBio
      CCS reads)\n\t[Default] sr."
    default: sr
    inputBinding:
      position: 101
      prefix: --kind-sr
  - id: match_lr
    type:
      - 'null'
      - int
    doc: Score for matching bases for long reads.
    default: 3
    inputBinding:
      position: 101
      prefix: --match-lr
  - id: match_sr
    type:
      - 'null'
      - int
    doc: Score for matching bases for short reads.
    default: 5
    inputBinding:
      position: 101
      prefix: --match-sr
  - id: mismatch_lr
    type:
      - 'null'
      - int
    doc: Score for mismatching bases for long reads.
    default: -5
    inputBinding:
      position: 101
      prefix: --mismatch-lr
  - id: mismatch_sr
    type:
      - 'null'
      - int
    doc: Score for mismatching bases for short reads.
    default: -4
    inputBinding:
      position: 101
      prefix: --mismatch-sr
  - id: ned_th
    type:
      - 'null'
      - int
    doc: Threshold for Normalised Edit Distance of long arms allowed in a window
      (in %). Higher number means more arms allowed which may slow down the 
      execution.
    default: 20
    inputBinding:
      position: 101
      prefix: --ned-th
  - id: processing_size
    type:
      - 'null'
      - int
    doc: "Number of contigs to be processed in one batch. Lower value means less memory
      usage but slower speed.\n\t[Default] All the contigs in the draft."
    inputBinding:
      position: 101
      prefix: --processing-size
  - id: qual_map_th
    type:
      - 'null'
      - int
    doc: Threshold for mapping quality of reads. The reads with mapping quality 
      below this threshold will not be taken into consideration.
    default: 2
    inputBinding:
      position: 101
      prefix: --qual-map-th
  - id: reads_short
    type: File
    doc: Input file name containing reads (in fasta/fastq format; can be 
      compressed). A list of files containing file names in each line can be 
      passed with @ prefix.
    inputBinding:
      position: 101
      prefix: --reads-short
  - id: size_ref
    type: string
    doc: Approximate size of the genome (a number; could be followed by units 
      k/m/g; e.g. 10m, 2.3g).
    inputBinding:
      position: 101
      prefix: --size-ref
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads.
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: "Output file name.\n\t[Default] hypo_<draft_file_name>.fasta in the working
      directory."
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hypo:1.0.3--h9a82719_1
