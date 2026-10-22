cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - suppa.py
  - diffSplice
label: suppa_diffSplice
doc: "Calculate differential splicing (delta PSI and significance) across conditions with replicates.\n\nTool homepage: https://github.com/comprna/SUPPA"
inputs:
  - id: method
    type: string
    doc: "Method to test significance: empirical or classical."
    inputBinding:
      position: 1
      prefix: --method
  - id: psi
    type:
      type: array
      items: File
    doc: "Path of the PSI files, one per condition (same order as the TPM files)."
    inputBinding:
      position: 1
      prefix: --psi
  - id: tpm
    type:
      type: array
      items: File
    doc: "Path of the transcript expression (TPM) files, one per condition (same order as the PSI files)."
    inputBinding:
      position: 1
      prefix: --tpm
  - id: input
    type: File
    doc: Input file with the event-transcripts equivalence (.ioe or .ioi format)
    inputBinding:
      position: 1
      prefix: --input
  - id: area
    type:
      - 'null'
      - int
    doc: Number of points in the local area distribution. (default 1000)
    inputBinding:
      position: 1
      prefix: --area
  - id: lower_bound
    type:
      - 'null'
      - float
    doc: Lower-bound for the absolute delta PSI value to test for significance. (default 0)
    inputBinding:
      position: 1
      prefix: --lower-bound
  - id: paired
    type:
      - 'null'
      - boolean
    doc: Indicates that replicates in conditions are paired.
    inputBinding:
      position: 1
      prefix: --paired
  - id: gene_correction
    type:
      - 'null'
      - boolean
    doc: Correct the p-values by gene.
    inputBinding:
      position: 1
      prefix: --gene-correction
  - id: alpha
    type:
      - 'null'
      - float
    doc: Family-wise error rate to use for the multiple test correction. (default 0.05)
    inputBinding:
      position: 1
      prefix: --alpha
  - id: save_tpm_events
    type:
      - 'null'
      - boolean
    doc: Save the average log TPM of the events in an external file.
    inputBinding:
      position: 1
      prefix: --save_tpm_events
  - id: combination
    type:
      - 'null'
      - boolean
    doc: Perform the analysis between all the possible combinations of conditions.
    inputBinding:
      position: 1
      prefix: --combination
  - id: median
    type:
      - 'null'
      - boolean
    doc: Use the median to calculate the Delta PSI.
    inputBinding:
      position: 1
      prefix: --median
  - id: tpm_threshold
    type:
      - 'null'
      - float
    doc: Minimum transcript average TPM value within-replicates and between-conditions to be included in the analysis. (default 1.0)
    inputBinding:
      position: 1
      prefix: --tpm-threshold
  - id: nan_threshold
    type:
      - 'null'
      - float
    doc: Proportion of allowed samples per condition with nan values for returning a DeltaPSI (default 0)
    inputBinding:
      position: 1
      prefix: --nan-threshold
  - id: output
    type: string
    doc: Name of the output files.
    inputBinding:
      position: 1
      prefix: --output
  - id: mode
    type:
      - 'null'
      - string
    doc: "to choose from DEBUG, INFO, WARNING, ERROR and CRITICAL"
    inputBinding:
      position: 1
      prefix: --mode
outputs:
  - id: diff_files
    type:
      type: array
      items: File
    doc: "Delta PSI (.dpsi), PSI vector (.psivec) and TPM event files"
    outputBinding:
      glob: $(inputs.output)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/suppa:2.4--pyhdfd78af_0
