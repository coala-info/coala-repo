cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ThermoRawFileParser
label: thermorawfileparser
doc: "Convert Thermo RAW mass spectrometry files to open formats (MGF, mzML, indexed mzML, Parquet) and write metadata.\n\nTool homepage: https://github.com/CompOmics/ThermoRawFileParser"
inputs:
  - id: input
    type:
      - 'null'
      - File
    doc: "The raw file input (Required). Specify this or an input directory -d."
    inputBinding:
      position: 101
      prefix: -i
  - id: input_directory
    type:
      - 'null'
      - Directory
    doc: "The directory containing the raw files (Required). Specify this or an input raw file -i."
    inputBinding:
      position: 101
      prefix: -d
  - id: output
    type:
      - 'null'
      - string
    doc: "The output file. Specify this or an output directory -o. Specifying neither writes to the input directory."
    inputBinding:
      position: 101
      prefix: -b
  - id: output_directory
    type:
      - 'null'
      - string
    doc: "The output directory. Specify this or an output file -b. Specifying neither writes to the input directory."
    inputBinding:
      position: 101
      prefix: -o
  - id: stdout_output
    type:
      - 'null'
      - boolean
    doc: "Write to standard output. Cannot be combined with file or directory output. Implies silent logging, i.e. logging level 0"
    inputBinding:
      position: 101
      prefix: -s
  - id: format
    type:
      - 'null'
      - string
    doc: "The spectra output format: 0 for MGF, 1 for mzML, 2 for indexed mzML, 3 for Parquet, 4 for None (no output); both numeric and text (case insensitive) value recognized. Defaults to indexed mzML if no format is specified."
    inputBinding:
      position: 101
      prefix: -f
  - id: metadata
    type:
      - 'null'
      - string
    doc: "The metadata output format: 0 for JSON, 1 for TXT, 2 for None (no output); both numeric and text (case insensitive) value recognized. Defaults to None"
    inputBinding:
      position: 101
      prefix: -m
  - id: metadata_output_file
    type:
      - 'null'
      - string
    doc: "The metadata output file. By default the metadata file is written to the output directory."
    inputBinding:
      position: 101
      prefix: -c
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: "GZip the output file."
    inputBinding:
      position: 101
      prefix: -g
  - id: no_peak_picking
    type:
      - 'null'
      - boolean
    doc: "Don't use the peak picking provided by the native Thermo library. By default peak picking is enabled."
    inputBinding:
      position: 101
      prefix: -p
  - id: no_peak_picking_levels
    type:
      - 'null'
      - string
    doc: "Disable peak picking only for selected MS levels: a comma-separated list of integers (1,2,3) and/or intervals (1-3), open-end intervals (1-) are allowed."
    inputBinding:
      position: 101
      prefix: --noPeakPicking=
      separate: false
  - id: no_zlib_compression
    type:
      - 'null'
      - boolean
    doc: "Don't use zlib compression for the m/z ratios and intensities. By default zlib compression is enabled."
    inputBinding:
      position: 101
      prefix: -z
  - id: all_detectors
    type:
      - 'null'
      - boolean
    doc: "Extract additional detector data: UV/PDA etc"
    inputBinding:
      position: 101
      prefix: -a
  - id: logging
    type:
      - 'null'
      - string
    doc: "The logging level: 0 for silent, 1 for verbose, 2 for default, 3 for warning, 4 for error; both numeric and text (case insensitive) value recognized."
    inputBinding:
      position: 101
      prefix: -l
  - id: ignore_instrument_errors
    type:
      - 'null'
      - boolean
    doc: "Ignore missing properties by the instrument."
    inputBinding:
      position: 101
      prefix: -e
  - id: exclude_exception_data
    type:
      - 'null'
      - boolean
    doc: "Exclude reference and exception data"
    inputBinding:
      position: 101
      prefix: -x
  - id: ms_level
    type:
      - 'null'
      - string
    doc: "Select MS levels (MS1, MS2, etc) included in the output, should be a comma-separated list of integers (1,2,3) and/or intervals (1-3), open-end intervals (1-) are allowed"
    inputBinding:
      position: 101
      prefix: -L
  - id: mgf_precursor
    type:
      - 'null'
      - boolean
    doc: "Include precursor scan number in MGF file TITLE"
    inputBinding:
      position: 101
      prefix: -P
  - id: noise_data
    type:
      - 'null'
      - boolean
    doc: "Include noise data in mzML output"
    inputBinding:
      position: 101
      prefix: -N
  - id: charge_data
    type:
      - 'null'
      - boolean
    doc: "Include instrument detected charge states in mzML output (only for high resolution centroided data)"
    inputBinding:
      position: 101
      prefix: -C
  - id: warnings_are_errors
    type:
      - 'null'
      - boolean
    doc: "Return non-zero exit code for warnings; default only for errors"
    inputBinding:
      position: 101
      prefix: -w
  - id: s3_url
    type:
      - 'null'
      - string
    doc: "Optional property to write directly the data into S3 Storage."
    inputBinding:
      position: 101
      prefix: --s3_url=
      separate: false
  - id: s3_accesskeyid
    type:
      - 'null'
      - string
    doc: "Optional key for the S3 bucket to write the file output."
    inputBinding:
      position: 101
      prefix: --s3_accesskeyid=
      separate: false
  - id: s3_secretaccesskey
    type:
      - 'null'
      - string
    doc: "Optional key for the S3 bucket to write the file output."
    inputBinding:
      position: 101
      prefix: --s3_secretaccesskey=
      separate: false
  - id: s3_bucket_name
    type:
      - 'null'
      - string
    doc: "S3 bucket name"
    inputBinding:
      position: 101
      prefix: --s3_bucketName=
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output (spectra when -s is used)"
  - id: output_directory_out
    type:
      - 'null'
      - Directory
    doc: "Output directory with the converted spectra and metadata files"
    outputBinding:
      glob: $(inputs.output_directory)
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Converted spectra file when -b is used"
    outputBinding:
      glob: $(inputs.output)
  - id: metadata_file
    type:
      - 'null'
      - File
    doc: "Metadata file when -c is used"
    outputBinding:
      glob: $(inputs.metadata_output_file)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$(inputs.output_directory ? [{entryname: inputs.output_directory, entry: {class: 'Directory', listing: []}, writable: true}] : [])"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/thermorawfileparser:2.0.0.dev--h9ee0642_0
stdout: thermorawfileparser.out
