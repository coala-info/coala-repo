cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - retroseq.pl
  - -call
label: perl-retroseq_call
doc: "Calling stage of RetroSeq: takes the output of the discovery stage and a BAM and outputs a VCF of TE calls\n\nTool homepage: https://github.com/tk2/RetroSeq"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
inputs:
  - id: bam
    type: File
    secondaryFiles:
      - '.bai?'
    doc: "BAM file OR BAM fofn"
    inputBinding:
      position: 101
      prefix: -bam
  - id: input
    type: File
    doc: "Either a single output file from the PE discover stage OR a prefix of a set of files from discovery to be combined for calling OR a fofn of discovery stage output files"
    inputBinding:
      position: 101
      prefix: -input
  - id: ref
    type: File
    secondaryFiles:
      - '.fai'
    doc: "Fasta of reference genome"
    inputBinding:
      position: 101
      prefix: -ref
  - id: output
    type: string
    doc: "Output file name (VCF)"
    inputBinding:
      position: 101
      prefix: -output
  - id: filter
    type:
      - 'null'
      - File
    doc: "Tab file with TE type and BED file of reference elements; these will be filtered out from the calling"
    inputBinding:
      position: 101
      prefix: -filter
  - id: region
    type:
      - 'null'
      - string
    doc: "Call a particular chromosome only (chr) OR region (chr:start-end) only"
    inputBinding:
      position: 101
      prefix: -region
  - id: depth
    type:
      - 'null'
      - int
    doc: "Max average depth of a region to be considered for calling [200]"
    inputBinding:
      position: 101
      prefix: -depth
  - id: reads
    type:
      - 'null'
      - int
    doc: "Minimum number of reads required to make a call [5]"
    inputBinding:
      position: 101
      prefix: -reads
  - id: q
    type:
      - 'null'
      - int
    doc: "Minimum mapping quality for a read mate that anchors the insertion call [30]"
    inputBinding:
      position: 101
      prefix: -q
  - id: ignore_rgs
    type:
      - 'null'
      - string
    doc: "Single read group name OR a file of readgroups that should be ignored [none]"
    inputBinding:
      position: 101
      prefix: -ignoreRGs
  - id: soft
    type:
      - 'null'
      - boolean
    doc: "Include soft clipped reads when calling; highly recommended for BWA-MEM alignments"
    inputBinding:
      position: 101
      prefix: -soft
  - id: noclean
    type:
      - 'null'
      - boolean
    doc: "Do not remove intermediate output files"
    inputBinding:
      position: 101
      prefix: -noclean
  - id: staged_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files named inside the tab files or file lists given in the options (for example the BED files listed in refTEs); staged into the working directory"
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_out
    type:
      - 'null'
      - File
    doc: "VCF of TE calls"
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-retroseq:1.5--pl5321h7181c03_3
stdout: perl-retroseq_call.out
