cwlVersion: v1.2
class: CommandLineTool
baseCommand: vectorstats
label: mrtrix3_vectorstats
doc: "Statistical testing of vector data using non-parametric permutation testing\n\nTool homepage: https://www.mrtrix.org"
inputs:
  - id: subject_files
    type:
      type: array
      items: File
    doc: The data files named in the subject list text file; they are staged next to it so the names resolve.
  - id: input
    type: File
    doc: "a text file listing the file names of the input subject data"
    inputBinding:
      position: 1
  - id: design
    type: File
    doc: "the design matrix"
    inputBinding:
      position: 2
  - id: contrast
    type: File
    doc: "the contrast matrix"
    inputBinding:
      position: 3
  - id: output
    type: string
    doc: "the filename prefix for all output"
    inputBinding:
      position: 4
  - id: notest
    type: ['null', boolean]
    doc: "don't perform statistical inference; only output population statistics (effect size, stdev etc)"
    inputBinding:
      position: 10
      prefix: -notest
  - id: errors
    type: ['null', string]
    doc: "specify nature of errors for shuffling; options are: ee,ise,both (default: ee)"
    inputBinding:
      position: 10
      prefix: -errors
  - id: exchange_within
    type: ['null', File]
    doc: "specify blocks of observations within each of which data may undergo restricted exchange"
    inputBinding:
      position: 10
      prefix: -exchange_within
  - id: exchange_whole
    type: ['null', File]
    doc: "specify blocks of observations that may be exchanged with one another (for independent and symmetric errors, sign-flipping will occur block-wise)"
    inputBinding:
      position: 10
      prefix: -exchange_whole
  - id: strong
    type: ['null', boolean]
    doc: "use strong familywise error control across multiple hypotheses"
    inputBinding:
      position: 10
      prefix: -strong
  - id: nshuffles
    type: ['null', int]
    doc: "the number of shuffles (default: 5000)"
    inputBinding:
      position: 10
      prefix: -nshuffles
  - id: permutations
    type: ['null', File]
    doc: "manually define the permutations (relabelling). The input should be a text file defining a m x n matrix, where each relabelling is defined as a column vector of size m, and the number of columns, n, defines the number of permutations. Can be generated with the palm_quickperms function in PALM (http://fsl.fmrib.ox.ac.uk/fsl/fslwiki/PALM). Overrides the -nshuffles option."
    inputBinding:
      position: 10
      prefix: -permutations
  - id: variance
    type: ['null', File]
    doc: "define variance groups for the G-statistic; measurements for which the expected variance is equivalent should contain the same index"
    inputBinding:
      position: 10
      prefix: -variance
  - id: ftests
    type: ['null', File]
    doc: "perform F-tests; input text file should contain, for each F-test, a row containing ones and zeros, where ones indicate the rows of the contrast matrix to be included in the F-test."
    inputBinding:
      position: 10
      prefix: -ftests
  - id: fonly
    type: ['null', boolean]
    doc: "only assess F-tests; do not perform statistical inference on entries in the contrast matrix"
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
    doc: "add a column to the design matrix corresponding to subject element-wise values (note that the contrast matrix must include an additional column for each use of this option); the text file provided via this option should contain a file name for each subject"
    inputBinding:
      position: 10
  - id: info
    type: ['null', boolean]
    doc: "display information messages."
    inputBinding:
      position: 11
      prefix: -info
  - id: quiet
    type: ['null', boolean]
    doc: "do not display information messages or progress status; alternatively, this can be achieved by setting the MRTRIX_QUIET environment variable to a non-empty string."
    inputBinding:
      position: 11
      prefix: -quiet
  - id: debug
    type: ['null', boolean]
    doc: "display debugging messages."
    inputBinding:
      position: 11
      prefix: -debug
  - id: force
    type: ['null', boolean]
    doc: "force overwrite of output files (caution: using the same file as input and output might cause unexpected behaviour)."
    inputBinding:
      position: 11
      prefix: -force
  - id: nthreads
    type: ['null', int]
    doc: "use this number of threads in multi-threaded applications (set to 0 to disable multi-threading)."
    inputBinding:
      position: 11
      prefix: -nthreads
  - id: config
    type: ['null', {type: array, items: string}]
    doc: "temporarily set the value of an MRtrix config file entry. Provide the key and the value as two items."
    inputBinding:
      position: 11
      prefix: -config
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Output files whose names start with the given prefix.
    outputBinding:
      glob: $(inputs.output + "*")
requirements:
  - class: InitialWorkDirRequirement
    listing: |-
      ${return [inputs.input].concat(inputs.subject_files);}
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
