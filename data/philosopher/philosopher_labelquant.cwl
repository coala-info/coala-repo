cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - philosopher
  - labelquant
label: philosopher_labelquant
doc: "Isobaric Labeling-Based Relative Quantification\n\nTool homepage: https://github.com/Nesvilab/philosopher"
inputs:
  - id: annotation_file
    type:
      - 'null'
      - File
    doc: "annotation file with custom names for the TMT channels"
    inputBinding:
      position: 100
      prefix: --annot
  - id: bestpsm
    type:
      - 'null'
      - boolean
    doc: "select the best PSMs for protein quantification"
    inputBinding:
      position: 100
      prefix: --bestpsm
  - id: brand
    type:
      - 'null'
      - string
    doc: "isobaric labeling brand (tmt, itraq, sCLIP)"
    inputBinding:
      position: 100
      prefix: --brand
  - id: input_dir
    type:
      - 'null'
      - Directory
    doc: "folder path containing the raw files"
    inputBinding:
      position: 100
      prefix: --dir
  - id: ion_purity_threshold
    type:
      - 'null'
      - float
    doc: "ion purity threshold"
    inputBinding:
      position: 100
      prefix: --purity
  - id: min_probability_score
    type:
      - 'null'
      - float
    doc: "only use PSMs with the specified minimum probability score"
    inputBinding:
      position: 100
      prefix: --minprob
  - id: ms_level
    type:
      - 'null'
      - int
    doc: "ms level for the quantification"
    inputBinding:
      position: 100
      prefix: --level
  - id: mz_tolerance_ppm
    type:
      - 'null'
      - float
    doc: "m/z tolerance in ppm"
    inputBinding:
      position: 100
      prefix: --tol
  - id: plex
    type:
      - 'null'
      - string
    doc: "number of reporter ion channels"
    inputBinding:
      position: 100
      prefix: --plex
  - id: read_raw
    type:
      - 'null'
      - boolean
    doc: "read raw files instead of converted XML"
    inputBinding:
      position: 100
      prefix: --raw
  - id: remove_low_psms
    type:
      - 'null'
      - float
    doc: "ignore the lower % of PSMs based on their summed abundances. 0 means no removal, entry value must be a decimal"
    inputBinding:
      position: 100
      prefix: --removelow
  - id: unique_peptides_only
    type:
      - 'null'
      - boolean
    doc: "report quantification based only on unique peptides"
    inputBinding:
      position: 100
      prefix: --uniqueonly
  - id: workspace
    type:
      - 'null'
      - Directory
    doc: "Philosopher workspace (the .meta folder written by an earlier step); it is staged writable as .meta in the working directory"
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: workspace_out
    type:
      - 'null'
      - Directory
    doc: "Philosopher workspace (.meta folder) after this step; pass it to the next step"
    outputBinding:
      glob: .meta
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: .meta
        entry: $(inputs.workspace)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/philosopher:5.1.2--he881be0_0
    dockerOutputDirectory: /work
stdout: philosopher_labelquant.out
