cwlVersion: v1.2
class: CommandLineTool
baseCommand: famli
label: famli_filter
doc: "Filter a set of existing alignments in tabular format with FAMLI\n\nTool homepage:
  https://github.com/FredHutch/FAMLI"
inputs:
  - id: batchsize
    type:
      - 'null'
      - int
    doc: Number of reads to process at a time.
    inputBinding:
      position: 101
      prefix: --batchsize
  - id: bitscore_ix
    type:
      - 'null'
      - int
    doc: Alignment column for alignment bitscore. (0-indexed column ix)
    inputBinding:
      position: 101
      prefix: --bitscore-ix
  - id: input
    type:
      - 'null'
      - File
    doc: Location for input alignement file.
    inputBinding:
      position: 101
      prefix: --input
  - id: qseqid_ix
    type:
      - 'null'
      - int
    doc: Alignment column for query sequence ID. (0-indexed column ix)
    inputBinding:
      position: 101
      prefix: --qseqid-ix
  - id: sd_mean_cutoff
    type:
      - 'null'
      - float
    doc: Threshold for filtering max SD / MEAN
    inputBinding:
      position: 101
      prefix: --sd-mean-cutoff
  - id: send_ix
    type:
      - 'null'
      - int
    doc: Alignment column for subject end position. (0-indexed column ix, 
      1-indexed end position)
    inputBinding:
      position: 101
      prefix: --send-ix
  - id: slen_ix
    type:
      - 'null'
      - int
    doc: Alignment column for subject length. (0-indexed column ix)
    inputBinding:
      position: 101
      prefix: --slen-ix
  - id: sseqid_ix
    type:
      - 'null'
      - int
    doc: Alignment column for subject sequence ID. (0-indexed column ix)
    inputBinding:
      position: 101
      prefix: --sseqid-ix
  - id: sstart_ix
    type:
      - 'null'
      - int
    doc: Alignment column for subject start position. (0-indexed column ix, 
      1-indexed start position)
    inputBinding:
      position: 101
      prefix: --sstart-ix
  - id: strim_3
    type:
      - 'null'
      - int
    doc: Amount to trim from 3' end of subject
    inputBinding:
      position: 101
      prefix: --strim-3
  - id: strim_5
    type:
      - 'null'
      - int
    doc: Amount to trim from 5' end of subject
    inputBinding:
      position: 101
      prefix: --strim-5
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of processors to use.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Location for output JSON file.
    outputBinding:
      glob: $(inputs.output)
  - id: logfile
    type:
      - 'null'
      - File
    doc: (Optional) Write log to this file.
    outputBinding:
      glob: $(inputs.logfile)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/famli:v1.0_cv2
