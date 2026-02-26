cwlVersion: v1.2
class: CommandLineTool
baseCommand: dimspy merge-peaklists
label: dimspy_merge-peaklists
doc: "Merge peaklists from multiple HDF5 files.\n\nTool homepage: https://github.com/computational-metabolomics/dimspy"
inputs:
  - id: filelist
    type:
      - 'null'
      - File
    doc: Tab-delimited file that list all the data files (*.raw or *.mzml) and 
      meta data (filename, technical replicate, class, batch, multiList).
    inputBinding:
      position: 101
      prefix: --filelist
  - id: input
    type:
      type: array
      items: File
    doc: Multiple HDF5 files that contain peaklists or peak matrix from one of 
      the processing steps.
    inputBinding:
      position: 101
      prefix: --input
outputs:
  - id: output
    type: Directory
    doc: Directory (if using multilist column in filelist) or HDF5 file to write
      to.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dimspy:2.0.0--pyhdfd78af_1
