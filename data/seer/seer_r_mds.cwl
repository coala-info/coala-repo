cwlVersion: v1.2
class: CommandLineTool
baseCommand: R_mds
label: seer_r_mds
doc: "Projects distance matrix into lower number of dimensions. Requires R and rhdf5 to be installed\n\nTool homepage: https://github.com/johnlees/seer"
inputs:
  - id: dist
    type: File
    doc: "Distance matrix output by kmds/mash"
    inputBinding:
      position: 1
      prefix: --dist
  - id: pheno
    type: File
    doc: "Phenotype file used by seer"
    inputBinding:
      position: 1
      prefix: --pheno
  - id: output
    type: ['null', string]
    doc: "Output prefix (default all_structure)"
    inputBinding:
      position: 1
      prefix: --output
  - id: pc
    type: ['null', int]
    doc: "Number of dimensions to project into (default 10)"
    inputBinding:
      position: 1
      prefix: --pc
  - id: no_hdf5
    type: ['null', boolean]
    doc: "Write output as csv, use if seer compiled with NO_HDF5"
    inputBinding:
      position: 1
      prefix: --no_hdf5
  - id: r_executable
    type: ['null', string]
    doc: "R executable (default which R)"
    inputBinding:
      position: 1
      prefix: -R
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Structure files written with the output prefix
    outputBinding:
      glob: ['all_structure*', '*structure*']
  - id: output
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/seer:v1.1.4-2b2-deb_cv1
stdout: seer_r_mds.out
