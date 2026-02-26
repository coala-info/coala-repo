cwlVersion: v1.2
class: CommandLineTool
baseCommand: jaccard_dit_wrapper.py
label: vgorient_jaccard_dit_wrapper.py
doc: "Run kmer_jaccard.py and VG_diterative.py\n\nTool homepage: https://github.com/whelixw/vgOrient"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input file paths for kmer_jaccard.py
    inputBinding:
      position: 1
  - id: append_wm
    type:
      - 'null'
      - boolean
    doc: Append w and m values to the output directory name.
    inputBinding:
      position: 102
      prefix: --append_wm
  - id: band_width
    type:
      - 'null'
      - int
    doc: Band width for VG mapping.
    inputBinding:
      position: 102
      prefix: --band_width
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: kmer size for computing jaccard similarity
    inputBinding:
      position: 102
      prefix: --kmer_size
  - id: log
    type:
      - 'null'
      - File
    doc: Log file name for recording execution details and timings.
    inputBinding:
      position: 102
      prefix: --log
  - id: min_jaccard_init
    type:
      - 'null'
      - boolean
    doc: Order sequences by lowest sum of j-dist
    inputBinding:
      position: 102
      prefix: --min_jaccard_init
  - id: min_match_length
    type:
      - 'null'
      - int
    doc: Minimum match length for VG mapping.
    inputBinding:
      position: 102
      prefix: --min_match_length
  - id: orientation
    type:
      - 'null'
      - boolean
    doc: Reorient inputs in kmer_jaccard.py
    inputBinding:
      position: 102
      prefix: --orientation
  - id: vg_orient
    type:
      - 'null'
      - boolean
    doc: use vg to orient nodes
    inputBinding:
      position: 102
      prefix: --vg_orient
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file name for kmer_jaccard.py
    outputBinding:
      glob: $(inputs.output)
  - id: vg_output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory for VG_diterative.py
    outputBinding:
      glob: $(inputs.vg_output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vgorient:0.1.1--pyhdfd78af_0
