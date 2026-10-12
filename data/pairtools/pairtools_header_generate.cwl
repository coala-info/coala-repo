cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pairtools
  - header
  - generate
label: pairtools_header_generate
doc: "Generate the header\n\nTool homepage: https://github.com/open2c/pairtools"
inputs:
  - id: pairs_path
    type:
      - 'null'
      - File
    doc: Input .pairs/.pairsam file (optional)
    inputBinding:
      position: 1
  - id: chroms_path
    type:
      - 'null'
      - File
    doc: 'Chromosome order used to flip interchromosomal mates: path to a chromosomes
      file (e.g. UCSC chrom.sizes or similar) whose first column lists scaffold names.
      Any scaffolds not listed will be ordered lexicographically following the names
      provided.'
    inputBinding:
      position: 102
      prefix: --chroms-path
  - id: sam_path
    type:
      - 'null'
      - File
    doc: Input sam file to inherit the header. Either --sam-path or --chroms-path should
      be provided to store the chromosome sizes in the header.
    inputBinding:
      position: 102
      prefix: --sam-path
  - id: columns
    type:
      - 'null'
      - string
    doc: Report columns describing alignments. Comma-separated list. By default, the
      standard .pairs columns are assigned.
    inputBinding:
      position: 102
      prefix: --columns
  - id: extra_columns
    type:
      - 'null'
      - string
    doc: Report extra columns describing alignments. Comma-separated list.
    inputBinding:
      position: 102
      prefix: --extra-columns
  - id: assembly
    type:
      - 'null'
      - string
    doc: Name of genome assembly (e.g. hg19, mm10) to store in the pairs header.
    inputBinding:
      position: 102
      prefix: --assembly
  - id: no_flip
    type:
      - 'null'
      - boolean
    doc: If specified, assume that the pairs are not flipped in genomic order and
      instead preserve the order in which they were sequenced.
    inputBinding:
      position: 102
      prefix: --no-flip
  - id: pairs
    type:
      - 'null'
      - boolean
    doc: 'Set the default columns to readID,chrom1,pos1,chrom2,pos2,strand1,strand2,pair_type
      (the default, --pairs)'
    inputBinding:
      position: 102
      prefix: --pairs
  - id: pairsam
    type:
      - 'null'
      - boolean
    doc: 'Set the default columns to readID,chrom1,pos1,chrom2,pos2,strand1,strand2,pair_type,sam1,sam2
      (--pairsam)'
    inputBinding:
      position: 102
      prefix: --pairsam
  - id: nproc_in
    type:
      - 'null'
      - int
    doc: Number of processes used by the auto-guessed input decompressing command.
    inputBinding:
      position: 102
      prefix: --nproc-in
  - id: nproc_out
    type:
      - 'null'
      - int
    doc: Number of processes used by the auto-guessed output compressing command.
    inputBinding:
      position: 102
      prefix: --nproc-out
  - id: cmd_in
    type:
      - 'null'
      - string
    doc: 'A command to decompress the input. If provided, fully overrides the auto-guessed
      command. Does not work with stdin. Must read input from stdin and print output
      into stdout. EXAMPLE: pbgzip -dc -n 3'
    inputBinding:
      position: 102
      prefix: --cmd-in
  - id: cmd_out
    type:
      - 'null'
      - string
    doc: 'A command to compress the output. If provided, fully overrides the auto-guessed
      command. Does not work with stdout. Must read input from stdin and print output
      into stdout. EXAMPLE: pbgzip -c -n 8'
    inputBinding:
      position: 102
      prefix: --cmd-out
  - id: output_path
    type: string
    doc: Output file. If the path ends with .gz or .lz4, the output is bgzip-/lz4c-compressed.
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output
    type: File
    doc: Output pairs file or header
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pairtools:1.1.3--py310h4e61836_0
