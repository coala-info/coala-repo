cwlVersion: v1.2
class: CommandLineTool
baseCommand: gapmm2
label: gapmm2
doc: "gapped alignment with minimap2. Performs minimap2/mappy alignment with splice
  options and refines terminal alignments with edlib.\n\nTool homepage: https://github.com/nextgenusfs/gapmm2"
inputs:
  - id: reference
    type: File
    secondaryFiles:
      - .fai
    doc: reference genome (FASTA)
    inputBinding:
      position: 1
  - id: query
    type: File
    doc: transcipts in FASTA or FASTQ
    inputBinding:
      position: 2
  - id: debug
    type:
      - 'null'
      - boolean
    doc: write some debug info to stderr
    inputBinding:
      position: 103
      prefix: --debug
  - id: max_intron
    type:
      - 'null'
      - int
    doc: max intron length, controls terminal search space
    inputBinding:
      position: 103
      prefix: --max-intron
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: minimum map quality value
    inputBinding:
      position: 103
      prefix: --min-mapq
  - id: no_refine
    type:
      - 'null'
      - boolean
    doc: do not refine mappy alignment with edlib
    inputBinding:
      position: 103
      prefix: --no-refine
  - id: out_format
    type:
      - 'null'
      - string
    doc: output format [paf,gff3]
    inputBinding:
      position: 103
      prefix: --out-format
  - id: out_paf
    type:
      - 'null'
      - string
    doc: output file name (PAF format by default, see out_format); stdout if omitted
    inputBinding:
      position: 103
      prefix: --out
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use with minimap2
    inputBinding:
      position: 103
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_file
    type:
      - 'null'
      - File
    doc: Alignment file written to the path given in out_paf
    outputBinding:
      glob: $(inputs.out_paf)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gapmm2:25.8.12--pyhdfd78af_0
stdout: gapmm2.out
