cwlVersion: v1.2
class: CommandLineTool
baseCommand: [xhmm]
label: xhmm_mergegatkdepths
doc: "Merge the output from GATK into a single read depth matrix of samples (rows) by targets (columns)\n\nTool homepage: http://atgu.mgh.harvard.edu/xhmm/index.shtml"
inputs:
  - id: gatk_depths
    type: ['null', {type: array, items: File, inputBinding: {prefix: --GATKdepths}}]
    doc: "GATK sample_interval_summary output file(s) to be merged [must have IDENTICAL target lists]"
    inputBinding:
      position: 10
  - id: gatk_depths_list
    type: ['null', File]
    doc: "A file containing a list of GATK sample_interval_summary output files to be merged [must have IDENTICAL target lists]; the files it names must also be given in gatk_depths so that they are staged in the working directory under their own names"
    inputBinding:
      position: 10
      prefix: --GATKdepthsList
  - id: sample_id_map
    type: ['null', File]
    doc: "File containing mappings of sample names to new sample names (in columns designated by fromID, toID)"
    inputBinding:
      position: 10
      prefix: --sampleIDmap
  - id: from_id
    type: ['null', int]
    doc: "Column number of OLD sample IDs to map (default 1)"
    inputBinding:
      position: 10
      prefix: --fromID
  - id: to_id
    type: ['null', int]
    doc: "Column number of NEW sample IDs to map (default 2)"
    inputBinding:
      position: 10
      prefix: --toID
  - id: column_suffix
    type: ['null', string]
    doc: "Suffix of columns to be used for merging [where columns are in the form: SAMPLE + columnSuffix] (default _mean_cvg)"
    inputBinding:
      position: 10
      prefix: --columnSuffix
  - id: rd_precision
    type: ['null', int]
    doc: "Decimal precision of read depths output (default 2)"
    inputBinding:
      position: 10
      prefix: --rdPrecision
  - id: output_targets_by_samples
    type: ['null', boolean]
    doc: "Output targets x samples (instead of samples x targets)"
    inputBinding:
      position: 10
      prefix: --outputTargetsBySamples
  - id: output_matrix
    type: string
    default: merged_depths.RD.txt
    doc: "Read-depth matrix output file"
    inputBinding:
      position: 10
      prefix: --outputMatrix
outputs:
  - id: output_matrix_file
    type: ['null', File]
    doc: "Merged read-depth matrix"
    outputBinding:
      glob: $(inputs.output_matrix)
  - id: stdout
    type: stdout
    doc: Standard output
arguments:
  - position: 1
    valueFrom: --mergeGATKdepths
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.gatk_depths)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xhmm:0.0.0.2016_01_04.cc14e52--hedee03e_3
stdout: xhmm_mergegatkdepths.out
