cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - novobarcode
label: novoalign_novobarcode
doc: "Demultiplex barcoded reads into one read file per bar code tag.\n\nTool
  homepage: http://www.novocraft.com/products/novoalign/"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.demux_dir)
        entry: '$({"class": "Directory", "basename": inputs.demux_dir, "listing": []})'
        writable: true
inputs:
  - id: tagfile
    type: File
    doc: The bar code tag file.
    inputBinding:
      position: 1
      prefix: -b
  - id: demux_dir
    type: string
    doc: Folder name for demultiplexed reads.
    default: demux
    inputBinding:
      position: 2
      prefix: -d
  - id: reads
    type:
      type: array
      items: File
    doc: Read file(s). Two files if paired end.
    inputBinding:
      position: 3
      prefix: -f
  - id: index_reads
    type:
      - 'null'
      - File
    doc: The qseq format file for the index tag reads.
    inputBinding:
      position: 4
      prefix: -i
  - id: read_format
    type:
      - 'null'
      - string
    doc: Read file format, for example ILMFQ, ILM1.8 or SLXFQ.
    inputBinding:
      position: 5
      prefix: -F
  - id: ilq_use
    type:
      - 'null'
      - boolean
    doc: Ignore the QC flag and classify the reads.
    inputBinding:
      position: 6
      prefix: --ILQ_USE
  - id: ilq_skip
    type:
      - 'null'
      - boolean
    doc: Write reads flagged as low quality to the NC folder.
    inputBinding:
      position: 7
      prefix: --ILQ_SKIP
  - id: ilq_qc
    type:
      - 'null'
      - boolean
    doc: Same as --ILQ_SKIP.
    inputBinding:
      position: 8
      prefix: --ILQ_QC
  - id: qseq_out
    type:
      - 'null'
      - boolean
    doc: Write qseq format output files if the input is qseq.
    inputBinding:
      position: 9
      prefix: --QSEQ_OUT
  - id: barcode_read_length
    type:
      - 'null'
      - int
    doc: Bar code read length if different from the tag length.
    inputBinding:
      position: 10
      prefix: -l
  - id: min_score_difference
    type:
      - 'null'
      - int
    doc: Minimum tag alignment score difference between the best tag and the
      next best tag. Otherwise reads go to the catch all file.
    inputBinding:
      position: 11
      prefix: -t
  - id: adapter
    type:
      - 'null'
      - string
    doc: 3' adapter sequence to strip before checking for a 3' index tag.
    inputBinding:
      position: 12
      prefix: -a
outputs:
  - id: demux_folder
    type: Directory
    doc: Folder with the demultiplexed reads
    outputBinding:
      glob: $(inputs.demux_dir)
  - id: log
    type: stderr
    doc: Run log written to standard error
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/novoalign:4.03.04--h43eeafb_3
stderr: novoalign_novobarcode.log
