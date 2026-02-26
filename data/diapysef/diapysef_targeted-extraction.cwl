cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - diapysef
  - targeted-extraction
label: diapysef_targeted-extraction
doc: "Extract from the raw data given a set of target coordinates to extract for.\n\
  \nTool homepage: https://github.com/Roestlab/dia-pasef"
inputs:
  - id: coords
    type: File
    doc: File that contains target coordinates to extract data for, or a file 
      that can be used to generate target coordinates from.
    inputBinding:
      position: 101
      prefix: --coords
  - id: im_window
    type:
      - 'null'
      - float
    doc: The total window range of IM, i.e. a window of 0.06 would be 0.03 
      points to either side of the target IM.
    default: 0.06
    inputBinding:
      position: 101
      prefix: --im_window
  - id: in
    type: File
    doc: Raw data, diaPASEF mzML file.
    inputBinding:
      position: 101
      prefix: --in
  - id: log_file
    type:
      - 'null'
      - string
    doc: Log file to save console messages.
    default: mobidik_data_extraction.log
    inputBinding:
      position: 101
      prefix: --log_file
  - id: mslevel
    type:
      - 'null'
      - string
    doc: list of mslevel(s) to extract data for. i.e. [1,2] would extract data 
      for MS1 and MS2.
    default: '[1]'
    inputBinding:
      position: 101
      prefix: --mslevel
  - id: mz_tol
    type:
      - 'null'
      - int
    doc: The m/z tolerance toget get upper and lower bounds arround target mz. 
      Must be in ppm.
    default: 20
    inputBinding:
      position: 101
      prefix: --mz_tol
  - id: readOptions
    type:
      - 'null'
      - string
    doc: Context to estimate gene-level FDR control.
    default: ondisk
    inputBinding:
      position: 101
      prefix: --readOptions
  - id: rt_window
    type:
      - 'null'
      - int
    doc: The total window range of RT, i.e. a window of 50 would be 25 points to
      either side of the target RT.
    default: 50
    inputBinding:
      position: 101
      prefix: --rt_window
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to parallelize filtering of spectrums across threads.
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - int
    doc: Level of verbosity. 0 - just displays info, 1 - display some debug 
      info, 10 displays a lot of debug info.
    default: 0
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Filename to save extracted data to. Must be type mzML
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/diapysef:1.0.10--pyh7cba7a3_0
