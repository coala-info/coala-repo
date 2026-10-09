cwlVersion: v1.2
class: CommandLineTool
baseCommand: readCounter
label: hmmcopy_readCounter
doc: "Count the reads of a BAM file in non-overlapping windows and write the counts in WIG (or SEG) format to standard output.\n\nTool homepage: http://compbio.bccrc.ca/software/hmmcopy/"
inputs:
  - id: bam_file
    type: File
    doc: "BAM file (index required unless build is set)"
    inputBinding:
      position: 2
  - id: seg
    type:
      - 'null'
      - boolean
    doc: "Outputs in SEG format"
    inputBinding:
      position: 1
      prefix: --seg
  - id: quality
    type:
      - 'null'
      - int
    doc: "Specify the mapping quality value below which reads are ignored"
    inputBinding:
      position: 1
      prefix: --quality
  - id: window
    type:
      - 'null'
      - int
    doc: "Specify the size of non-overlapping windows [1000]"
    inputBinding:
      position: 1
      prefix: --window
  - id: list
    type:
      - 'null'
      - boolean
    doc: "List all chromosomes in the input file"
    inputBinding:
      position: 1
      prefix: --list
  - id: chromosome
    type:
      - 'null'
      - string
    doc: "Specify the entries and order of sequences to analyze [ALL], a comma-delimited list (no spaces)"
    inputBinding:
      position: 1
      prefix: --chromosome
  - id: build
    type:
      - 'null'
      - boolean
    doc: "Build BAM index for file (same index format as SAMtools)"
    inputBinding:
      position: 1
      prefix: --build
outputs:
  - id: read_wig
    type: stdout
    doc: Read counts per window (WIG, or SEG with --seg)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.bam_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmmcopy:0.1.1--h5b0a936_12
stdout: hmmcopy_readCounter.wig
