cwlVersion: v1.2
class: CommandLineTool
baseCommand: collapse_isoforms_by_sam.py
label: cdna_cupcake_collapse_isoforms_by_sam.py
doc: "Collapse redundant isoforms based on SAM alignments.\n\nTool homepage: https://github.com/Magdoll/cDNA_Cupcake"
inputs:
  - id: dun_merge_5_shorter
    type:
      - 'null'
      - boolean
    doc: "Don't collapse shorter 5' transcripts (default: turned off)"
    inputBinding:
      position: 101
      prefix: --dun-merge-5-shorter
  - id: input_fasta
    type:
      - 'null'
      - File
    doc: Input FA/FQ filename
    inputBinding:
      position: 101
      prefix: --input
  - id: input_fq
    type:
      - 'null'
      - boolean
    doc: Input is a fastq file (default is fasta)
    inputBinding:
      position: 101
      prefix: --fq
  - id: input_sam
    type:
      - 'null'
      - File
    doc: Sorted SAM filename, use either this or --bam
    inputBinding:
      position: 101
      prefix: --sam
  - id: input_bam
    type:
      - 'null'
      - File
    doc: Sorted BAM filename, use either this or --sam
    inputBinding:
      position: 101
      prefix: --bam
  - id: max_fuzzy_junction
    type:
      - 'null'
      - int
    doc: "Max fuzzy junction dist (default: 5 bp)"
    inputBinding:
      position: 101
      prefix: --max_fuzzy_junction
  - id: max_5_diff
    type:
      - 'null'
      - int
    doc: "Maximum allowed 5' difference if on same exon (default: 1000 bp)"
    inputBinding:
      position: 101
      prefix: --max_5_diff
  - id: max_3_diff
    type:
      - 'null'
      - int
    doc: "Maximum allowed 3' difference if on same exon (default: 100 bp)"
    inputBinding:
      position: 101
      prefix: --max_3_diff
  - id: flnc_coverage
    type:
      - 'null'
      - int
    doc: "Minimum # of FLNC reads, only use this for aligned FLNC reads, otherwise
      results undefined!"
    inputBinding:
      position: 101
      prefix: --flnc_coverage
  - id: gen_mol_count
    type:
      - 'null'
      - boolean
    doc: Generate a .abundance.txt file based on the number of input sequences 
      collapsed. Use only if input is FLNC or UMI-dedup output (default off)
    inputBinding:
      position: 101
      prefix: --gen_mol_count
  - id: min_coverage
    type:
      - 'null'
      - float
    doc: "Minimum alignment coverage (default: 0.99)"
    inputBinding:
      position: 101
      prefix: --min-coverage
  - id: min_identity
    type:
      - 'null'
      - float
    doc: "Minimum alignment identity (default: 0.95)"
    inputBinding:
      position: 101
      prefix: --min-identity
  - id: cpus
    type:
      - 'null'
      - int
    doc: "Number of CPUs for parallelization (default: 1)"
    inputBinding:
      position: 101
      prefix: --cpus
  - id: output_prefix_path
    type: string
    doc: Output filename prefix
    inputBinding:
      position: 102
      prefix: --prefix
outputs:
  - id: output_prefix
    type:
      type: array
      items: File
    doc: Output files written with the prefix (.collapsed.gff, 
      .collapsed.group.txt, .collapsed.rep.fa/fq, .ignored_ids.txt, ...)
    outputBinding:
      glob: $(inputs.output_prefix_path)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cdna_cupcake:29.0.0--py310h79ef01b_0
