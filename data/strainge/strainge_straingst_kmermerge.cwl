cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- straingst
- kmermerge
label: strainge_straingst_kmermerge
doc: 'Merge k-mer set files.


  Tool homepage: https://github.com/broadinstitute/strainge'
inputs:
- id: kmerfiles
  type: File[]
  doc: Input KmerSet files to be merged (hdf5 files)
  inputBinding:
    position: 100
- id: kmer_size
  type:
  - 'null'
  - int
  doc: K-mer size (default 23)
  inputBinding:
    position: 1
    prefix: --k
- id: output
  type: string
  doc: Filename of the output HDF5.
  inputBinding:
    position: 1
    prefix: --output
  default: merged.hdf5
- id: fingerprint_fraction
  type:
  - 'null'
  - float
  doc: 'Fraction of k-mers to keep for a minhash sketch. Default: 0.01. No fingerprint will be created if set to zero.'
  inputBinding:
    position: 1
    prefix: --fingerprint-fraction
outputs:
- id: output_result
  type: File
  doc: Filename of the output HDF5.
  outputBinding:
    glob: $(inputs.output)
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
