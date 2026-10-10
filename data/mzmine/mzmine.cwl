cwlVersion: v1.2
class: CommandLineTool
baseCommand: mzmine
label: mzmine
doc: "MZmine is a modular software for analyzing mass spectrometry data. This wrapper
  runs it headless in batch mode (-b with a batch file and -i with the input files).
  Processing and export modules need an mzmine user login (-u user file).\n\nTool
  homepage: http://mzmine.github.io/"
inputs:
  - id: batch
    type:
      - 'null'
      - File
    doc: batch mode file
    inputBinding:
      position: 101
      prefix: --batch
  - id: input
    type:
      - 'null'
      - type: array
        items: File
    doc: input data files. Either defined in a .txt text file with one file per line
      or by glob pattern matching.
    inputBinding:
      position: 101
      prefix: --input
  - id: ignore_parameter_warnings
    type:
      - 'null'
      - boolean
    doc: Adding this option will (in batch mode) ignore warnings with regard to
      changed parameters across versions. This will use the last set or the default
      value. (This option is not recommended)
    inputBinding:
      position: 101
      prefix: --ignore-parameter-warnings
  - id: libraries
    type:
      - 'null'
      - type: array
        items: File
    doc: spectral library files. Either defined in a .txt text file with one file
      per line or by glob pattern matching.
    inputBinding:
      position: 101
      prefix: --libraries
  - id: memory
    type:
      - 'null'
      - string
    doc: 'keep objects (scan data, features, etc) in memory. Options: none, all,
      features, centroids, raw, masses_features (masses_features for features and
      centroids)'
    inputBinding:
      position: 101
      prefix: --memory
  - id: metadata
    type:
      - 'null'
      - File
    doc: Metadata file in csv or tsv, comma or tab-separated values, respectively.
      The file ending defines the default value separator.
    inputBinding:
      position: 101
      prefix: --metadata
  - id: output
    type:
      - 'null'
      - string
    doc: An output path and base filename that will change all export filenames.
      -output path/basename will be extended by module specific suffixes and file
      formats.
    inputBinding:
      position: 101
      prefix: --output
  - id: pref
    type:
      - 'null'
      - File
    doc: preferences file
    inputBinding:
      position: 101
      prefix: --pref
  - id: proxy
    type:
      - 'null'
      - string
    doc: Option to set a proxy, which might be needed for user login and webservices.
      Use a full definition like -proxy http://myproxy:myPort or use -proxy false
      to turn the proxy off.
    inputBinding:
      position: 101
      prefix: --proxy
  - id: running
    type:
      - 'null'
      - boolean
    doc: keep mzmine running in headless mode
    inputBinding:
      position: 101
      prefix: --running
  - id: temp
    type:
      - 'null'
      - string
    doc: Temp directory overrides definition in preferences and JVM
    inputBinding:
      position: 101
      prefix: --temp
  - id: tdfpseudoprofile
    type:
      - 'null'
      - boolean
    doc: Loads pseudo-profile frame spectra for tdf files instead of centroided spectra.
    inputBinding:
      position: 101
      prefix: --tdfpseudoprofile
  - id: threads
    type:
      - 'null'
      - string
    doc: the number of threads to use during processing, or 'auto' to automatically
      detect available resources. threads overwrites the specified value in the preference.
    inputBinding:
      position: 101
      prefix: --threads
  - id: user
    type:
      - 'null'
      - File
    doc: Path to an .mzuser file to login a user, e.g. pathTo/testuser.mzuser. The
      file is copied to the users directory.
    inputBinding:
      position: 101
      prefix: --user
outputs:
  - id: stdout
    type: stdout
    doc: Log messages
  - id: export_files
    type:
      type: array
      items: File
    doc: Files written by the batch export steps (named after --output)
    outputBinding:
      glob: "$(inputs.output ? inputs.output + '*' : 'mzmine_no_output_prefix_*')"
  - id: log_files
    type:
      type: array
      items: File
    doc: mzmine log files (mzmine_*.log, written to the home directory)
    outputBinding:
      glob: mzmine_*.log
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mzmine:4.7.29--hdfd78af_0
stdout: mzmine.out
