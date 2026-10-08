cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- strainge
- createdb
label: strainge_createdb
doc: 'Create pan-genome database in HDF5 format from a list of k-merized strains.


  Tool homepage: https://github.com/broadinstitute/strainge'
inputs:
- id: kmerset
  type:
  - 'null'
  - File[]
  doc: The HDF5 filenames of the kmerized reference strains.
  inputBinding:
    position: 100
- id: output
  type: string
  doc: Pan-genome database output HDF5 file.
  inputBinding:
    position: 1
    prefix: --output
  default: pan-genome-db.hdf5
- id: from_file
  type:
  - 'null'
  - File
  doc: Read list of HDF5 filenames to include in the database from a given file (use '-' to denote standard input). This is in addition to any k-merset given as positional argument.
  inputBinding:
    position: 1
    prefix: --from-file
outputs:
- id: output_result
  type: File
  doc: Pan-genome database output HDF5 file.
  outputBinding:
    glob: $(inputs.output)
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
