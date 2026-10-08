cwlVersion: v1.2
class: CommandLineTool
baseCommand: fqtools
label: fqtools_validate
doc: "Validate FASTQ files.

Tool homepage: https://github.com/alastair-droop/fqtools"
inputs:
  - id: dna_bases
    type:
      - 'null'
      - boolean
    doc: "Allow DNA sequence bases (ACGTN)"
    inputBinding:
      position: 1
      prefix: -d
  - id: rna_bases
    type:
      - 'null'
      - boolean
    doc: "Allow RNA sequence bases (ACGUN)"
    inputBinding:
      position: 2
      prefix: -r
  - id: ambiguous_bases
    type:
      - 'null'
      - boolean
    doc: "Allow ambiguous sequence bases (RYKMSWBDHV)"
    inputBinding:
      position: 3
      prefix: -a
  - id: mask_base
    type:
      - 'null'
      - boolean
    doc: "Allow the mask sequence base (X)"
    inputBinding:
      position: 4
      prefix: -m
  - id: uppercase_bases
    type:
      - 'null'
      - boolean
    doc: "Allow uppercase sequence bases"
    inputBinding:
      position: 5
      prefix: -u
  - id: lowercase_bases
    type:
      - 'null'
      - boolean
    doc: "Allow lowercase sequence bases"
    inputBinding:
      position: 6
      prefix: -l
  - id: pair_character
    type:
      - 'null'
      - string
    doc: "Set the pair replacement character (default %)"
    inputBinding:
      position: 7
      prefix: -p
  - id: input_buffer_size
    type:
      - 'null'
      - string
    doc: "Set the input buffer size (suffixes b, k, M, G)"
    inputBinding:
      position: 8
      prefix: -b
  - id: output_buffer_size
    type:
      - 'null'
      - string
    doc: "Set the output buffer size (suffixes b, k, M, G)"
    inputBinding:
      position: 9
      prefix: -B
  - id: quality_type
    type:
      - 'null'
      - string
    doc: "Set the quality score encoding: u (none), s (Sanger), o (Solexa), i (Illumina)"
    inputBinding:
      position: 10
      prefix: -q
  - id: input_format
    type:
      - 'null'
      - string
    doc: "Set the input file format: F (fastq), f (fastq.gz), b (bam), s (sam), u (infer from extension)"
    inputBinding:
      position: 11
      prefix: -f
  - id: output_format
    type:
      - 'null'
      - string
    doc: "Set the output file format: F (fastq), f (fastq.gz), b (bam), s (sam), u (infer from extension)"
    inputBinding:
      position: 12
      prefix: -F
  - id: interleaved_input
    type:
      - 'null'
      - boolean
    doc: "Read interleaved input file pairs"
    inputBinding:
      position: 13
      prefix: -i
  - id: interleaved_output
    type:
      - 'null'
      - boolean
    doc: "Write interleaved output file pairs"
    inputBinding:
      position: 14
      prefix: -I
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "The FASTQ file(s) to process: one file, or two files for a read pair (standard input is read when no file is given)"
    inputBinding:
      position: 200
arguments:
  - position: 50
    valueFrom: validate
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fqtools:2.0--h577a1d6_15
stdout: fqtools_validate.out
