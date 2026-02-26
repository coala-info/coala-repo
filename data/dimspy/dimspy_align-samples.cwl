cwlVersion: v1.2
class: CommandLineTool
baseCommand: dimspy align-samples
label: dimspy_align-samples
doc: "Aligns samples by grouping peaks across scans/mass spectra based on mass tolerance.\n\
  \nTool homepage: https://github.com/computational-metabolomics/dimspy"
inputs:
  - id: block_size
    type:
      - 'null'
      - int
    doc: The size of each block of peaks to perform clustering on.
    inputBinding:
      position: 101
      prefix: --block-size
  - id: filelist
    type:
      - 'null'
      - File
    doc: 'Tab-delimited file that include the name of the samples and meta data.Column
      names: filename, replicate, batch, injectionOrder, classLabel.'
    inputBinding:
      position: 101
      prefix: --filelist
  - id: input
    type: File
    doc: HDF5 file (Peaklist objects) from step 'process-scans / 
      replicate-filter' or directory path that contains tab-delimited peaklists.
    inputBinding:
      position: 101
      prefix: --input
  - id: ncpus
    type:
      - 'null'
      - int
    doc: Number of central processing units (CPUs).
    inputBinding:
      position: 101
      prefix: --ncpus
  - id: ppm
    type:
      - 'null'
      - float
    doc: Mass tolerance in parts per million to group peaks across scans / mass 
      spectra.
    inputBinding:
      position: 101
      prefix: --ppm
outputs:
  - id: output
    type: File
    doc: HDF5 file to save the peak matrix object to.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dimspy:2.0.0--pyhdfd78af_1
