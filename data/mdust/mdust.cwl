cwlVersion: v1.2
class: CommandLineTool
baseCommand: mdust
label: mdust
doc: "Masks low-complexity DNA sequences in FASTA format.\n\nTool homepage: https://github.com/lh3/mdust"
inputs:
  - id: fasta_file
    type:
      - 'null'
      - File
    doc: Input FASTA file. If not provided, a multi-fasta stream is expected at 
      stdin.
    inputBinding:
      position: 1
  - id: cut_off
    type:
      - 'null'
      - int
    doc: Cut-off value for masking. Lower values mask more, but might still be 
      useful sequence. Values > 64 will rarely mask poly-triplets.
    inputBinding:
      position: 102
      prefix: -v
  - id: masking_letter_type
    type:
      - 'null'
      - string
    doc: Type of masking letter to use if FASTA output is not disabled by -c. 
      Options are N (default), X, or L (make lowercase).
    inputBinding:
      position: 102
      prefix: -m
  - id: output_coordinates_only
    type:
      - 'null'
      - boolean
    doc: Output masking coordinates only (seq_name, seqlength, mask_start, 
      mask_end) in tab-delimited format.
    inputBinding:
      position: 102
      prefix: -c
  - id: wsize
    type:
      - 'null'
      - int
    doc: Maximum word size to consider for masking.
    inputBinding:
      position: 102
      prefix: -w
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mdust:2006.10.17--h7b50bb2_7
stdout: mdust.out
