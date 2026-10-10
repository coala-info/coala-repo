cwlVersion: v1.2
class: CommandLineTool
baseCommand: fixelcfestats
label: mrtrix3_fixelcfestats
doc: "Fixel-based analysis using connectivity-based fixel enhancement and non-parametric
  permutation testing.\n\nTool homepage: https://www.mrtrix.org"
inputs:
  - id: in_fixel_directory
    type: Directory
    doc: 'The fixel directory containing the data files for each subject (after obtaining fixel correspondence).'
    inputBinding:
      position: 1
  - id: subjects
    type: File
    doc: 'A text file listing the subject identifiers (one per line); they correspond to the file names in the fixel directory, in the order of the rows of the design matrix.'
    inputBinding:
      position: 2
  - id: design
    type: File
    doc: 'The design matrix.'
    inputBinding:
      position: 3
  - id: contrast
    type: File
    doc: 'The contrast matrix, specified as rows of weights.'
    inputBinding:
      position: 4
  - id: connectivity
    type: Directory
    doc: 'The fixel-fixel connectivity matrix directory (made with fixelconnectivity).'
    inputBinding:
      position: 5
  - id: out_fixel_directory
    type: string
    doc: 'The output directory where results will be saved. Will be created if it does not exist.'
    inputBinding:
      position: 6
  - id: mask
    type: ['null', File]
    doc: 'Provide a fixel data file containing a mask of those fixels to be used during processing.'
    inputBinding:
      position: 10
      prefix: -mask
  - id: notest
    type: ['null', boolean]
    doc: 'Do not perform statistical inference; only output population statistics (effect size, stdev etc).'
    inputBinding:
      position: 10
      prefix: -notest
  - id: errors
    type: ['null', string]
    doc: 'Specify nature of errors for shuffling; options are: ee,ise,both (default: ee).'
    inputBinding:
      position: 10
      prefix: -errors
  - id: exchange_within
    type: ['null', File]
    doc: 'Specify blocks of observations within each of which data may undergo restricted exchange.'
    inputBinding:
      position: 10
      prefix: -exchange_within
  - id: exchange_whole
    type: ['null', File]
    doc: 'Specify blocks of observations that may be exchanged with one another (for independent and symmetric errors, sign-flipping will occur block-wise).'
    inputBinding:
      position: 10
      prefix: -exchange_whole
  - id: strong
    type: ['null', boolean]
    doc: 'Use strong familywise error control across multiple hypotheses.'
    inputBinding:
      position: 10
      prefix: -strong
  - id: nshuffles
    type: ['null', int]
    doc: 'The number of shuffles (default: 5000).'
    inputBinding:
      position: 10
      prefix: -nshuffles
  - id: permutations
    type: ['null', File]
    doc: 'Manually define the permutations (relabelling) as a text file defining a m x n matrix. Overrides the -nshuffles option.'
    inputBinding:
      position: 10
      prefix: -permutations
  - id: nonstationarity
    type: ['null', boolean]
    doc: 'Perform empirical non-parametric non-stationarity correction.'
    inputBinding:
      position: 10
      prefix: -nonstationarity
  - id: skew_nonstationarity
    type: ['null', float]
    doc: 'Specify the skew parameter for empirical statistic calculation (default for this command is 1).'
    inputBinding:
      position: 10
      prefix: -skew_nonstationarity
  - id: nshuffles_nonstationarity
    type: ['null', int]
    doc: 'The number of shuffles to use when precomputing the empirical statistic image for non-stationarity correction (default: 5000).'
    inputBinding:
      position: 10
      prefix: -nshuffles_nonstationarity
  - id: permutations_nonstationarity
    type: ['null', File]
    doc: 'Manually define the permutations (relabelling) for computing the empirical statistics for non-stationarity correction. Overrides the -nshuffles_nonstationarity option.'
    inputBinding:
      position: 10
      prefix: -permutations_nonstationarity
  - id: cfe_dh
    type: ['null', float]
    doc: 'The height increment used in the cfe integration (default: 0.1).'
    inputBinding:
      position: 10
      prefix: -cfe_dh
  - id: cfe_e
    type: ['null', float]
    doc: 'The cfe extent exponent (default: 2).'
    inputBinding:
      position: 10
      prefix: -cfe_e
  - id: cfe_h
    type: ['null', float]
    doc: 'The cfe height exponent (default: 3).'
    inputBinding:
      position: 10
      prefix: -cfe_h
  - id: cfe_c
    type: ['null', float]
    doc: 'The cfe connectivity exponent (default: 0.5).'
    inputBinding:
      position: 10
      prefix: -cfe_c
  - id: cfe_legacy
    type: ['null', boolean]
    doc: 'Use the legacy (non-normalised) form of the cfe equation.'
    inputBinding:
      position: 10
      prefix: -cfe_legacy
  - id: variance
    type: ['null', File]
    doc: 'Define variance groups for the G-statistic; measurements for which the expected variance is equivalent should contain the same index.'
    inputBinding:
      position: 10
      prefix: -variance
  - id: ftests
    type: ['null', File]
    doc: 'Perform F-tests; the input text file should contain, for each F-test, a row containing ones and zeros, where ones indicate the rows of the contrast matrix to be included in the F-test.'
    inputBinding:
      position: 10
      prefix: -ftests
  - id: fonly
    type: ['null', boolean]
    doc: 'Only assess F-tests; do not perform statistical inference on entries in the contrast matrix.'
    inputBinding:
      position: 10
      prefix: -fonly
  - id: column
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: -column
    doc: Add a column to the design matrix corresponding to subject fixel-wise values (the contrast matrix must include an additional column for each use); the text file lists a file name for each subject (multiple uses permitted).
    inputBinding:
      position: 10
  - id: info
    type: ['null', boolean]
    doc: 'Display information messages.'
    inputBinding:
      position: 11
      prefix: -info
  - id: quiet
    type: ['null', boolean]
    doc: 'Do not display information messages or progress status.'
    inputBinding:
      position: 11
      prefix: -quiet
  - id: debug
    type: ['null', boolean]
    doc: 'Display debugging messages.'
    inputBinding:
      position: 11
      prefix: -debug
  - id: force
    type: ['null', boolean]
    doc: 'Force overwrite of output files (caution: using the same file as input and output might cause unexpected behaviour).'
    inputBinding:
      position: 11
      prefix: -force
  - id: nthreads
    type: ['null', int]
    doc: 'Use this number of threads in multi-threaded applications (set to 0 to disable multi-threading).'
    inputBinding:
      position: 11
      prefix: -nthreads
outputs:
  - id: output_directory
    type: Directory
    doc: The output fixel directory with the statistics images.
    outputBinding:
      glob: $(inputs.out_fixel_directory)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
