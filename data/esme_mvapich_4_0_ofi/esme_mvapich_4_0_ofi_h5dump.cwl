cwlVersion: v1.2
class: CommandLineTool
baseCommand: h5dump
label: esme_mvapich_4_0_ofi_h5dump
doc: "The h5dump tool allows the user to examine the contents of an HDF5 file and
  dump those contents to an ASCII file.\n\nTool homepage: https://github.com/j34ni/bioconda-recipes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_mvapich_4_0_ofi_h5dump.out
