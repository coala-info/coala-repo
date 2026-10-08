cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - transit
  - GI
label: transit_gi
doc: "Genetic interaction analysis: compares insertion counts of two strains in two conditions (4 groups of datasets).\n\nTool homepage: http://github.com/mad-lab/transit"
inputs:
  - id: strain_a_cond1_files
    type: File[]
    doc: "Comma-separated .wig files for strain A, condition 1"
    inputBinding:
      position: 1
      itemSeparator: ','
  - id: strain_a_cond2_files
    type: File[]
    doc: "Comma-separated .wig files for strain A, condition 2"
    inputBinding:
      position: 2
      itemSeparator: ','
  - id: strain_b_cond1_files
    type: File[]
    doc: "Comma-separated .wig files for strain B, condition 1"
    inputBinding:
      position: 3
      itemSeparator: ','
  - id: strain_b_cond2_files
    type: File[]
    doc: "Comma-separated .wig files for strain B, condition 2"
    inputBinding:
      position: 4
      itemSeparator: ','
  - id: annotation_file
    type: File
    doc: "Annotation .prot_table or GFF3 file"
    inputBinding:
      position: 5
  - id: output_filename
    type: string
    doc: "Output file name"
    inputBinding:
      position: 6
  - id: num_samples
    type: ['null', int]
    doc: "Number of samples. Default: 10000"
    inputBinding:
      position: 20
      prefix: -s
  - id: rope
    type: ['null', float]
    doc: "Region of Practical Equivalence. Area around 0 (i.e. 0 +/- ROPE) that is NOT of interest. Default: 0.5"
    inputBinding:
      position: 20
      prefix: --rope
  - id: normalization_method
    type: ['null', string]
    doc: "Normalization method. Default: TTR"
    inputBinding:
      position: 20
      prefix: -n
  - id: include_zero_rows
    type: ['null', boolean]
    doc: "Include rows with zero across conditions."
    inputBinding:
      position: 20
      prefix: -iz
  - id: loess_correction
    type: ['null', boolean]
    doc: "Perform LOESS Correction; Helps remove possible genomic position bias. Default: Turned Off."
    inputBinding:
      position: 20
      prefix: -l
  - id: ignore_n_terminus_percentage
    type: ['null', float]
    doc: "Ignore TAs occuring at given percentage (as integer) of the N terminus. Default: 0"
    inputBinding:
      position: 20
      prefix: -iN
  - id: ignore_c_terminus_percentage
    type: ['null', float]
    doc: "Ignore TAs occuring at given percentage (as integer) of the C terminus. Default: 0"
    inputBinding:
      position: 20
      prefix: -iC
  - id: signif
    type: ['null', string]
    doc: "Significance method: HDI (default), prob, BFDR or FWER."
    inputBinding:
      position: 20
      prefix: -signif
outputs:
  - id: output_file
    type: File
    doc: "Output file"
    outputBinding:
      glob: $(inputs.output_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
