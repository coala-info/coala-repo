cwlVersion: v1.2
class: CommandLineTool
baseCommand: fithic
label: fithic
doc: "Calculate statistical significance of Hi-C interactions\n\nTool homepage: https://github.com/ay-lab/fithic/tree/master"
inputs:
  - id: bias_lower_bound
    type:
      - 'null'
      - float
    doc: 'OPTIONAL: this flag is used to determine the lower bound of bias values
      to discard. DEFAULT is 0.5'
    inputBinding:
      position: 101
      prefix: --biasLowerBound
  - id: bias_upper_bound
    type:
      - 'null'
      - float
    doc: 'OPTIONAL: this flag is used to determine the upper bound of bias values
      to discard. DEFAULT is 2'
    inputBinding:
      position: 101
      prefix: --biasUpperBound
  - id: biases
    type:
      - 'null'
      - File
    doc: 'RECOMMENDED: biases calculated by ICE or KR norm for each locus are read
      from BIASFILE'
    inputBinding:
      position: 101
      prefix: --biases
  - id: contact_type
    type:
      - 'null'
      - string
    doc: 'OPTIONAL: use this flag to determine which chromosomal regions to study
      (intraOnly, interOnly, All) DEFAULT is intraOnly'
    inputBinding:
      position: 101
      prefix: --contactType
  - id: fragments
    type: File
    doc: 'REQUIRED: midpoints (or start indices) of the fragments are read from FRAGSFILE'
    inputBinding:
      position: 101
      prefix: --fragments
  - id: interactions
    type: File
    doc: 'REQUIRED: interactions between fragment pairs are read from INTERSFILE'
    inputBinding:
      position: 101
      prefix: --interactions
  - id: lib
    type:
      - 'null'
      - string
    doc: 'OPTIONAL: Name of the library that is analyzed to be used for name of file
      prefixes . DEFAULT is fithic'
    inputBinding:
      position: 101
      prefix: --lib
  - id: lowerbound
    type:
      - 'null'
      - int
    doc: 'OPTIONAL: lower bound on the intra-chromosomal distance range (unit: base
      pairs). DEFAULT no limit. Suggested limit is 2x the resolution of the input
      files'
    inputBinding:
      position: 101
      prefix: --lowerbound
  - id: mappability_thres
    type:
      - 'null'
      - int
    doc: 'OPTIONAL: minimum number of hits per locus that has to exist to call it
      mappable. DEFAULT is 1.'
    inputBinding:
      position: 101
      prefix: --mappabilityThres
  - id: no_of_bins
    type:
      - 'null'
      - int
    doc: 'OPTIONAL: number of equal-occupancy (count) bins. Default is 100'
    inputBinding:
      position: 101
      prefix: --noOfBins
  - id: passes
    type:
      - 'null'
      - int
    doc: 'OPTIONAL: number of spline passes to run Default is 1'
    inputBinding:
      position: 101
      prefix: --passes
  - id: resolution
    type: int
    doc: 'REQUIRED: If the files are fixed size, please supply the resolution of the
      dataset here; otherwise, please use a value of 0 if the data is not fixed size.'
    inputBinding:
      position: 101
      prefix: --resolution
  - id: upperbound
    type:
      - 'null'
      - int
    doc: "OPTIONAL: upper bound on the intra-chromosomal distance range (unit: base
      pairs). DEFAULT no limit. STRONGLY suggested to have a limit for large genomes,
      such as human/mouse. ex. '1000000, 5000000, etc.'"
    inputBinding:
      position: 101
      prefix: --upperbound
  - id: visual
    type:
      - 'null'
      - boolean
    doc: 'OPTIONAL: use this flag for generating plots. DEFAULT is False.'
    inputBinding:
      position: 101
      prefix: --visual
outputs:
  - id: outdir
    type: Directory
    doc: 'REQUIRED: where the output files will be written'
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fithic:2.0.8--pyhdfd78af_1
