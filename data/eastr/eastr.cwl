cwlVersion: v1.2
class: CommandLineTool
baseCommand: eastr
label: eastr
doc: "Emending alignments of spuriously spliced transcript reads. The script takes
  GTF, BED, or BAM files as input and processes them using the provided reference
  genome and BowTie2 index. It identifies spurious junctions and filters the input
  data accordingly.\n\nTool homepage: https://github.com/ishinder/EASTR"
inputs:
  - id: bam
    type:
      - 'null'
      - File
    doc: Input BAM file or a TXT file containing a list of BAM files with read 
      alignments
    inputBinding:
      position: 101
      prefix: --bam
  - id: bed
    type:
      - 'null'
      - File
    doc: Input BED file with intron coordinates
    inputBinding:
      position: 101
      prefix: --bed
  - id: bowtie2_index
    type: Directory
    doc: Path to Bowtie2 index for the reference genome
    inputBinding:
      position: 101
      prefix: --bowtie2_index
  - id: bt2_k
    type:
      - 'null'
      - int
    doc: Minimum number of distinct alignments found by bowtie2 for a junction 
      to be considered spurious.
    default: 10
    inputBinding:
      position: 101
      prefix: --bt2_k
  - id: filtered_bam_suffix
    type:
      - 'null'
      - string
    doc: Suffix added to the name of the output BAM files.
    default: _EASTR_filtered
    inputBinding:
      position: 101
      prefix: --filtered_bam_suffix
  - id: gtf
    type:
      - 'null'
      - File
    doc: Input GTF file containing transcript annotations
    inputBinding:
      position: 101
      prefix: --gtf
  - id: min_anchor_length
    type:
      - 'null'
      - int
    doc: Minimum required anchor length in each of the two exons
    default: 7
    inputBinding:
      position: 101
      prefix: -a
  - id: min_duplicate_exon_length
    type:
      - 'null'
      - int
    doc: Minimum length of the duplicated exon.
    default: 27
    inputBinding:
      position: 101
      prefix: --min_duplicate_exon_length
  - id: min_junc_score
    type:
      - 'null'
      - int
    doc: Minimum number of supporting spliced reads required per junction. 
      Junctions with fewer supporting reads in all samples are filtered out if 
      the flanking regions are similar (based on mappy scoring matrix).
    default: 1
    inputBinding:
      position: 101
      prefix: --min_junc_score
  - id: minimap2_chaining_score
    type:
      - 'null'
      - int
    doc: Discard chains with chaining score.
    default: 25
    inputBinding:
      position: 101
      prefix: -m
  - id: minimap2_gap_extension_penalty
    type:
      - 'null'
      - string
    doc: Gap extension penalty. A gap of length k costs min(O1+k*E1, O2+k*E2).
    default: '[2, 1]'
    inputBinding:
      position: 101
      prefix: -E
  - id: minimap2_gap_open_penalty
    type:
      - 'null'
      - string
    doc: Gap open penalty.
    default: '[12, 32]'
    inputBinding:
      position: 101
      prefix: -O
  - id: minimap2_kmer_length
    type:
      - 'null'
      - int
    doc: K-mer length for alignment.
    default: 3
    inputBinding:
      position: 101
      prefix: -k
  - id: minimap2_match_score
    type:
      - 'null'
      - int
    doc: Matching score.
    default: 3
    inputBinding:
      position: 101
      prefix: -A
  - id: minimap2_minimizer_window
    type:
      - 'null'
      - int
    doc: Minimizer window size.
    default: 2
    inputBinding:
      position: 101
      prefix: -w
  - id: minimap2_mismatch_penalty
    type:
      - 'null'
      - int
    doc: Mismatching penalty.
    default: 4
    inputBinding:
      position: 101
      prefix: -B
  - id: minimap2_scoreN
    type:
      - 'null'
      - int
    doc: Score of a mismatch involving ambiguous bases.
    default: 1
    inputBinding:
      position: 101
      prefix: --scoreN
  - id: overhang_length
    type:
      - 'null'
      - int
    doc: Length of the overhang on either side of the splice junction.
    default: 50
    inputBinding:
      position: 101
      prefix: -o
  - id: reference
    type: File
    doc: reference FASTA genome used in alignment
    inputBinding:
      position: 101
      prefix: --reference
  - id: removed_alignments_bam
    type:
      - 'null'
      - boolean
    doc: Write removed alignments to a BAM file
    inputBinding:
      position: 101
      prefix: --removed_alignments_bam
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of parallel processes
    default: 1
    inputBinding:
      position: 101
      prefix: -p
  - id: trusted_bed
    type:
      - 'null'
      - File
    doc: Path to a BED file path with trusted junctions, which will not be 
      removed by EASTR.
    inputBinding:
      position: 101
      prefix: --trusted_bed
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Display additional information during BAM filtering, including the 
      count of total spliced alignments and removed alignments
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: out_original_junctions
    type:
      - 'null'
      - File
    doc: Write original junctions to the OUT file or directory
    outputBinding:
      glob: $(inputs.out_original_junctions)
  - id: out_removed_junctions
    type:
      - 'null'
      - File
    doc: Write removed junctions to OUT file or directory; the default output is
      to terminal
    outputBinding:
      glob: $(inputs.out_removed_junctions)
  - id: out_filtered_bam
    type:
      - 'null'
      - Directory
    doc: Write filtered bams to OUT file or directory
    outputBinding:
      glob: $(inputs.out_filtered_bam)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eastr:1.1.2--py311h2de2dd3_1
