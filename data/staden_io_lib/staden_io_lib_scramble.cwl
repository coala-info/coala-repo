cwlVersion: v1.2
class: CommandLineTool
baseCommand: scramble
label: staden_io_lib_scramble
doc: "Convert between SAM, BAM, and CRAM formats with compression and indexing options.\n\
  \nTool homepage: https://github.com/jkbonfield/io_lib/"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input file (optional, defaults to stdin)
    inputBinding:
      position: 1
  - id: compress_with_fqzcomp
    type:
      - 'null'
      - boolean
    doc: '[Cram] Also compression using fqzcomp (V3.1+)'
    inputBinding:
      position: 102
      prefix: -f
  - id: compression_level
    type:
      - 'null'
      - int
    doc: Set compression level (1-9).
    inputBinding:
      position: 102
      prefix: '-9'
  - id: convert_to_bam_with_index
    type:
      - 'null'
      - File
    doc: Convert to Bam using index (file.gzi)
    inputBinding:
      position: 102
      prefix: -g
  - id: cram_version
    type:
      - 'null'
      - string
    doc: '[Cram] Specify the file format version to write (eg 1.1, 2.0)'
    inputBinding:
      position: 102
      prefix: -V
  - id: disable_checksum_checking
    type:
      - 'null'
      - boolean
    doc: Disable all checking of checksums
    inputBinding:
      position: 102
      prefix: -!
  - id: discard_read_names
    type:
      - 'null'
      - boolean
    doc: '[Cram] Discard read names where possible.'
    inputBinding:
      position: 102
      prefix: -n
  - id: embed_reference
    type:
      - 'null'
      - boolean
    doc: '[Cram] Embed reference sequence.'
    inputBinding:
      position: 102
      prefix: -e
  - id: generate_md_nm_tags
    type:
      - 'null'
      - boolean
    doc: '[Cram] Generate MD and NM tags.'
    inputBinding:
      position: 102
      prefix: -m
  - id: illumina_8_quality_binning
    type:
      - 'null'
      - boolean
    doc: Enable Illumina 8 quality-binning system (lossy)
    inputBinding:
      position: 102
      prefix: -B
  - id: input_format
    type:
      - 'null'
      - string
    doc: 'Set input format: "bam", "sam" or "cram".'
    inputBinding:
      position: 102
      prefix: -I
  - id: max_bases_per_slice
    type:
      - 'null'
      - int
    doc: '[Cram] Max. bases per slice, default 5000000.'
    inputBinding:
      position: 102
      prefix: -b
  - id: multiple_references_per_slice
    type:
      - 'null'
      - boolean
    doc: '[Cram] Use multiple references per slice.'
    inputBinding:
      position: 102
      prefix: -M
  - id: no_compression
    type:
      - 'null'
      - boolean
    doc: No compression.
    inputBinding:
      position: 102
      prefix: -u
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: '[SAM] Do not print header'
    inputBinding:
      position: 102
      prefix: -H
  - id: no_scramble_pg_header
    type:
      - 'null'
      - boolean
    doc: Don't add scramble @PG header line
    inputBinding:
      position: 102
      prefix: -q
  - id: non_reference_encoding
    type:
      - 'null'
      - boolean
    doc: '[Cram] Non-reference based encoding.'
    inputBinding:
      position: 102
      prefix: -x
  - id: output_format
    type:
      - 'null'
      - string
    doc: 'Set output format: "bam", "sam" or "cram".'
    inputBinding:
      position: 102
      prefix: -O
  - id: preserve_all_aux_tags
    type:
      - 'null'
      - boolean
    doc: Preserve all aux tags (incl RG,NM,MD)
    inputBinding:
      position: 102
      prefix: -P
  - id: preserve_aux_tag_sizes
    type:
      - 'null'
      - boolean
    doc: Preserve aux tag sizes ('i', 's', 'c')
    inputBinding:
      position: 102
      prefix: -p
  - id: ref_range
    type:
      - 'null'
      - string
    doc: '[Cram] Specifies the refseq:start-end range'
    inputBinding:
      position: 102
      prefix: -R
  - id: reference_file
    type:
      - 'null'
      - File
    doc: '[Cram] Specifies the reference file.'
    inputBinding:
      position: 102
      prefix: -r
  - id: sequences_per_slice
    type:
      - 'null'
      - int
    doc: '[Cram] Sequences per slice, default 10000.'
    inputBinding:
      position: 102
      prefix: -s
  - id: slices_per_container
    type:
      - 'null'
      - int
    doc: '[Cram] Slices per container, default 1.'
    inputBinding:
      position: 102
      prefix: -S
  - id: stop_decoding_after
    type:
      - 'null'
      - int
    doc: Stop decoding after 'integer' sequences
    inputBinding:
      position: 102
      prefix: -N
  - id: threads
    type:
      - 'null'
      - int
    doc: Use N threads (availability varies by format)
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file (optional, defaults to stdout)
    outputBinding:
      glob: '*.out'
  - id: output_bam_index
    type:
      - 'null'
      - File
    doc: Output Bam index when bam input(file.gzi)
    outputBinding:
      glob: $(inputs.output_bam_index)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/staden-io-lib-utils:v1.14.11-6-deb_cv1
