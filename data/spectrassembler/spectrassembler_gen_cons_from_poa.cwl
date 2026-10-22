cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gen_cons_from_poa.py
label: spectrassembler_gen_cons_from_poa
doc: "Generate a consensus sequence for one contig from the POA window files written by spectral_layout_from_minimap.py. The root folder is staged writable.\n\nTool homepage: https://github.com/antrec/spectrassembler"
inputs:
  - id: root
    type: Directory
    doc: "directory where to look for files (the one given to spectral_layout_from_minimap.py)"
    inputBinding:
      position: 11
      prefix: --root
      valueFrom: $(self.basename)
  - id: poa_path
    type:
      - 'null'
      - File
    doc: "path/to/poa/poa (path to the executable)"
    inputBinding:
      position: 11
      prefix: --poa_path
  - id: poa_mat_path
    type:
      - 'null'
      - File
    doc: "path/to/poa-score.mat"
    inputBinding:
      position: 11
      prefix: --poa_mat_path
  - id: contig
    type: string
    doc: "index of contig you wish to compute consensus for"
    inputBinding:
      position: 11
      prefix: --contig
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
  - id: verbosity
    type:
      - 'null'
      - int
    doc: "verbosity level (1 for -v, 2 for -vv, none or 0 for quiet)"
    inputBinding:
      position: 11
      valueFrom: "$(self > 0 ? '-' + Array(self + 1).join('v') : [])"
outputs:
  - id: consensus
    type:
      - 'null'
      - File
    doc: Consensus sequence of the contig
    outputBinding:
      glob: consensus_cc_*.fasta
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.root)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spectrassembler:0.0.1a1--py27_1
stdout: spectrassembler_gen_cons_from_poa.out
