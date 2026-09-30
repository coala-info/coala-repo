cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqhax
  - pair
label: seqhax_pairs
doc: "Process and split paired-end sequence files in FASTA or FASTQ format.\n\nTool
  homepage: https://github.com/kdmurray91/seqhax"
inputs:
  - id: input_file
    type: File
    doc: Input sequence file in FASTA or FASTQ format
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
    doc: Force output to existing files
    inputBinding:
      position: 103
      prefix: -f
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum length of each read
    inputBinding:
      position: 103
      prefix: -l
  - id: output_broken_paired_path
    type:
      - 'null'
      - string
    doc: '"Broken paired" output, all reads'
    inputBinding:
      position: 104
      prefix: -b
  - id: output_interleaved_pairs_path
    type:
      - 'null'
      - string
    doc: Interleaved pairs-only output
    inputBinding:
      position: 105
      prefix: -p
  - id: output_mate_1_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_mate_1_path`
    inputBinding:
      position: 106
      prefix: --output-mate-1
  - id: output_mate_2_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_mate_2_path`
    inputBinding:
      position: 107
      prefix: --output-mate-2
  - id: output_statistics_path
    type:
      - 'null'
      - string
    doc: Output statistics to FILE.
    inputBinding:
      position: 108
      prefix: -y
  - id: output_strict_interleaved_path
    type:
      - 'null'
      - string
    doc: '"Strict interleaved" output, all reads'
    inputBinding:
      position: 109
      prefix: -s
  - id: output_unpaired_path
    type:
      - 'null'
      - string
    doc: Unpaired read output
    inputBinding:
      position: 110
      prefix: -u
outputs:
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
    doc: Output statistics to FILE
    outputBinding:
      glob: $(inputs.output_statistics_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqhax:0.8.6--h43eeafb_1
