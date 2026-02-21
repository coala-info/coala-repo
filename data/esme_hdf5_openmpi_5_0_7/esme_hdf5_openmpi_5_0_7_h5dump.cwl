cwlVersion: v1.2
class: CommandLineTool
baseCommand: h5dump
label: esme_hdf5_openmpi_5_0_7_h5dump
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build or pull the image due to insufficient disk space.
  It does not contain CLI help information or argument definitions for h5dump.\n\n
  Tool homepage: https://www.hdfgroup.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_hdf5_openmpi_5_0_7_h5dump.out
