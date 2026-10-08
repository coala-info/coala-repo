cwlVersion: v1.2
class: CommandLineTool
baseCommand: [ft, pg-inject]
label: fibertools-rs_pg-inject
doc: "Create a mock BAM file from a reference FASTA with perfectly aligned sequences\n\nTool homepage: https://github.com/fiberseq/fibertools-rs"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fibertools-rs:0.8.2--h3b373d1_0
inputs:
  - id: out_bam
    type: string
    doc: "Output BAM file name."
    default: "pg_inject.bam"
    inputBinding:
      position: 1
      prefix: --out
  - id: split_size
    type: ['null', int]
    doc: "Split contigs into multiple BAM records every N base pairs, 0 means no splitting (default 50000)."
    inputBinding:
      position: 1
      prefix: -s
  - id: uncompressed
    type: ['null', boolean]
    doc: "Uncompressed BAM output."
    inputBinding:
      position: 1
      prefix: -u
  - id: bed
    type: ['null', File]
    doc: "Optional BED file with annotations to add to mock BAM records."
    inputBinding:
      position: 1
      prefix: -b
  - id: extract
    type: ['null', boolean]
    doc: "Extract BED annotations from an annotated BAM file (reverses injection)."
    inputBinding:
      position: 1
      prefix: -e
  - id: header_out
    type: ['null', string]
    doc: "Additionally write the output BAM header to this file."
    inputBinding:
      position: 1
      prefix: --header-out
  - id: prefix
    type: ['null', string]
    doc: "panSN-spec prefix to add to contig names (e.g. \"HG002#1#\"). Mutually exclusive with --strip."
    inputBinding:
      position: 1
      prefix: --prefix
  - id: strip
    type: ['null', boolean]
    doc: "Strip panSN-spec information from contig names. Mutually exclusive with --prefix."
    inputBinding:
      position: 1
      prefix: --strip
  - id: delimiter
    type: ['null', string]
    doc: "Delimiter character to use when stripping panSN-spec (default '#')."
    inputBinding:
      position: 1
      prefix: --delimiter
  - id: hap1_tag
    type: ['null', string]
    doc: "Tag to identify haplotype 1 contigs (e.g. \"haplotype1\"). If both hap1-tag and hap2-tag are provided, reads are tagged with HP based on contig names."
    inputBinding:
      position: 1
      prefix: --hap1-tag
  - id: hap2_tag
    type: ['null', string]
    doc: "Tag to identify haplotype 2 contigs (e.g. \"haplotype2\"). If both hap1-tag and hap2-tag are provided, reads are tagged with HP based on contig names."
    inputBinding:
      position: 1
      prefix: --hap2-tag
  - id: min_mapq
    type: ['null', int]
    doc: "The mapping quality must be greater than or equal to this value for haplotag assignment (default 0)."
    inputBinding:
      position: 1
      prefix: --min-mapq
  - id: copy_header
    type: ['null', File]
    doc: "BAM file to copy header from (excluding SQ and HD tags)."
    inputBinding:
      position: 1
      prefix: --copy-header
  - id: threads
    type: ['null', int]
    doc: "Threads (default 8)."
    inputBinding:
      position: 1
      prefix: -t
  - id: verbose
    type: ['null', boolean]
    doc: "Logging level: info. Use ft help for deeper levels."
    inputBinding:
      position: 1
      prefix: -v
  - id: quiet
    type: ['null', boolean]
    doc: "Turn off all logging."
    inputBinding:
      position: 1
      prefix: --quiet
  - id: reference
    type: File
    doc: "Reference FASTA file to create the mock BAM from (supports .gz/.bgz compression)."
    inputBinding:
      position: 10
outputs:
  - id: output_bam
    type: File
    doc: "Mock BAM file with perfectly aligned sequences."
    outputBinding:
      glob: $(inputs.out_bam)
  - id: header_file
    type: ['null', File]
    doc: "BAM header written with --header-out."
    outputBinding:
      glob: $(inputs.header_out)
