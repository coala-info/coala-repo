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
    inputBinding:
      position: 104
      prefix: --gap
  - id: match
    type:
      - 'null'
      - int
    doc: Match score for einverted.
    inputBinding:
      position: 104
      prefix: --match
  - id: maxrepeat
    type:
      - 'null'
      - int
    doc: Maximum repeat length for einverted.
    inputBinding:
      position: 104
      prefix: --maxrepeat
  - id: minimap2_threads
    type:
      - 'null'
      - int
    doc: Number of threads for minimap2.
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
  - id: minimap2_output_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `minimap2_output_path`
    inputBinding:
      position: 105
      prefix: --minimap2-output
  - id: outfile_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `outfile_path`
    inputBinding:
      position: 106
      prefix: --outfile
  - id: outseq_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `outseq_path`
    inputBinding:
      position: 107
      prefix: --outseq
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Output file for einverted results.
    outputBinding:
      glob: $(inputs.outfile_path)
  - id: outseq
    type:
      - 'null'
      - File
    doc: Output sequence file for einverted.
    outputBinding:
      glob: $(inputs.outseq_path)
  - id: minimap2_output
    type:
      - 'null'
      - File
    doc: Output SAM file for minimap2.
    outputBinding:
      glob: $(inputs.minimap2_output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phava:0.2.3--pyhdfd78af_0
