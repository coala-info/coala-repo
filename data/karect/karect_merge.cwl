cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - karect
  - -merge
label: karect_merge
doc: "Concatenate, interlace, split or convert fasta/fastq files.\n\nTool homepage: https://github.com/aminallam/karect"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: inputfile
    type:
      type: array
      items: File
      inputBinding:
        prefix: -inputfile=
        separate: false
    doc: Input fasta/fastq file(s); each is passed with its own -inputfile.
    inputBinding:
      position: 1
  - id: mergedfile
    type: string
    doc: Output file.
    inputBinding:
      position: 1
      prefix: -mergedfile=
      separate: false
  - id: inputdir
    type:
      - 'null'
      - string
    doc: Files directory. Ignored if file paths are complete [Default=.].
    inputBinding:
      position: 1
      prefix: -inputdir=
      separate: false
  - id: paired
    type:
      - 'null'
      - boolean
    doc: Interlace two paired-end or mate-pairs files.
    inputBinding:
      position: 1
      prefix: -paired
  - id: sample
    type:
      - 'null'
      - int
    doc: Reserve only sample/1000 of reads [Default=1000].
    inputBinding:
      position: 1
      prefix: -sample=
      separate: false
  - id: oneseq
    type:
      - 'null'
      - boolean
    doc: Concatenate all sequences into one sequence (works with fasta only).
    inputBinding:
      position: 1
      prefix: -oneseq
  - id: noqualinfo
    type:
      - 'null'
      - boolean
    doc: Do not write fastq quality information line (write only +).
    inputBinding:
      position: 1
      prefix: -noqualinfo
  - id: unknownchar
    type:
      - 'null'
      - string
    doc: 'Character to put instead of unknown characters (known characters are ACGTacgt) [Default: do not change unknown characters].'
    inputBinding:
      position: 1
      prefix: -unknownchar=
      separate: false
  - id: outfasta
    type:
      - 'null'
      - boolean
    doc: 'Output fasta file [Default: same type as input].'
    inputBinding:
      position: 1
      prefix: -outfasta
  - id: outfastq
    type:
      - 'null'
      - boolean
    doc: 'Output fastq file [Default: same type as input].'
    inputBinding:
      position: 1
      prefix: -outfastq
  - id: outqual
    type:
      - 'null'
      - boolean
    doc: Output separate quality file.
    inputBinding:
      position: 1
      prefix: -outqual
  - id: adjustqual
    type:
      - 'null'
      - boolean
    doc: Do not allow "@" to exist as the first quality score for any read.
    inputBinding:
      position: 1
      prefix: -adjustqual
  - id: hshrec
    type:
      - 'null'
      - boolean
    doc: Concatenate HSHREC output files.
    inputBinding:
      position: 1
      prefix: -hshrec
  - id: quake
    type:
      - 'null'
      - boolean
    doc: Concatenate Quake output files.
    inputBinding:
      position: 1
      prefix: -quake
  - id: fastaqual
    type:
      - 'null'
      - boolean
    doc: Merge fasta and qual files into fastq.
    inputBinding:
      position: 1
      prefix: -fastaqual
  - id: replaceinfo
    type:
      - 'null'
      - boolean
    doc: Replace info lines of the second file using the ones of the first file.
    inputBinding:
      position: 1
      prefix: -replaceinfo
  - id: splitpaired
    type:
      - 'null'
      - boolean
    doc: 'Split into two files: fragment, paired.'
    inputBinding:
      position: 1
      prefix: -splitpaired
  - id: splitpairs
    type:
      - 'null'
      - boolean
    doc: 'Split interlaced pairs into two files: pair1, pair2.'
    inputBinding:
      position: 1
      prefix: -splitpairs
  - id: outpairids
    type:
      - 'null'
      - boolean
    doc: Output pair IDs file to be used by celera.
    inputBinding:
      position: 1
      prefix: -outpairids
outputs:
  - id: merged
    type:
      type: array
      items: File
    doc: Merged output file and any extra files written beside it (split 
      pairs, quality or pair-ID files).
    outputBinding:
      glob: $(inputs.mergedfile)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/karect:1.0--h9948957_9
