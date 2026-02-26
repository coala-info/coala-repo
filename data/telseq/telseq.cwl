cwlVersion: v1.2
class: CommandLineTool
baseCommand: telseq
label: telseq
doc: "Scan BAM and estimate telomere length.\n\nTool homepage: https://github.com/zd1/telseq"
inputs:
  - id: input_bams
    type:
      type: array
      items: File
    doc: one or more BAM files to be analysed. File names can also be passed 
      from a pipe, with each row containing one BAM path.
    inputBinding:
      position: 1
  - id: bamlist
    type:
      - 'null'
      - File
    doc: a file that contains a list of file paths of BAMs. It should has only 
      one column, with each row a BAM file path. -f has higher priority than 
      <in.bam>. When specified, <in.bam> are ignored.
    inputBinding:
      position: 102
      prefix: --bamlist
  - id: exome_bed
    type:
      - 'null'
      - File
    doc: specifiy exome regions in BED format. These regions will be excluded
    inputBinding:
      position: 102
      prefix: --exomebed
  - id: ignore_read_groups
    type:
      - 'null'
      - boolean
    doc: ignore read groups. Treat all reads in BAM as if they were from a same 
      read group.
    inputBinding:
      position: 102
      prefix: -u
  - id: merge_read_groups
    type:
      - 'null'
      - boolean
    doc: merge read groups by taking a weighted average across read groups of a 
      sample, weighted by the total number of reads in read group. Default is to
      output each readgroup separately.
    inputBinding:
      position: 102
      prefix: -m
  - id: print_header_only
    type:
      - 'null'
      - boolean
    doc: print the header line only. The text can be used to attach to result 
      files, useful when the headers of the result files are suppressed.
    inputBinding:
      position: 102
      prefix: -h
  - id: read_length
    type:
      - 'null'
      - int
    doc: read length. default = 100
    default: 100
    inputBinding:
      position: 102
      prefix: -r
  - id: remove_header
    type:
      - 'null'
      - boolean
    doc: remove header line, which is printed by default.
    inputBinding:
      position: 102
      prefix: -H
  - id: telomeric_repeat_threshold
    type:
      - 'null'
      - int
    doc: threshold of the amount of TTAGGG/CCCTAA repeats in read for a read to 
      be considered telomeric. default = 7.
    default: 7
    inputBinding:
      position: 102
      prefix: -k
  - id: treat_bamlist_as_single
    type:
      - 'null'
      - boolean
    doc: consider BAMs in the speicfied bamlist as one single BAM. This is 
      useful when the initial alignemt is separated for some reason, such as one
      for mapped and one for ummapped reads.
    inputBinding:
      position: 102
      prefix: -w
  - id: use_custom_pattern
    type:
      - 'null'
      - boolean
    doc: use user specified pattern for searching [ATGC]*.
    inputBinding:
      position: 102
      prefix: -z
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: output file for results. Ignored when input is from stdin, in which 
      case output will be stdout.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/telseq:0.0.2--h06902ac_8
