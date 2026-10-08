cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- straingst
- run
label: strainge_straingst_run
doc: 'StrainGST: strain genome search tool. Identify close reference genomes to strains present in a sample.


  Tool homepage: https://github.com/broadinstitute/strainge'
inputs:
- id: pan
  type: File
  doc: HDF5 file containing pan-genome kmer set (database).
  inputBinding:
    position: 100
- id: sample
  type: File
  doc: Search for strains in this sample
  inputBinding:
    position: 101
- id: output
  type:
  - 'null'
  - string
  doc: 'Output text file (default: standard out), or output filename prefix if enabling --separate-output.'
  inputBinding:
    position: 1
    prefix: --output
- id: separate_output
  type:
  - 'null'
  - boolean
  doc: Separate sample and strain metrics in different files, such that they can be easily read with Pandas or R.
  inputBinding:
    position: 1
    prefix: --separate-output
- id: debug_out
  type:
  - 'null'
  - string
  doc: Output a debug HDF5 file containing the remaining sample k-mers per iteration. Optional.
  inputBinding:
    position: 1
    prefix: --debug-out
- id: iterations
  type:
  - 'null'
  - int
  doc: 'max strains to look for (default: 5)'
  inputBinding:
    position: 1
    prefix: --iterations
- id: top
  type:
  - 'null'
  - int
  doc: 'How many best matches to print per iteration (default: 1)'
  inputBinding:
    position: 1
    prefix: --top
- id: fulldb
  type:
  - 'null'
  - boolean
  doc: Using full pan-genome kmer database rather than pan- genome fingerprint kmer db
  inputBinding:
    position: 1
    prefix: --fulldb
- id: minfrac
  type:
  - 'null'
  - float
  doc: 'Minimum fraction of original kmers in strain (default: 0.01)'
  inputBinding:
    position: 1
    prefix: --minfrac
- id: score
  type:
  - 'null'
  - float
  doc: 'Minimum score (default: 0.02)'
  inputBinding:
    position: 1
    prefix: --score
- id: evenness
  type:
  - 'null'
  - float
  doc: 'Minimum evenness (default: 0.00)'
  inputBinding:
    position: 1
    prefix: --evenness
- id: minacct
  type:
  - 'null'
  - float
  doc: 'Minimum fraction of pan genome kmers accounted for by genome to be considered (default: 0.00)'
  inputBinding:
    position: 1
    prefix: --minacct
- id: universal
  type:
  - 'null'
  - int
  doc: 'Exclude Kmers occurring more often in the sample than this times the mean pangenome kmer frequency (default: 10)'
  inputBinding:
    position: 1
    prefix: --universal
- id: score_strains
  type:
  - 'null'
  - string
  doc: Only score these strains (primarily for debugging)
  inputBinding:
    position: 1
    prefix: --score-strains
outputs:
- id: output_result
  type:
  - 'null'
  - File
  doc: 'Output text file (default: standard out), or output filename prefix if enabling --separate-output.'
  outputBinding:
    glob: $(inputs.output)
- id: debug_out_result
  type:
  - 'null'
  - File
  doc: Output a debug HDF5 file containing the remaining sample k-mers per iteration. Optional.
  outputBinding:
    glob: $(inputs.debug_out)
- id: result_files
  type:
    type: array
    items: File
  doc: Result files; with --separate-output these are PREFIX.stats.tsv and PREFIX.strains.tsv.
  outputBinding:
    glob: $(inputs.output)*
- id: stdout
  type: stdout
  doc: Standard output
stdout: strainge_straingst_run.stdout.txt
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
