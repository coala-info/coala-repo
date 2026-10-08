cwlVersion: v1.2
class: CommandLineTool
baseCommand: [ft, pg-pansn]
label: fibertools-rs_pg-pansn
doc: "Add or strip panSN-spec prefixes from BAM contig names\n\nTool homepage: https://github.com/fiberseq/fibertools-rs"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fibertools-rs:0.8.2--h3b373d1_0
inputs:
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
  - id: filter
    type: ['null', int]
    doc: "BAM bit flags to filter on, equivalent to `-F` in samtools view (default 0)."
    inputBinding:
      position: 1
      prefix: -F
  - id: ftx
    type: ['null', string]
    doc: "Filtering expression to use for filtering records, for example \"len(nuc)>150\" or \"len(nuc)<150,len(msp)=30:50\". Supports len() and qual() over msp, nuc, m6a, cpg."
    inputBinding:
      position: 1
      prefix: -x
  - id: ml
    type: ['null', int]
    doc: "Minimum score in the ML tag to use or include in the output (default 125)."
    inputBinding:
      position: 1
      prefix: --ml
  - id: uncompressed
    type: ['null', boolean]
    doc: "Output uncompressed BAM files."
    inputBinding:
      position: 1
      prefix: -u
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
  - id: bam
    type: File
    doc: "Input BAM file. For m6A prediction this should be a HiFi BAM file with kinetics data. For other commands this should be a BAM file with m6A calls."
    inputBinding:
      position: 10
  - id: out_bam
    type: string
    doc: "Output BAM file name."
    default: "pg_pansn.bam"
    inputBinding:
      position: 11
outputs:
  - id: output_bam
    type: File
    doc: "Output BAM file with panSN-spec prefixes added or stripped."
    outputBinding:
      glob: $(inputs.out_bam)
  - id: header_file
    type: ['null', File]
    doc: "BAM header written with --header-out."
    outputBinding:
      glob: $(inputs.header_out)
