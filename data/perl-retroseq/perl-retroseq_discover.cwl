cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - retroseq.pl
  - -discover
label: perl-retroseq_discover
doc: "Discovery stage of RetroSeq: takes a BAM and a set of reference TEs and calls candidate supporting read pairs (BED output)\n\nTool homepage: https://github.com/tk2/RetroSeq"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
inputs:
  - id: bam
    type: File
    secondaryFiles:
      - '.bai'
    doc: "BAM file of paired reads mapped to reference genome"
    inputBinding:
      position: 101
      prefix: -bam
  - id: output
    type: string
    doc: "Output file to store candidate supporting reads (required for calling step)"
    inputBinding:
      position: 101
      prefix: -output
  - id: ref_tes
    type:
      - 'null'
      - File
    doc: "Tab file with TE type and BED file of reference elements; used to quickly assign discordant reads the TE types and avoid alignment"
    inputBinding:
      position: 101
      prefix: -refTEs
  - id: noclean
    type:
      - 'null'
      - boolean
    doc: "Do not remove intermediate output files"
    inputBinding:
      position: 101
      prefix: -noclean
  - id: q
    type:
      - 'null'
      - int
    doc: "Minimum mapping quality for a read mate that anchors the insertion call [20]"
    inputBinding:
      position: 101
      prefix: -q
  - id: id
    type:
      - 'null'
      - int
    doc: "Minimum percent ID for a match of a read to the transposon references [80]"
    inputBinding:
      position: 101
      prefix: -id
  - id: rgs
    type:
      - 'null'
      - string
    doc: "Comma separated list of readgroups to operate on [all]"
    inputBinding:
      position: 101
      prefix: -rgs
  - id: exd
    type:
      - 'null'
      - File
    doc: "Fofn of BED files of regions where discordant mates falling into will be excluded, for example simple repeats, centromeres, telomeres"
    inputBinding:
      position: 101
      prefix: -exd
  - id: align
    type:
      - 'null'
      - boolean
    doc: "Do the computationally expensive exonerate PE discordant mate alignment step"
    inputBinding:
      position: 101
      prefix: -align
  - id: eref
    type:
      - 'null'
      - File
    doc: "Tab file with list of transposon types and the corresponding fasta file of reference sequences; required when align is used"
    inputBinding:
      position: 101
      prefix: -eref
  - id: len
    type:
      - 'null'
      - int
    doc: "Minimum length of a hit to the transposon references when using the align option [36]"
    inputBinding:
      position: 101
      prefix: -len
  - id: overlap
    type:
      - 'null'
      - double
    doc: "Fraction of read alignment that must overlap with ref TE elements to be considered [0.8]"
    inputBinding:
      position: 101
      prefix: -overlap
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
    doc: "Candidate supporting reads in BED format"
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-retroseq:1.5--pl5321h7181c03_3
stdout: perl-retroseq_discover.out
