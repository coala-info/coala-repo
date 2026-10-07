cwlVersion: v1.2
class: CommandLineTool
baseCommand: samsplit
label: cansam_samsplit
doc: "Split a SAM/BAM file into multiple files based on read group information.\n\n\
  Tool homepage: https://github.com/jmarshall/cansam"
inputs:
  - id: input_file
    type: File
    doc: Input SAM/BAM file
    inputBinding:
      position: 1
  - id: template
    type:
      - 'null'
      - string
    doc: 'Output file name template (default: "%*-%ID.%.", i.e. input basename, read
      group ID and sam/bam extension)'
    inputBinding:
      position: 2
  - id: compression_level
    type:
      - 'null'
      - int
    doc: Compress output files at level NUM (default for BAM; none for SAM)
    inputBinding:
      position: 103
      prefix: -z
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: Discard reads with mapping quality less than NUM
    inputBinding:
      position: 103
      prefix: -q
  - id: output_bam_format
    type:
      - 'null'
      - boolean
    doc: Write output files in BAM format
    inputBinding:
      position: 103
      prefix: -b
  - id: required_flags
    type:
      - 'null'
      - string
    doc: Emit only alignment records matching FLAGS
    inputBinding:
      position: 103
      prefix: -f
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: Write all selected records to FILE, in addition to splitting
    inputBinding:
      position: 104
      prefix: -o
outputs:
  - id: split_files
    type:
      type: array
      items: File
    doc: One SAM/BAM file per read group, named by the template
    outputBinding:
      glob:
        - '*.sam'
        - '*.bam'
      outputEval: |-
        ${
          return self.filter(function(f) {
            return f.basename !== inputs.output_file_path;
          });
        }
  - id: output_file
    type:
      - 'null'
      - File
    doc: Write all selected records to FILE, in addition to splitting
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cansam:21d64bb--h4ef8376_2
