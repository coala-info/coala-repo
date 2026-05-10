cwlVersion: v1.2
class: CommandLineTool
baseCommand: muscle
label: muscle
doc: "Align FASTA input, write aligned FASTA (AFA) output\n\nTool homepage: https://github.com/rcedgar/muscle"
inputs:
  - id: addconfseq
    type:
      - 'null'
      - File
    doc: Ensemble EFA file to update by adding column confidence sequences
    inputBinding:
      position: 101
      prefix: -addconfseq
  - id: align
    type:
      - 'null'
      - File
    doc: Input FASTA file for alignment
    inputBinding:
      position: 101
      prefix: -align
  - id: disperse
    type:
      - 'null'
      - File
    doc: Ensemble EFA file to calculate dispersion from
    inputBinding:
      position: 101
      prefix: -disperse
  - id: diversified
    type:
      - 'null'
      - boolean
    doc: Generate diversified ensemble alignment
    inputBinding:
      position: 101
      prefix: -diversified
  - id: efa_explode
    type:
      - 'null'
      - File
    doc: Ensemble EFA file to extract aligned FASTA files from
    inputBinding:
      position: 101
      prefix: -efa_explode
  - id: fa2efa
    type:
      - 'null'
      - File
    doc: Text file with one FASTA filename per line to convert to EFA
    inputBinding:
      position: 101
      prefix: -fa2efa
  - id: letterconf
    type:
      - 'null'
      - File
    doc: Ensemble EFA file to calculate letter confidence (LC) values from
    inputBinding:
      position: 101
      prefix: -letterconf
  - id: maxcc
    type:
      - 'null'
      - File
    doc: Ensemble EFA file to extract replicate with highest total CC from
    inputBinding:
      position: 101
      prefix: -maxcc
  - id: maxgapfract
    type:
      - 'null'
      - float
    doc: Maximum fraction of gaps in a column
    inputBinding:
      position: 101
      prefix: -maxgapfract
  - id: minconf
    type:
      - 'null'
      - float
    doc: Minimum column confidence
    inputBinding:
      position: 101
      prefix: -minconf
  - id: perm
    type:
      - 'null'
      - string
    doc: 'Guide tree permutation: none, abc, acb, bca'
    inputBinding:
      position: 101
      prefix: -perm
  - id: perturb
    type:
      - 'null'
      - int
    doc: Perturbation seed
    inputBinding:
      position: 101
      prefix: -perturb
  - id: ref
    type:
      - 'null'
      - File
    doc: Reference alignment file for letter confidence calculation
    inputBinding:
      position: 101
      prefix: -ref
  - id: replicates
    type:
      - 'null'
      - int
    doc: Number of replicates
    inputBinding:
      position: 101
      prefix: -replicates
  - id: resample
    type:
      - 'null'
      - File
    doc: Ensemble EFA file to resample from
    inputBinding:
      position: 101
      prefix: -resample
  - id: stratified
    type:
      - 'null'
      - boolean
    doc: Generate stratified ensemble alignment
    inputBinding:
      position: 101
      prefix: -stratified
  - id: super5
    type:
      - 'null'
      - File
    doc: Input FASTA file for large input alignment using Super5 algorithm
    inputBinding:
      position: 101
      prefix: -super5
  - id: html_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `html_path`
    inputBinding:
      position: 102
      prefix: --html
  - id: jalview_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `jalview_path`
    inputBinding:
      position: 103
      prefix: --jalview
  - id: output_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 104
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output aligned FASTA (AFA) or Ensemble FASTA (EFA) file
    outputBinding:
      glob: $(inputs.output_path)
  - id: html
    type:
      - 'null'
      - File
    doc: Output alignment colored by LC in HTML format
    outputBinding:
      glob: $(inputs.html_path)
  - id: jalview
    type:
      - 'null'
      - File
    doc: Output Jalview feature file with LC values and colors
    outputBinding:
      glob: $(inputs.jalview_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/muscle:5.3--h9948957_3
