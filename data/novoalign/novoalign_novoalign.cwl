cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - novoalign
label: novoalign_novoalign
doc: "Novoalign short read aligner (V4). Usage: novoalign -d db.ndx -f read1.fq
  [read2.fq] -o SAM > out.sam. Needs a valid Novocraft licence (even for --help); the
  options below are the documented core options from the Novoalign manual.\n\nTool
  homepage: http://www.novocraft.com/products/novoalign/"
inputs:
  - id: database
    type: File
    doc: Novoindex reference index file built by novoindex.
    inputBinding:
      position: 1
      prefix: -d
  - id: reads
    type:
      type: array
      items: File
    doc: Read file(s). Two files for paired end reads.
    inputBinding:
      position: 2
      prefix: -f
  - id: output_format
    type:
      - 'null'
      - string
    doc: Output report format, for example SAM or SAM "@RG\tID:x\tSM:y".
    default: SAM
    inputBinding:
      position: 3
      prefix: -o
  - id: read_format
    type:
      - 'null'
      - string
    doc: Read file format, for example STDFQ, ILMFQ, ILM1.8, SLXFQ, FA or BAM.
    inputBinding:
      position: 4
      prefix: -F
  - id: repeat_mode
    type:
      - 'null'
      - string
    doc: Repeat reporting mode, for example None, Random, All, Exhaustive or
      Ambiguous.
    inputBinding:
      position: 5
      prefix: -r
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 6
      prefix: -c
  - id: threshold
    type:
      - 'null'
      - int
    doc: Alignment score threshold.
    inputBinding:
      position: 7
      prefix: -t
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum number of good (high quality) bases for a read to be aligned.
    inputBinding:
      position: 8
      prefix: -l
  - id: trim_homopolymer
    type:
      - 'null'
      - boolean
    doc: Hard trim 3' end of reads to the first low quality base (-H).
    inputBinding:
      position: 9
      prefix: -H
  - id: truncate_length
    type:
      - 'null'
      - int
    doc: Truncate reads to this length.
    inputBinding:
      position: 10
      prefix: -n
  - id: insert_size
    type:
      - 'null'
      - string
    doc: Paired end fragment length distribution as "mean,std_dev", for example
      "250,30".
    inputBinding:
      position: 11
      prefix: -i
  - id: adapter
    type:
      - 'null'
      - string
    doc: Adapter sequence(s) to strip from the 3' end of reads.
    inputBinding:
      position: 12
      prefix: -a
outputs:
  - id: alignments
    type: stdout
    doc: Alignments in SAM format written to standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/novoalign:4.03.04--h43eeafb_3
stdout: novoalign_novoalign.sam
