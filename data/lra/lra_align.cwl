cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lra
  - align
label: lra_align
doc: "Align reads to a genome. The genome should be indexed using the 'lra index'
  program. 'reads' may be either fasta, sam, or bam, and multiple input files may
  be given.\n\nTool homepage: https://github.com/ChaissonLab/LRA"
inputs:
  - id: genome
    type: File
    doc: Indexed genome FASTA file
    inputBinding:
      position: 1
  - id: reads
    type:
      type: array
      items: File
    doc: Input FASTA, SAM, or BAM files
    inputBinding:
      position: 2
  - id: align_ccs
    type:
      - 'null'
      - boolean
    doc: Align CCS reads.
    inputBinding:
      position: 103
      prefix: -CCS
  - id: align_clr
    type:
      - 'null'
      - boolean
    doc: Align CLR reads.
    inputBinding:
      position: 103
      prefix: -CLR
  - id: align_contig
    type:
      - 'null'
      - boolean
    doc: Align large contigs.
    inputBinding:
      position: 103
      prefix: -CONTIG
  - id: align_ont
    type:
      - 'null'
      - boolean
    doc: Align Nanopore reads.
    inputBinding:
      position: 103
      prefix: -ONT
  - id: enable_dotplot
    type:
      - 'null'
      - boolean
    doc: Enable dotPlot (debugging)
    inputBinding:
      position: 103
      prefix: -d
  - id: hard_clip_sam
    type:
      - 'null'
      - boolean
    doc: Use hard-clipping for SAM output format.
    inputBinding:
      position: 103
      prefix: -H
  - id: max_alignments_compute
    type:
      - 'null'
      - int
    doc: Compute at most number of alignments for one read.
    inputBinding:
      position: 103
      prefix: --Al
  - id: max_alignments_per_read
    type:
      - 'null'
      - int
    doc: Print out at most number of alignments for one read. (Use this option 
      if want to print out secondary alignments)
    inputBinding:
      position: 103
      prefix: --PrintNumAln
  - id: no_mismatch_output
    type:
      - 'null'
      - boolean
    doc: Use M instead of =/X in SAM/PAF output.
    inputBinding:
      position: 103
      prefix: --noMismatch
  - id: passthrough_aux_tags
    type:
      - 'null'
      - boolean
    doc: Pass auxilary tags from the input unaligned bam to the output.
    inputBinding:
      position: 103
      prefix: --passthrough
  - id: print_format
    type:
      - 'null'
      - string
    doc: Print alignment format FMT='b' bed, 's' sam, 'p'PAF, 'pc'PAF with 
      cigar, 'a' pairwise alignment.
    inputBinding:
      position: 103
      prefix: -p
  - id: print_md_tag
    type:
      - 'null'
      - boolean
    doc: Write the MD tag in sam and paf output.
    inputBinding:
      position: 103
      prefix: --printMD
  - id: query_all_positions
    type:
      - 'null'
      - boolean
    doc: Query all positions in a read, not just minimizers.
    inputBinding:
      position: 103
      prefix: -a
  - id: refine_breakpoints
    type:
      - 'null'
      - boolean
    doc: Refine alignments of query sequence up to 500 bases near a breakpoint.
    inputBinding:
      position: 103
      prefix: --refineBreakpoints
  - id: secondary_alignment_score_fraction
    type:
      - 'null'
      - float
    doc: Retain secondary alignments that have score at least this fraction to 
      the primary alignment
    inputBinding:
      position: 103
      prefix: --alnthres
  - id: skip_flags
    type:
      - 'null'
      - int
    doc: Skip reads with any flags in F set (bam input only).
    inputBinding:
      position: 103
      prefix: -Flag
  - id: stride
    type:
      - 'null'
      - int
    doc: Read stride (for multi-job alignment of the same file).
    inputBinding:
      position: 103
      prefix: --stride
  - id: threads
    type:
      - 'null'
      - int
    doc: Use n threads
    inputBinding:
      position: 103
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lra:1.3.7.2--h5ca1c30_4
stdout: lra_align.out
