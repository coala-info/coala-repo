cwlVersion: v1.2
class: CommandLineTool
baseCommand: phava_test
label: phava_test
doc: "PhaVa tool for locating, creating, and analyzing inverted repeats.\n\nTool homepage:
  https://github.com/patrickwest/PhaVa"
inputs:
  - id: command
    type: string
    doc: "The subcommand to run: 'Locate', 'Create', or 'Ratio'."
    inputBinding:
      position: 1
  - id: minimap2_query
    type: File
    doc: Query sequence file for minimap2 (e.g., simulated_reads.fastq).
    inputBinding:
      position: 2
  - id: minimap2_reference
    type: File
    doc: Reference sequence file for minimap2 (e.g., invertedSeqs.fasta).
    inputBinding:
      position: 3
  - id: gap
    type:
      - 'null'
      - int
    doc: Gap penalty for einverted.
    default: 100
    inputBinding:
      position: 104
      prefix: --gap
  - id: match
    type:
      - 'null'
      - int
    doc: Match score for einverted.
    default: 5
    inputBinding:
      position: 104
      prefix: --match
  - id: maxrepeat
    type:
      - 'null'
      - int
    doc: Maximum repeat length for einverted.
    default: 750
    inputBinding:
      position: 104
      prefix: --maxrepeat
  - id: minimap2_threads
    type:
      - 'null'
      - int
    doc: Number of threads for minimap2.
    default: 1
    inputBinding:
      position: 104
      prefix: -t
  - id: mismatch
    type:
      - 'null'
      - int
    doc: Mismatch penalty for einverted (e.g., -9 or -15).
    inputBinding:
      position: 104
      prefix: --mismatch
  - id: sequence
    type:
      - 'null'
      - File
    doc: Input nucleotide sequence file for einverted.
    inputBinding:
      position: 104
      prefix: --sequence
  - id: threshold
    type:
      - 'null'
      - int
    doc: Threshold for einverted (e.g., 51 or 75).
    inputBinding:
      position: 104
      prefix: --threshold
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Output file for einverted results.
    outputBinding:
      glob: $(inputs.outfile)
  - id: outseq
    type:
      - 'null'
      - File
    doc: Output sequence file for einverted.
    outputBinding:
      glob: $(inputs.outseq)
  - id: minimap2_output
    type:
      - 'null'
      - File
    doc: Output SAM file for minimap2.
    outputBinding:
      glob: $(inputs.minimap2_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phava:0.2.3--pyhdfd78af_0
