cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dimspy
  - process-scans
label: dimspy_process-scans
doc: "Processes raw mass spectrometry scan data to generate peaklists.\n\nTool homepage:
  https://github.com/computational-metabolomics/dimspy"
inputs:
  - id: block_size
    type:
      - 'null'
      - int
    doc: The size of each block of peaks to perform clustering on.
    inputBinding:
      position: 101
      prefix: --block-size
  - id: exclude_scan_events
    type:
      - 'null'
      - type: array
        items: string
    doc: Scan events to select. E.g. 100.0 200.0 sim or 50.0 1000.0 full
    inputBinding:
      position: 101
      prefix: --exclude-scan-events
  - id: filelist
    type:
      - 'null'
      - File
    doc: 'Tab-delimited file that include the name of the data files (*.raw or *.mzml)
      and meta data. Column names: filename, replicate, batch, injectionOrder, classLabel.'
    inputBinding:
      position: 101
      prefix: --filelist
  - id: function_noise
    type: string
    doc: Select function to calculate noise.
    inputBinding:
      position: 101
      prefix: --function-noise
  - id: include_scan_events
    type:
      - 'null'
      - type: array
        items: string
    doc: Scan events to select. E.g. 100.0 200.0 sim or 50.0 1000.0 full
    inputBinding:
      position: 101
      prefix: --include-scan-events
  - id: min_fraction
    type:
      - 'null'
      - float
    doc: Minimum fraction a peak has to be present. Use 0.0 to not apply this 
      filter.
    inputBinding:
      position: 101
      prefix: --min-fraction
  - id: min_scans
    type:
      - 'null'
      - int
    doc: Minimum number of scans required for each m/z range or event.
    inputBinding:
      position: 101
      prefix: --min_scans
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
  - id: remove_mz_range
    type:
      - 'null'
      - type: array
        items: string
    doc: M/z range(s) to remove. E.g. 100.0 102.0 or 140.0 145.0.
    inputBinding:
      position: 101
      prefix: --remove-mz-range
  - id: report
    type:
      - 'null'
      - File
    doc: Summary/Report of processed mass spectra
    inputBinding:
      position: 101
      prefix: --report
  - id: ringing_threshold
    type:
      - 'null'
      - float
    doc: Ringing
    inputBinding:
      position: 101
      prefix: --ringing-threshold
  - id: rsd_threshold
    type:
      - 'null'
      - float
    doc: Maximum threshold - relative standard deviation (Calculated for peaks 
      that have been measured across a minimum of two scans).
    inputBinding:
      position: 101
      prefix: --rsd-threshold
  - id: skip_stitching
    type:
      - 'null'
      - boolean
    doc: Skip the step where (SIM) windows are 'stitched' or 'joined' together. 
      Individual peaklists are generated for each window.
    inputBinding:
      position: 101
      prefix: --skip-stitching
  - id: snr_threshold
    type: float
    doc: Signal-to-noise threshold
    inputBinding:
      position: 101
      prefix: --snr-threshold
  - id: source
    type: File
    doc: Directory (*.raw, *.mzml or tab-delimited peaklist files), single 
      *.mzml/*.raw file or zip archive (*.mzml only)
    inputBinding:
      position: 101
      prefix: --input
outputs:
  - id: output
    type: File
    doc: HDF5 file to save the peaklist objects to.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dimspy:2.0.0--pyhdfd78af_1
