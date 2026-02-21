cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pepsirf
  - info
label: pepsirf_info
doc: "This module is used to gather information about a score matrix. By default,
  the number of samples and peptides in the matrix will be output. Additional flags
  may be provided to extract different types of information. Each of these flags should
  be accompanied by an output file name, to which the information be written.\n\n
  Tool homepage: https://github.com/LadnerLab/PepSIRF"
inputs:
  - id: input
    type:
      - 'null'
      - File
    doc: An input score matrix to gather information from.
    inputBinding:
      position: 101
      prefix: --input
  - id: rep_names
    type:
      - 'null'
      - File
    doc: An input file that the sample names of replicates can be found. The first
      element of each row contains the name of a base sample, and every other element
      in a row contains the name of a sample based off the base sample. This file
      is required to run -a, --get_avgs.
    inputBinding:
      position: 101
      prefix: --rep_names
outputs:
  - id: get_samples
    type:
      - 'null'
      - File
    doc: Name of a file to which sample names (i.e., column headers) should be written.
      Output will be in the form of a file with no header, one sample name per line.
    outputBinding:
      glob: $(inputs.get_samples)
  - id: get_probes
    type:
      - 'null'
      - File
    doc: Name of a file to which peptide/probe names (i.e., row names) should be written.
      Output will be in the form of a file with no header, one peptide/probe name
      per line.
    outputBinding:
      glob: $(inputs.get_probes)
  - id: col_sums
    type:
      - 'null'
      - File
    doc: Name of a file to which the sum of column scores should be written. Output
      will be a tab-delimited file with a header. The first entry in each column will
      be the name of the sample, and the second will be the sum of the peptide/probe
      scores for the sample.
    outputBinding:
      glob: $(inputs.col_sums)
  - id: get_avgs
    type:
      - 'null'
      - File
    doc: Name of a file to which the average of different replicate values should
      be written. Output will be a tab-delimted file with sample names as the column
      headers and peptide names as row names. Each entry consists of the average of
      the replicate values for the given sample and peptide.
    outputBinding:
      glob: $(inputs.get_avgs)
  - id: logfile
    type:
      - 'null'
      - File
    doc: Designated file to which the module's processes are logged. By default, the
      logfile's name will include the module's name and the time the module started
      running.
    outputBinding:
      glob: $(inputs.logfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pepsirf:1.7.1--h077b44d_0
