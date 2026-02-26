cwlVersion: v1.2
class: CommandLineTool
baseCommand: SAMPEI
label: sampei
doc: "SAMPEI is a searching method leveraging high quality query spectra within the
  same or different dataset to assign target spectra with peptide sequence and undefined
  modification (mass shift).\n\nTool homepage: https://github.com/FenyoLab/SAMPEI"
inputs:
  - id: mgf_query_file
    type: File
    doc: Query mgf file with full path containing query scans have been 
      identified by DB search
    inputBinding:
      position: 1
  - id: mgf_target_file
    type: File
    doc: Target mgf file with full path containing target scans with undefined 
      modifications
    inputBinding:
      position: 2
  - id: id_file
    type: File
    doc: File in which query scans have been identified by DB search
    inputBinding:
      position: 3
  - id: error_type
    type:
      - 'null'
      - string
    doc: Type of error (ppm or dalton)
    default: ppm
    inputBinding:
      position: 104
      prefix: --error-type
  - id: fragment_mass_error
    type:
      - 'null'
      - int
    doc: Fragment mass error
    default: 20
    inputBinding:
      position: 104
      prefix: --fragment-mass-error
  - id: largest_gap_percent
    type:
      - 'null'
      - float
    doc: The percentage of the largest consecutive b/y ion missing over the 
      length of the peptide sequence.
    default: 0.4
    inputBinding:
      position: 104
      prefix: --largest-gap-percent
  - id: matched_peptide_intensity
    type:
      - 'null'
      - float
    doc: The percentage of MS2 intensity of target scan matched to the 
      theoretical fragments of peptide sequence over the summation of total MS2 
      intensity in the target scan.
    default: 0.5
    inputBinding:
      position: 104
      prefix: --matched-peptide-intensity
  - id: matched_query_intensity
    type:
      - 'null'
      - float
    doc: The percentage of MS2 intensity of query scan matched to target scan 
      over the summation of total MS2 intensity in the query scan.
    default: 0.3
    inputBinding:
      position: 104
      prefix: --matched-query-intensity
  - id: max_peaks_per_scan
    type:
      - 'null'
      - int
    doc: Maximum number of peaks per scan
    default: 20
    inputBinding:
      position: 104
      prefix: --max-peaks-per-scan
  - id: min_diff_dalton_bin
    type:
      - 'null'
      - int
    doc: The absolute minimum dalton difference between the query scan and the 
      target scan.
    default: 10
    inputBinding:
      position: 104
      prefix: --min-diff-dalton-bin
  - id: no_filter
    type:
      - 'null'
      - boolean
    doc: Disable the filter and keep DB identified scans in the target mgf file
    inputBinding:
      position: 104
      prefix: --no-filter
  - id: write_intermediate
    type:
      - 'null'
      - boolean
    doc: Write files for each step of filtering.
    inputBinding:
      position: 104
      prefix: --write-intermediate
  - id: xtandem_xml
    type:
      - 'null'
      - File
    doc: The path to an X!tandem xml file which will be used to filter the 
      results.
    inputBinding:
      position: 104
      prefix: --xtandem-xml
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Full path to the directory where output is stored. If this directory 
      does not exist it will be created.
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sampei:0.0.9--py_0
