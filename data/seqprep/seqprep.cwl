cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqprep
label: seqprep
doc: "SeqPrep is a program to merge paired end reads and strip adapters. It looks
  for an adapter sequence and/or an overlap between the two reads of a pair and uses
  this information to merge the reads or strip the adapter. The output is always gzip
  compressed.\n\nTool homepage: https://github.com/jstjohn/SeqPrep"
inputs:
  - id: forward_fastq
    type: File
    doc: First read input fastq filename
    inputBinding:
      position: 1
      prefix: '-f'
  - id: reverse_fastq
    type: File
    doc: Second read input fastq filename
    inputBinding:
      position: 2
      prefix: '-r'
  - id: forward_output_path
    type: string
    doc: First read output fastq filename
    inputBinding:
      position: 3
      prefix: '-1'
  - id: reverse_output_path
    type: string
    doc: Second read output fastq filename
    inputBinding:
      position: 4
      prefix: '-2'
  - id: forward_discarded_path
    type:
      - 'null'
      - string
    doc: First read discarded fastq filename
    inputBinding:
      position: 5
      prefix: '-3'
  - id: reverse_discarded_path
    type:
      - 'null'
      - string
    doc: Second read discarded fastq filename
    inputBinding:
      position: 6
      prefix: '-4'
  - id: merged_output_path
    type:
      - 'null'
      - string
    doc: Perform merging and output the merged reads to this file
    inputBinding:
      position: 7
      prefix: '-s'
  - id: alignments_path
    type:
      - 'null'
      - string
    doc: Write pretty alignments to this file for visual examination
    inputBinding:
      position: 8
      prefix: '-E'
  - id: spinner
    type:
      - 'null'
      - boolean
    doc: Display the spinner
    inputBinding:
      position: 9
      prefix: '-S'
  - id: phred64
    type:
      - 'null'
      - boolean
    doc: Input sequence is in phred+64 rather than phred+33 format, the output will still be phred+33
    inputBinding:
      position: 9
      prefix: '-6'
  - id: quality_cutoff
    type:
      - 'null'
      - int
    doc: Quality score cutoff for mismatches to be counted in overlap; default = 13
    inputBinding:
      position: 9
      prefix: '-q'
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum length of a trimmed or merged read to print it; default = 30
    inputBinding:
      position: 9
      prefix: '-L'
  - id: forward_adapter
    type:
      - 'null'
      - string
    doc: Forward read primer/adapter sequence to trim as it would appear at the end of a read; default = AGATCGGAAGAGCACACGTC
    inputBinding:
      position: 9
      prefix: '-A'
  - id: reverse_adapter
    type:
      - 'null'
      - string
    doc: Reverse read primer/adapter sequence to trim as it would appear at the end of a read; default = AGATCGGAAGAGCGTCGTGT
    inputBinding:
      position: 9
      prefix: '-B'
  - id: adapter_min_overlap
    type:
      - 'null'
      - int
    doc: Minimum overall base pair overlap with adapter sequence to trim; default = 10
    inputBinding:
      position: 9
      prefix: '-O'
  - id: adapter_max_mismatch
    type:
      - 'null'
      - float
    doc: Maximum fraction of good quality mismatching bases for primer/adapter overlap; default = 0.02
    inputBinding:
      position: 9
      prefix: '-M'
  - id: adapter_min_match
    type:
      - 'null'
      - float
    doc: Minimum fraction of matching bases for primer/adapter overlap; default = 0.87
    inputBinding:
      position: 9
      prefix: '-N'
  - id: adapter_band_width
    type:
      - 'null'
      - int
    doc: Adapter alignment band-width; default = 50
    inputBinding:
      position: 9
      prefix: '-b'
  - id: adapter_gap_open
    type:
      - 'null'
      - int
    doc: Adapter alignment gap-open; default = 8
    inputBinding:
      position: 9
      prefix: '-Q'
  - id: adapter_gap_extension
    type:
      - 'null'
      - int
    doc: Adapter alignment gap-extension; default = 2
    inputBinding:
      position: 9
      prefix: '-t'
  - id: adapter_gap_end
    type:
      - 'null'
      - int
    doc: Adapter alignment gap-end; default = 2
    inputBinding:
      position: 9
      prefix: '-e'
  - id: adapter_min_score
    type:
      - 'null'
      - int
    doc: Adapter alignment minimum local alignment score cutoff; default = 26
    inputBinding:
      position: 9
      prefix: '-Z'
  - id: read_band_width
    type:
      - 'null'
      - int
    doc: Read alignment band-width; default = 50
    inputBinding:
      position: 9
      prefix: '-w'
  - id: read_gap_open
    type:
      - 'null'
      - int
    doc: Read alignment gap-open; default = 26
    inputBinding:
      position: 9
      prefix: '-W'
  - id: read_gap_extension
    type:
      - 'null'
      - int
    doc: Read alignment gap-extension; default = 9
    inputBinding:
      position: 9
      prefix: '-p'
  - id: read_gap_end
    type:
      - 'null'
      - int
    doc: Read alignment gap-end; default = 5
    inputBinding:
      position: 9
      prefix: '-P'
  - id: read_max_gap_fraction
    type:
      - 'null'
      - float
    doc: Read alignment maximum fraction gap cutoff; default = 0.125
    inputBinding:
      position: 9
      prefix: '-X'
  - id: use_mask
    type:
      - 'null'
      - boolean
    doc: Use mask; N will replace adapters
    inputBinding:
      position: 9
      prefix: '-z'
  - id: max_quality
    type:
      - 'null'
      - string
    doc: Maximum quality score in output (phred 33); default = ']'
    inputBinding:
      position: 9
      prefix: '-y'
  - id: print_overhang
    type:
      - 'null'
      - boolean
    doc: Print overhang when adapters are present and stripped (unimplemented in the tool)
    inputBinding:
      position: 9
      prefix: '-g'
  - id: max_alignments
    type:
      - 'null'
      - int
    doc: Maximum number of pretty alignments to write (if -E provided); default = 10000
    inputBinding:
      position: 9
      prefix: '-x'
  - id: merge_min_overlap
    type:
      - 'null'
      - int
    doc: Minimum overall base pair overlap to merge two reads; default = 15
    inputBinding:
      position: 9
      prefix: '-o'
  - id: merge_max_mismatch
    type:
      - 'null'
      - float
    doc: Maximum fraction of good quality mismatching bases to overlap reads; default = 0.02
    inputBinding:
      position: 9
      prefix: '-m'
  - id: merge_min_match
    type:
      - 'null'
      - float
    doc: Minimum fraction of matching bases to overlap reads; default = 0.9
    inputBinding:
      position: 9
      prefix: '-n'
outputs:
  - id: forward_output
    type: File
    doc: First read output (gzip fastq)
    outputBinding:
      glob: $(inputs.forward_output_path)
  - id: reverse_output
    type: File
    doc: Second read output (gzip fastq)
    outputBinding:
      glob: $(inputs.reverse_output_path)
  - id: forward_discarded
    type:
      - 'null'
      - File
    doc: First read discarded reads
    outputBinding:
      glob: $(inputs.forward_discarded_path)
  - id: reverse_discarded
    type:
      - 'null'
      - File
    doc: Second read discarded reads
    outputBinding:
      glob: $(inputs.reverse_discarded_path)
  - id: merged_output
    type:
      - 'null'
      - File
    doc: Merged reads (gzip fastq)
    outputBinding:
      glob: $(inputs.merged_output_path)
  - id: alignments
    type:
      - 'null'
      - File
    doc: Pretty alignments of merged pairs
    outputBinding:
      glob: $(inputs.alignments_path)
  - id: stderr_log
    type: stderr
    doc: Run summary printed by SeqPrep
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/seqprep:v1.3.2-3-deb_cv1
stderr: seqprep.log
