cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - spectral_layout_from_minimap.py
label: spectrassembler_spectral_layout_from_minimap
doc: "Compute a spectral layout of long reads from minimap overlaps (PAF) and optionally write POA input files for consensus generation. Layout files cc<N>.layout and POA folders cc_<N> are written below the root folder, which must stay at its default ./ (a relative sub-folder makes the script fail).\n\nTool homepage: https://github.com/antrec/spectrassembler"
inputs:
  - id: root
    type:
      - 'null'
      - string
    default: ./
    doc: "directory where to store layout files (keep the default ./)"
    inputBinding:
      position: 11
      prefix: --root
  - id: fastafn
    type: File
    doc: "reads file path (fasta format)"
    inputBinding:
      position: 11
      prefix: --fastafn
  - id: minimapfn
    type: File
    doc: "overlap file path (from minimap in PAF format)."
    inputBinding:
      position: 11
      prefix: --minimapfn
  - id: write_poa_files
    type:
      - 'null'
      - boolean
    doc: "Whether to write POA input files for consensus generation or not."
    inputBinding:
      position: 11
      prefix: --write_poa_files
  - id: w_len
    type:
      - 'null'
      - int
    doc: "length of consensus windows for POA."
    inputBinding:
      position: 11
      prefix: --w_len
  - id: w_ovl_len
    type:
      - 'null'
      - int
    doc: "overlap length between two successive consensus windows."
    inputBinding:
      position: 11
      prefix: --w_ovl_len
  - id: sim_thr
    type:
      - 'null'
      - int
    doc: "threshold on overlap score (similarity matrix preprocessing.)"
    inputBinding:
      position: 11
      prefix: --sim_thr
  - id: len_thr
    type:
      - 'null'
      - int
    doc: "threshold on length of overlaps (similarity matrix preprocessing)."
    inputBinding:
      position: 11
      prefix: --len_thr
  - id: verbosity
    type:
      - 'null'
      - int
    doc: "verbosity level (1 for -v, 2 for -vv, none or 0 for quiet)"
    inputBinding:
      position: 11
      valueFrom: "$(self > 0 ? '-' + Array(self + 1).join('v') : [])"
  - id: ref_pos_csvf
    type:
      - 'null'
      - File
    doc: "csv file with position of reads (in same order as in fastafn) obtained from BWA, in order to plot reads position found vs reference."
    inputBinding:
      position: 11
      prefix: --ref_pos_csvf
outputs:
  - id: layout_files
    type:
      type: array
      items: File
    doc: Layout files, one per connected component (cc<N>.layout)
    outputBinding:
      glob: cc*.layout
  - id: poa_dirs
    type:
      type: array
      items: Directory
    doc: POA input folders cc_<N>, written with --write_poa_files
    outputBinding:
      glob: cc_*
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spectrassembler:0.0.1a1--py27_1
stdout: spectrassembler_spectral_layout_from_minimap.out
