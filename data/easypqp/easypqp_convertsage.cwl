cwlVersion: v1.2
class: CommandLineTool
baseCommand: easypqp_convertsage
label: easypqp_convertsage
doc: "Convert Sage Search results for EasyPQP\n\nTool homepage: https://github.com/grosenberger/easypqp"
inputs:
  - id: max_delta_unimod
    type:
      - 'null'
      - float
    doc: Maximum delta mass (Dalton) for UniMod annotation.
    default: 0.02
    inputBinding:
      position: 101
      prefix: --max_delta_unimod
  - id: precision_digits
    type:
      - 'null'
      - int
    doc: Precision (number of digits) for the product m/z reported by the 
      theoretical library generation step. This should match the precision of 
      the downstream consumer of the spectral library. Lowering this number will
      collapse (more) identical fragment ions of the same precursor to a single 
      value.
    default: 6
    inputBinding:
      position: 101
      prefix: --precision_digits
  - id: sage_fragments
    type: File
    doc: Path to Sage matched_fragments.sage.tsv/parquet.
    inputBinding:
      position: 101
      prefix: --sage_fragments
  - id: sage_psm
    type: File
    doc: Path to Sage results.sage.tsv/parquet.
    inputBinding:
      position: 101
      prefix: --sage_psm
  - id: streaming
    type:
      - 'null'
      - boolean
    doc: Force streaming conversion (process runs one-by-one). If omitted, 
      auto-detect by input size.
    inputBinding:
      position: 101
      prefix: --streaming
  - id: streaming_threshold_bytes
    type:
      - 'null'
      - int
    doc: 'Auto-switch to streaming when combined input size (bytes) >= this threshold.
      Default: 2GB.'
    default: 2000000000
    inputBinding:
      position: 101
      prefix: --streaming-threshold-bytes
  - id: unimod
    type:
      - 'null'
      - File
    doc: UniMod XML (used to map numeric deltas to UniMod IDs).
    inputBinding:
      position: 101
      prefix: --unimod
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/easypqp:0.1.56--pyhdfd78af_0
stdout: easypqp_convertsage.out
