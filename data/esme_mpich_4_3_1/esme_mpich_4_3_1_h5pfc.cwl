cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_mpich_4_3_1_h5pfc
label: esme_mpich_4_3_1_h5pfc
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help information or argument definitions for the tool.\n\n
  Tool homepage: https://github.com/j34ni/bioconda-recipes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_mpich_4_3_1_h5pfc.out
