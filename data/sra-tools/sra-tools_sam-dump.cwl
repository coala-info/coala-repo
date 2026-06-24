cwlVersion: v1.2
class: CommandLineTool
baseCommand: sam-dump
label: sra-tools_sam-dump
doc: Dump SRA runs in SAM format
inputs:
  - id: path_to_run
    type:
      type: array
      items: string
    doc: Path to SRA run(s)
    inputBinding:
      position: 1
  - id: unaligned
    type:
      - 'null'
      - boolean
    doc: Output unaligned reads along with aligned reads
    inputBinding:
      position: 102
      prefix: --unaligned
  - id: primary
    type:
      - 'null'
      - boolean
    doc: Output only primary alignments
    inputBinding:
      position: 102
      prefix: --primary
  - id: cigar_long
    type:
      - 'null'
      - boolean
    doc: Output long version of CIGAR
    inputBinding:
      position: 102
      prefix: --cigar-long
  - id: cigar_cg
    type:
      - 'null'
      - boolean
    doc: Output CG version of CIGAR
    inputBinding:
      position: 102
      prefix: --cigar-CG
  - id: header
    type:
      - 'null'
      - boolean
    doc: Always reconstruct header
    inputBinding:
      position: 102
      prefix: --header
  - id: header_file
    type: File
    doc: take all headers from this file
    inputBinding:
      position: 102
      prefix: --header-file
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: Do not output headers
    inputBinding:
      position: 102
      prefix: --no-header
  - id: header_comment
    type:
      - 'null'
      - type: array
        items: string
    doc: Add comment to header. Use multiple times for several lines. Use quotes
    inputBinding:
      position: 102
      prefix: --header-comment
  - id: aligned_region
    type:
      - 'null'
      - string
    doc: 'Filter by position on genome. Name can either be file specific name (ex:
      "chr1" or "1"). "from" and "to" (inclusive) are 1-based coordinates'
    inputBinding:
      position: 102
      prefix: --aligned-region
  - id: matepair_distance
    type:
      - 'null'
      - string
    doc: Filter by distance between matepairs. Use "unknown" to find matepairs 
      split between the references. Use from-to (inclusive) to limit matepair 
      distance on the same reference
    inputBinding:
      position: 102
      prefix: --matepair-distance
  - id: seqid
    type:
      - 'null'
      - boolean
    doc: Print reference SEQ_ID in RNAME instead of NAME
    inputBinding:
      position: 102
      prefix: --seqid
  - id: hide_identical
    type:
      - 'null'
      - boolean
    doc: Output '=' if base is identical to reference
    inputBinding:
      position: 102
      prefix: --hide-identical
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: Compress output using gzip
    inputBinding:
      position: 102
      prefix: --gzip
  - id: bzip2
    type:
      - 'null'
      - boolean
    doc: Compress output using bzip2
    inputBinding:
      position: 102
      prefix: --bzip2
  - id: spot_group
    type:
      - 'null'
      - boolean
    doc: Add .SPOT_GROUP to QNAME
    inputBinding:
      position: 102
      prefix: --spot-group
  - id: fastq
    type:
      - 'null'
      - boolean
    doc: Produce FastQ formatted output
    inputBinding:
      position: 102
      prefix: --fastq
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: Produce Fasta formatted output
    inputBinding:
      position: 102
      prefix: --fasta
  - id: prefix
    type:
      - 'null'
      - string
    doc: 'Prefix QNAME: prefix.QNAME'
    inputBinding:
      position: 102
      prefix: --prefix
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: Reverse unaligned reads according to read type
    inputBinding:
      position: 102
      prefix: --reverse
  - id: cigar_cg_merge
    type:
      - 'null'
      - boolean
    doc: Apply CG fixups to CIGAR/SEQ/QUAL and outputs CG-specific columns
    inputBinding:
      position: 102
      prefix: --cigar-CG-merge
  - id: xi
    type:
      - 'null'
      - boolean
    doc: Output cSRA alignment id in XI column
    inputBinding:
      position: 102
      prefix: --XI
  - id: qual_quant
    type:
      - 'null'
      - string
    doc: Quality scores quantization level string like '1:10,10:20,20:30,30:-'
    inputBinding:
      position: 102
      prefix: --qual-quant
  - id: cg_evidence
    type:
      - 'null'
      - boolean
    doc: Output CG evidence aligned to reference
    inputBinding:
      position: 102
      prefix: --CG-evidence
  - id: cg_ev_dnb
    type:
      - 'null'
      - boolean
    doc: Output CG evidence DNB's aligned to evidence
    inputBinding:
      position: 102
      prefix: --CG-ev-dnb
  - id: cg_mappings
    type:
      - 'null'
      - boolean
    doc: Output CG sequences aligned to reference
    inputBinding:
      position: 102
      prefix: --CG-mappings
  - id: cg_sam
    type:
      - 'null'
      - boolean
    doc: Output CG evidence DNB's aligned to reference
    inputBinding:
      position: 102
      prefix: --CG-SAM
  - id: report
    type:
      - 'null'
      - boolean
    doc: report options instead of executing
    inputBinding:
      position: 102
      prefix: --report
  - id: output_file
    type: string
    doc: print output into this file (instead of STDOUT)
    inputBinding:
      position: 102
      prefix: --output-file
  - id: output_buffer_size
    type:
      - 'null'
      - string
    doc: size of output-buffer(dflt:32k, 0...off)
    inputBinding:
      position: 102
      prefix: --output-buffer-size
  - id: cachereport
    type:
      - 'null'
      - boolean
    doc: print report about mate-pair-cache
    inputBinding:
      position: 102
      prefix: --cachereport
  - id: unaligned_spots_only
    type:
      - 'null'
      - boolean
    doc: output reads for spots with no aligned reads
    inputBinding:
      position: 102
      prefix: --unaligned-spots-only
  - id: cg_names
    type:
      - 'null'
      - boolean
    doc: prints cg-style spotgroup.spotid formed names
    inputBinding:
      position: 102
      prefix: --CG-names
  - id: cursor_cache
    type:
      - 'null'
      - int
    doc: open cached cursor with this size
    inputBinding:
      position: 102
      prefix: --cursor-cache
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: min. mapq an alignment has to have, to be printed
    inputBinding:
      position: 102
      prefix: --min-mapq
  - id: no_mate_cache
    type:
      - 'null'
      - boolean
    doc: do not use mate-cache, slower but less memory usage
    inputBinding:
      position: 102
      prefix: --no-mate-cache
  - id: rna_splicing
    type:
      - 'null'
      - boolean
    doc: modify cigar-string (replace .D. with .N.) and add output flags 
      (XS:A:+/-) when rna-splicing is detected by match to spliceosome 
      recognition sites
    inputBinding:
      position: 102
      prefix: --rna-splicing
  - id: rna_splice_level
    type:
      - 'null'
      - int
    doc: level of rna-splicing detection (0,1,2) when testing for spliceosome 
      recognition sites 0=perfect match, 1=one mismatch, 2=two mismatches one on
      each site
    inputBinding:
      position: 102
      prefix: --rna-splice-level
  - id: rna_splice_log
    type: string
    doc: file, into which rna-splice events are written
    inputBinding:
      position: 102
      prefix: --rna-splice-log
  - id: disable_multithreading
    type:
      - 'null'
      - boolean
    doc: disable multithreading
    inputBinding:
      position: 102
      prefix: --disable-multithreading
  - id: omit_quality
    type:
      - 'null'
      - boolean
    doc: omit qualities
    inputBinding:
      position: 102
      prefix: --omit-quality
  - id: with_md_flag
    type:
      - 'null'
      - boolean
    doc: print MD-flag
    inputBinding:
      position: 102
      prefix: --with-md-flag
  - id: ngc
    type:
      - 'null'
      - File
    doc: PATH to ngc file
    inputBinding:
      position: 102
      prefix: --ngc
  - id: log_level
    type:
      - 'null'
      - string
    doc: Logging level as number or enum string. One of 
      (fatal|sys|int|err|warn|info|debug) or (0-6) Current/default is warn.
    inputBinding:
      position: 102
      prefix: --log-level
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Turn off all status messages for the program. Negated by verbose.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: option_file
    type:
      - 'null'
      - File
    doc: Read more options and parameters from the file.
    inputBinding:
      position: 102
      prefix: --option-file
outputs:
  - id: output_output_file
    type:
      - 'null'
      - File
    doc: print output into this file (instead of STDOUT)
    outputBinding:
      glob: $(inputs.output_file)
  - id: output_rna_splice_log
    type:
      - 'null'
      - File
    doc: file, into which rna-splice events are written
    outputBinding:
      glob: $(inputs.rna_splice_log)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sra-tools:3.4.1--2_linux_64
s:url: https://github.com/ncbi/sra-tools
$namespaces:
  s: https://schema.org/
