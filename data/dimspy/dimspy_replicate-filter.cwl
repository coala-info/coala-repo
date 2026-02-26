cwlVersion: v1.2
class: CommandLineTool
baseCommand: dimspy replicate-filter
label: dimspy_replicate-filter
doc: "Filters peaklists based on replicate information.\n\nTool homepage: https://github.com/computational-metabolomics/dimspy"
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
    doc: Tab-delimited file that list all the data files (*.raw or *.mzml) and 
      meta data (filename, technical replicate, class, batch).
    inputBinding:
      position: 101
      prefix: --filelist
  - id: input
    type: File
    doc: HDF5 file (Peaklist objects) from step 'process-scans' or directory 
      path that contains tab-delimited peaklists.
    inputBinding:
      position: 101
      prefix: --input
  - id: min_peak_present
    type: int
    doc: Minimum number of times a peak has to be present (number) across 
      technical replicates.
    inputBinding:
      position: 101
      prefix: --min-peak-present
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
    doc: Mass tolerance in Parts per million to group peaks across scans / mass 
      spectra.
    inputBinding:
      position: 101
      prefix: --ppm
  - id: replicates
    type: int
    doc: Number of technical replicates.
    inputBinding:
      position: 101
      prefix: --replicates
  - id: rsd_threshold
    type:
      - 'null'
      - float
    doc: Maximum threshold - Relative Standard Deviation.
    inputBinding:
      position: 101
      prefix: --rsd-threshold
outputs:
  - id: output
    type: File
    doc: HDF5 file to save the peaklist objects to.
    outputBinding:
      glob: $(inputs.output)
  - id: report
    type:
      - 'null'
      - File
    doc: Summary/Report of processed mass spectra
    outputBinding:
      glob: $(inputs.report)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dimspy:2.0.0--pyhdfd78af_1
