cwlVersion: v1.2
class: CommandLineTool
baseCommand: FasTAN
label: fastan_FasTAN
doc: "FasTAN: find tandem repeats in a genome sequence and write them as a 1-code
  alignment (.1aln) file.\n\nTool homepage: https://github.com/thegenemyers/FASTAN"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: source_path
    type: File
    doc: Source sequence file, <fa_extn> = (.fa|.fna|.fasta)[.gz], or any valid
      1-code sequence file type.
    inputBinding:
      position: 1
  - id: target
    type: string
    doc: Name of the target file; the result is written to <target>.1aln.
    inputBinding:
      position: 2
  - id: compute_models
    type:
      - 'null'
      - boolean
    doc: Compute models of each hit (not yet implemented).
    inputBinding:
      position: 103
      prefix: -m
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 103
      prefix: -T
      separate: false
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode, output statistics as proceed.
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: alignment_1aln
    type: File
    doc: Tandem repeat alignments in 1-code format.
    outputBinding:
      glob: $(inputs.target.replace(/\.1aln$/, '') + '.1aln')
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastan:0.5--h577a1d6_0
stdout: fastan_FasTAN.out
