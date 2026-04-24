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
    doc: Don't merge 5' shorter transcripts
    inputBinding:
      position: 101
      prefix: --dun-merge-5-shorter
  - id: flnc_count
    type:
      - 'null'
      - File
    doc: Optional FLNC count file to get abundance information
    inputBinding:
      position: 101
      prefix: --flnc_count
  - id: input_fasta
    type: File
    doc: Input FASTA/FASTQ file
    inputBinding:
      position: 101
      prefix: --input
  - id: input_fq
    type:
      - 'null'
      - File
    doc: Optional input FASTQ file; if provided, will be used to get quality scores
    inputBinding:
      position: 101
      prefix: --fq
  - id: input_sam
    type: File
    doc: Input SAM file
    inputBinding:
      position: 101
      prefix: --sam
  - id: max_fuzzy_junction
    type:
      - 'null'
      - int
    doc: Max fuzzy junction allowed
    inputBinding:
      position: 101
      prefix: --max_fuzzy_junction
  - id: min_coverage
    type:
      - 'null'
      - float
    doc: Minimum alignment coverage
    inputBinding:
      position: 101
      prefix: --min-coverage
  - id: min_identity
    type:
      - 'null'
      - float
    doc: Minimum alignment identity
    inputBinding:
      position: 101
      prefix: --min-identity
outputs:
  - id: output_prefix
    type: File
    doc: Output prefix (e.g. 'collapsed')
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cdna_cupcake:29.0.0--py310h79ef01b_0
