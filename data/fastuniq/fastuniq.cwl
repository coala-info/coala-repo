cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastuniq
label: fastuniq
doc: "FastUniq is a tool to identify and remove duplicated read pairs from paired
  FASTQ files (de novo, without a reference). Reads in the same order in two adjacent
  files belong to a pair. The tool builds the list file (-i) from the input files.\n\nTool
  homepage: https://sourceforge.net/projects/fastuniq/"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: fastuniq_input_list.txt
        entry: |-
          ${
            var lines = [];
            for (var i = 0; i < inputs.fastq_files.length; i++) {
              lines.push(inputs.fastq_files[i].basename);
            }
            return lines.join("\n") + "\n";
          }
      - $(inputs.fastq_files)
inputs:
  - id: fastq_files
    type: 'File[]'
    doc: Paired FASTQ files in plain text, listed in pairs (read 1 file, read 2 file,
      then the next pair). Maximum 1000 pairs. Their names are written, one per line,
      into the input list file given to -i.
  - id: output_format
    type: ['null', string]
    doc: 'Output sequence format: q (FASTQ into two output files), f (FASTA into two
      output files) or p (FASTA into one output file). Default q.'
    inputBinding:
      position: 2
      prefix: -t
  - id: output_1_path
    type: string
    doc: The first output file
    inputBinding:
      position: 3
      prefix: -o
  - id: output_2_path
    type: ['null', string]
    doc: The second output file. Required when the output format is q or f.
    inputBinding:
      position: 4
      prefix: -p
  - id: description_type
    type: ['null', int]
    doc: 'Types of sequence descriptions for output: 0 keeps the raw descriptions,
      1 assigns new serial numbers (default 0).'
    inputBinding:
      position: 5
      prefix: -c
arguments:
  - position: 1
    prefix: -i
    valueFrom: fastuniq_input_list.txt
outputs:
  - id: output_1
    type: File
    doc: First output file (read 1 without duplicated pairs, or all reads for format p)
    outputBinding:
      glob: $(inputs.output_1_path)
  - id: output_2
    type: ['null', File]
    doc: Second output file (read 2 without duplicated pairs)
    outputBinding:
      glob: $(inputs.output_2_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastuniq:1.1--h7b50bb2_2
