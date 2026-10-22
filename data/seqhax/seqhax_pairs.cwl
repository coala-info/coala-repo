cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqhax
  - pairs
label: seqhax_pairs
doc: "(De)interleave paired end reads. Reads one interleaved file, or two files, and writes pairs, unpaired\
  \ reads and statistics.\n\nTool homepage: https://github.com/kdmurray91/seqhax"
inputs:
  - id: input_file
    type: File
    doc: Sequence file in FASTA or FASTQ format
    inputBinding:
      position: 1
  - id: input_file_2
    type:
      - 'null'
      - File
    doc: Second input sequence file for paired-end data
    inputBinding:
      position: 2
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force output to existing files.
    inputBinding:
      position: 102
      prefix: -f
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum length of each read. [default 1]
    inputBinding:
      position: 102
      prefix: -l
  - id: output_mate_1_path
    type:
      - 'null'
      - string
    doc: Pair first mate output
    inputBinding:
      position: 102
      prefix: '-1'
  - id: output_mate_2_path
    type:
      - 'null'
      - string
    doc: Pair second mate output
    inputBinding:
      position: 102
      prefix: '-2'
  - id: output_interleaved_pairs_path
    type:
      - 'null'
      - string
    doc: Interleaved pairs-only output
    inputBinding:
      position: 102
      prefix: -p
  - id: output_unpaired_path
    type:
      - 'null'
      - string
    doc: Unpaired read output
    inputBinding:
      position: 102
      prefix: -u
  - id: output_strict_interleaved_path
    type:
      - 'null'
      - string
    doc: '"Strict interleaved" output, all reads'
    inputBinding:
      position: 102
      prefix: -s
  - id: output_broken_paired_path
    type:
      - 'null'
      - string
    doc: '"Broken paired" output, all reads'
    inputBinding:
      position: 102
      prefix: -b
  - id: output_statistics_path
    type:
      - 'null'
      - string
    doc: Output statistics to FILE.
    inputBinding:
      position: 102
      prefix: -y
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_mate_1
    type:
      - 'null'
      - File
    doc: Pair first mate output
    outputBinding:
      glob: $(inputs.output_mate_1_path)
  - id: output_mate_2
    type:
      - 'null'
      - File
    doc: Pair second mate output
    outputBinding:
      glob: $(inputs.output_mate_2_path)
  - id: output_interleaved_pairs
    type:
      - 'null'
      - File
    doc: Interleaved pairs-only output
    outputBinding:
      glob: $(inputs.output_interleaved_pairs_path)
  - id: output_unpaired
    type:
      - 'null'
      - File
    doc: Unpaired read output
    outputBinding:
      glob: $(inputs.output_unpaired_path)
  - id: output_strict_interleaved
    type:
      - 'null'
      - File
    doc: Strict interleaved output, all reads
    outputBinding:
      glob: $(inputs.output_strict_interleaved_path)
  - id: output_broken_paired
    type:
      - 'null'
      - File
    doc: Broken paired output, all reads
    outputBinding:
      glob: $(inputs.output_broken_paired_path)
  - id: output_statistics
    type:
      - 'null'
      - File
    doc: Statistics output
    outputBinding:
      glob: $(inputs.output_statistics_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqhax:0.8.6--h43eeafb_1
stdout: seqhax_pairs.out
