cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - diapysef
  - export
label: diapysef_export
doc: "Export a reduced targeted mzML file to a tsv, parquet or sqMass file\n\nTool
  homepage: https://github.com/Roestlab/dia-pasef"
inputs:
  - id: aggr_ms2
    type:
      - 'null'
      - boolean
    doc: Whether you want to aggregate MS2 data for each precursor. Only 
      applicable for mzML to pkl export.
    inputBinding:
      position: 101
      prefix: --aggr_ms2
  - id: coords
    type:
      - 'null'
      - File
    doc: File that contains target coordinates to extract data for, or a file 
      that can be used to generate target coordinates from.
    inputBinding:
      position: 101
      prefix: --coords
  - id: in
    type: File
    doc: A filtered targeted diaPASEF mzML file, or a previously exported tsv 
      file.
    inputBinding:
      position: 101
      prefix: --in
  - id: log_file
    type:
      - 'null'
      - string
    doc: Log file to save console messages.
    inputBinding:
      position: 101
      prefix: --log_file
  - id: mslevel
    type:
      - 'null'
      - string
    doc: list of mslevel(s) to extract data for. i.e. [1,2] would extract data 
      for MS1 and MS2.
    inputBinding:
      position: 101
      prefix: --mslevel
  - id: mz_tol
    type:
      - 'null'
      - int
    doc: The m/z tolerance toget get upper and lower bounds arround target mz. 
      Must be in ppm.
    inputBinding:
      position: 101
      prefix: --mz_tol
  - id: no_aggr_ms2
    type:
      - 'null'
      - boolean
    doc: Whether you want to aggregate MS2 data for each precursor. Only 
      applicable for mzML to pkl export.
    inputBinding:
      position: 101
      prefix: --no-aggr_ms2
  - id: out
    type:
      - 'null'
      - string
    doc: Filename to save extracted data to, tsv or parquet if input is mzML or 
      sqMass if input is tsv or mzML.
    inputBinding:
      position: 101
      prefix: --out
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to parallelize exporting across threads.
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - int
    doc: Level of verbosity. 0 - just displays info, 1 - display some debug 
      info, 10 displays a lot of debug info.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: out_file
    type: File
    doc: Exported data (tsv, parquet, sqMass or pkl).
    outputBinding:
      glob: "$(inputs.out ? inputs.out : 'diapasef_extracted_data.tsv')"
  - id: log
    type:
      - 'null'
      - File
    doc: Log file with console messages.
    outputBinding:
      glob: "$(inputs.log_file ? inputs.log_file : 'mobidik_export.log')"
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/diapysef:1.0.10--pyh7cba7a3_0
stdout: diapysef_export.out
