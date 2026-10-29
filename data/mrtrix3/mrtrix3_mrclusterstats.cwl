cwlVersion: v1.2
class: CommandLineTool
baseCommand: [mrclusterstats]
label: mrtrix3_mrclusterstats
doc: |-
  Voxel-based analysis using permutation testing and threshold-free cluster enhancement

  Tool homepage: https://www.mrtrix.org
requirements:
  - class: InitialWorkDirRequirement
    listing: [$(inputs.input), $(inputs.subject_images)]
inputs:
  - id: input
    type: File
    doc: a text file containing the file names of the input images, one file per line (names relative
      to the list file; the images are given in subject_images)
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: subject_images
    type:
      type: array
      items: File
    doc: 'Wrapper input: the images named in the list file, staged in the working directory next to it.'
  - id: design
    type: File
    doc: the design matrix
    inputBinding:
      position: 2
  - id: contrast
    type: File
    doc: the contrast matrix
    inputBinding:
      position: 3
  - id: mask
    type: File
    doc: a mask used to define voxels included in the analysis.
    inputBinding:
      position: 4
  - id: output
    type: string
    doc: the filename prefix for all output.
    inputBinding:
      position: 5
  - id: notest
    type: ['null', boolean]
    doc: don't perform statistical inference; only output population statistics (effect size, stdev etc)
    inputBinding:
      prefix: -notest
  - id: errors
    type: ['null', string]
    doc: 'specify nature of errors for shuffling; options are: ee,ise,both (default: ee) (choices: ee
      ise both)'
    inputBinding:
      prefix: -errors
  - id: exchange_within
    type: ['null', File]
    doc: specify blocks of observations within each of which data may undergo restricted exchange
    inputBinding:
      prefix: -exchange_within
  - id: exchange_whole
    type: ['null', File]
    doc: specify blocks of observations that may be exchanged with one another (for independent and symmetric
      errors, sign-flipping will occur block-wise)
    inputBinding:
      prefix: -exchange_whole
  - id: strong
    type: ['null', boolean]
    doc: use strong familywise error control across multiple hypotheses
    inputBinding:
      prefix: -strong
  - id: nshuffles
    type: ['null', int]
    doc: 'the number of shuffles (default: 5000)'
    inputBinding:
      prefix: -nshuffles
  - id: permutations
    type: ['null', File]
    doc: manually define the permutations (relabelling). The input should be a text file defining a m
      x n matrix, where each relabelling is defined as a column vector of size m, and the number of columns,
      n, defines the number of permutations. Can be generated with the palm_quickperms function in PALM
      (http://fsl.fmrib.ox.ac.uk/fsl/fslwiki/PALM). Overrides the -nshuffles option.
    inputBinding:
      prefix: -permutations
  - id: nonstationarity
    type: ['null', boolean]
    doc: perform empirical non-parametric non-stationarity correction
    inputBinding:
      prefix: -nonstationarity
  - id: skew_nonstationarity
    type: ['null', float]
    doc: specify the skew parameter for empirical statistic calculation (default for this command is 1)
    inputBinding:
      prefix: -skew_nonstationarity
  - id: nshuffles_nonstationarity
    type: ['null', int]
    doc: 'the number of shuffles to use when precomputing the empirical statistic image for non-stationarity
      correction (default: 5000)'
    inputBinding:
      prefix: -nshuffles_nonstationarity
  - id: permutations_nonstationarity
    type: ['null', File]
    doc: manually define the permutations (relabelling) for computing the emprical statistics for non-stationarity
      correction. The input should be a text file defining a m x n matrix, where each relabelling is defined
      as a column vector of size m, and the number of columns, n, defines the number of permutations.
      Can be generated with the palm_quickperms function in PALM (http://fsl.fmrib.ox.ac.uk/fsl/fslwiki/PALM)
      Overrides the -nshuffles_nonstationarity option.
    inputBinding:
      prefix: -permutations_nonstationarity
  - id: tfce_dh
    type: ['null', float]
    doc: 'the height increment used in the tfce integration (default: 0.1)'
    inputBinding:
      prefix: -tfce_dh
  - id: tfce_e
    type: ['null', float]
    doc: 'tfce extent exponent (default: 0.5)'
    inputBinding:
      prefix: -tfce_e
  - id: tfce_h
    type: ['null', float]
    doc: 'tfce height exponent (default: 2)'
    inputBinding:
      prefix: -tfce_h
  - id: variance
    type: ['null', File]
    doc: define variance groups for the G-statistic; measurements for which the expected variance is equivalent
      should contain the same index
    inputBinding:
      prefix: -variance
  - id: ftests
    type: ['null', File]
    doc: perform F-tests; input text file should contain, for each F-test, a row containing ones and zeros,
      where ones indicate the rows of the contrast matrix to be included in the F-test.
    inputBinding:
      prefix: -ftests
  - id: fonly
    type: ['null', boolean]
    doc: only assess F-tests; do not perform statistical inference on entries in the contrast matrix
    inputBinding:
      prefix: -fonly
  - id: column
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: -column
    doc: add a column to the design matrix corresponding to subject voxel-wise values (note that the contrast
      matrix must include an additional column for each use of this option); the text file provided via
      this option should contain a file name for each subject
  - id: threshold
    type: ['null', float]
    doc: the cluster-forming threshold to use for a standard cluster-based analysis. This disables TFCE,
      which is the default otherwise.
    inputBinding:
      prefix: -threshold
  - id: connectivity
    type: ['null', boolean]
    doc: 'use 26-voxel-neighbourhood connectivity (Default: 6)'
    inputBinding:
      prefix: -connectivity
  - id: info
    type: ['null', boolean]
    doc: display information messages.
    inputBinding:
      prefix: -info
  - id: quiet
    type: ['null', boolean]
    doc: do not display information messages or progress status; alternatively, this can be achieved by
      setting the MRTRIX_QUIET environment variable to a non-empty string.
    inputBinding:
      prefix: -quiet
  - id: debug
    type: ['null', boolean]
    doc: display debugging messages.
    inputBinding:
      prefix: -debug
  - id: force
    type: ['null', boolean]
    doc: 'force overwrite of output files (caution: using the same file as input and output might cause
      unexpected behaviour).'
    inputBinding:
      prefix: -force
  - id: nthreads
    type: ['null', int]
    doc: use this number of threads in multi-threaded applications (set to 0 to disable multi-threading).
    inputBinding:
      prefix: -nthreads
outputs:
  - id: result_files
    type:
      type: array
      items: File
    doc: All output images and text files written with the output prefix.
    outputBinding:
      glob: $(inputs.output)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
