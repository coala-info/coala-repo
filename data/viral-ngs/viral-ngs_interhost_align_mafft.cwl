cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - interhost.py
  - align_mafft
label: viral-ngs_interhost_align_mafft
doc: "Run the mafft alignment on the input FASTA file.\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: in_fastas
    type:
      type: array
      items: File
    doc: "Input FASTA files."
    inputBinding:
      position: 1
  - id: out_file
    type: string
    doc: "Output file containing alignment result (default format: FASTA)"
    inputBinding:
      position: 2
  - id: localpair
    type:
      - 'null'
      - boolean
    doc: "All pairwise alignments are computed with the Smith-Waterman algorithm."
    inputBinding:
      position: 20
      prefix: --localpair
  - id: globalpair
    type:
      - 'null'
      - boolean
    doc: "All pairwise alignments are computed with the Needleman-Wunsch algorithm."
    inputBinding:
      position: 20
      prefix: --globalpair
  - id: preservecase
    type:
      - 'null'
      - boolean
    doc: "Preserve base or aa case, as well as symbols."
    inputBinding:
      position: 20
      prefix: --preservecase
  - id: reorder
    type:
      - 'null'
      - boolean
    doc: "Output is ordered aligned rather than in the order of the input (default: None)."
    inputBinding:
      position: 20
      prefix: --reorder
  - id: gap_opening_penalty
    type:
      - 'null'
      - float
    doc: "Gap opening penalty (default: 1.53)."
    inputBinding:
      position: 20
      prefix: --gapOpeningPenalty
  - id: ep
    type:
      - 'null'
      - float
    doc: "Offset (works like gap extension penalty)."
    inputBinding:
      position: 20
      prefix: --ep
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Full output (default: False)."
    inputBinding:
      position: 20
      prefix: --verbose
  - id: output_as_clustal
    type:
      - 'null'
      - boolean
    doc: "Write output file in Clustal format rather than FASTA"
    inputBinding:
      position: 20
      prefix: --outputAsClustal
  - id: maxiters
    type:
      - 'null'
      - int
    doc: "Maximum number of refinement iterations (default: 0). Note: if --localpair or --globalpair is specified this defaults to 1000."
    inputBinding:
      position: 20
      prefix: --maxiters
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of processing threads (default: -1, where -1 indicates use of all available cores)."
    inputBinding:
      position: 20
      prefix: --threads
  - id: loglevel
    type:
      - 'null'
      - type: enum
        symbols:
          - DEBUG
          - INFO
          - WARNING
          - ERROR
          - CRITICAL
          - EXCEPTION
    doc: "Verboseness of output. [default: DEBUG]"
    inputBinding:
      position: 20
      prefix: --loglevel
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: "Base directory for temp files. [default: /tmp]"
    inputBinding:
      position: 21
      prefix: --tmp_dir
  - id: tmp_dir_keep
    type:
      - 'null'
      - boolean
    doc: "Keep the tmp_dir if an exception occurs while running. Default is to delete all temp files at the end, even if there's a failure."
    inputBinding:
      position: 21
      prefix: --tmp_dirKeep
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: out_alignment
    type: File
    doc: "Alignment"
    outputBinding:
      glob: $(inputs.out_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
stdout: viral-ngs_interhost_align_mafft.out
