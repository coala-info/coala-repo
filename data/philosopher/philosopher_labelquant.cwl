cwlVersion: v1.2
class: CommandLineTool
baseCommand: philosopher labelquant
label: philosopher_labelquant
doc: "Quantify isobaric labeling experiments.\n\nTool homepage: https://github.com/Nesvilab/philosopher"
inputs:
  - id: annotation_file
    type:
      - 'null'
      - string
    doc: annotation file with custom names for the TMT channels
    inputBinding:
      position: 101
      prefix: --annot
  - id: bestpsm
    type:
      - 'null'
      - boolean
    doc: select the best PSMs for protein quantification
    inputBinding:
      position: 101
      prefix: --bestpsm
  - id: brand
    type:
      - 'null'
      - string
    doc: isobaric labeling brand (tmt, itraq, sCLIP)
    inputBinding:
      position: 101
      prefix: --brand
  - id: input_dir
    type:
      - 'null'
      - Directory
    doc: folder path containing the raw files
    inputBinding:
      position: 101
      prefix: --dir
  - id: ion_purity_threshold
    type:
      - 'null'
      - float
    doc: ion purity threshold
    inputBinding:
      position: 101
      prefix: --purity
  - id: min_probability_score
    type:
      - 'null'
      - float
    doc: only use PSMs with the specified minimum probability score
    inputBinding:
      position: 101
      prefix: --minprob
  - id: ms_level
    type:
      - 'null'
      - int
    doc: ms level for the quantification
    inputBinding:
      position: 101
      prefix: --level
  - id: mz_tolerance_ppm
    type:
      - 'null'
      - float
    doc: m/z tolerance in ppm
    inputBinding:
      position: 101
      prefix: --tol
  - id: plex
    type:
      - 'null'
      - string
    doc: number of reporter ion channels
    inputBinding:
      position: 101
      prefix: --plex
  - id: read_raw
    type:
      - 'null'
      - boolean
    doc: read raw files instead of converted XML
    inputBinding:
      position: 101
      prefix: --raw
  - id: remove_low_psms
    type:
      - 'null'
      - float
    doc: ignore the lower % of PSMs based on their summed abundances. 0 means no
      removal, entry value must be a decimal
    inputBinding:
      position: 101
      prefix: --removelow
  - id: unique_peptides_only
    type:
      - 'null'
      - boolean
    doc: report quantification based only on unique peptides
    inputBinding:
      position: 101
      prefix: --uniqueonly
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/philosopher:5.1.2--he881be0_0
stdout: philosopher_labelquant.out
