cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sickle
  - pe
label: sickle_pe
doc: "Paired-end sequence trimming: windowed adaptive trimming of FASTQ files using
  quality. Use separate forward and reverse files, or one interleaved file.\n\nTool
  homepage: https://github.com/najoshi/sickle"
inputs:
  - id: pe_file1
    type:
      - 'null'
      - File
    doc: Input paired-end forward fastq file (input files must have same number of
      records)
    inputBinding:
      position: 1
      prefix: -f
  - id: pe_file2
    type:
      - 'null'
      - File
    doc: Input paired-end reverse fastq file
    inputBinding:
      position: 1
      prefix: -r
  - id: output_pe1
    type:
      - 'null'
      - string
    doc: Output trimmed forward fastq file
    inputBinding:
      position: 1
      prefix: -o
  - id: output_pe2
    type:
      - 'null'
      - string
    doc: Output trimmed reverse fastq file. Must use output_single.
    inputBinding:
      position: 1
      prefix: -p
  - id: pe_combo
    type:
      - 'null'
      - File
    doc: Combined (interleaved) input paired-end fastq
    inputBinding:
      position: 1
      prefix: -c
  - id: output_combo
    type:
      - 'null'
      - string
    doc: Output combined (interleaved) paired-end fastq file. Must use
      output_single.
    inputBinding:
      position: 1
      prefix: -m
  - id: output_combo_all
    type:
      - 'null'
      - string
    doc: Output combined (interleaved) paired-end fastq file with any discarded
      read written to output file as a single N. Cannot be used with
      output_single.
    inputBinding:
      position: 1
      prefix: -M
  - id: qual_type
    type: string
    doc: Type of quality values (solexa (CASAVA < 1.3), illumina (CASAVA 1.3 to
      1.7), sanger (which is CASAVA >= 1.8))
    inputBinding:
      position: 2
      prefix: -t
  - id: output_single
    type:
      - 'null'
      - string
    doc: Output trimmed singles fastq file
    inputBinding:
      position: 2
      prefix: -s
  - id: qual_threshold
    type:
      - 'null'
      - int
    doc: Threshold for trimming based on average quality in a window. Default 20.
    inputBinding:
      position: 3
      prefix: -q
  - id: length_threshold
    type:
      - 'null'
      - int
    doc: Threshold to keep a read based on length after trimming. Default 20.
    inputBinding:
      position: 3
      prefix: -l
  - id: no_fiveprime
    type:
      - 'null'
      - boolean
    doc: Don't do five prime trimming.
    inputBinding:
      position: 3
      prefix: -x
  - id: truncate_n
    type:
      - 'null'
      - boolean
    doc: Truncate sequences at position of first N.
    inputBinding:
      position: 3
      prefix: -n
  - id: gzip_output
    type:
      - 'null'
      - boolean
    doc: Output gzipped files.
    inputBinding:
      position: 3
      prefix: -g
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not output trimming info
    inputBinding:
      position: 3
      prefix: --quiet
outputs:
  - id: trimmed_pe1
    type:
      - 'null'
      - File
    doc: Output trimmed forward fastq file
    outputBinding:
      glob: $(inputs.output_pe1)
  - id: trimmed_pe2
    type:
      - 'null'
      - File
    doc: Output trimmed reverse fastq file
    outputBinding:
      glob: $(inputs.output_pe2)
  - id: trimmed_combo
    type:
      - 'null'
      - File
    doc: Output combined (interleaved) paired-end fastq file
    outputBinding:
      glob: $(inputs.output_combo)
  - id: trimmed_combo_all
    type:
      - 'null'
      - File
    doc: Output combined (interleaved) fastq file with discarded reads as N
    outputBinding:
      glob: $(inputs.output_combo_all)
  - id: trimmed_single
    type:
      - 'null'
      - File
    doc: Output trimmed singles fastq file
    outputBinding:
      glob: $(inputs.output_single)
  - id: stdout
    type: stdout
    doc: Trimming summary
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sickle:v1.33-1b1-deb_cv1
stdout: sickle_pe.out
