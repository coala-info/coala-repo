cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - diapysef
  - converttdftomzml
label: diapysef_converttdftomzml
doc: "Conversion program to convert a Bruker TIMS .d data file to mzML format\n\n\
  Tool homepage: https://github.com/Roestlab/dia-pasef"
inputs:
  - id: framerange
    type:
      - 'null'
      - string
    doc: The minimum and maximum Frames to convert. Useful to only convert a 
      part of a file.
    inputBinding:
      position: 101
      prefix: --framerange
  - id: in
    type: Directory
    doc: The location of the directory containing raw data (usually .d).
    inputBinding:
      position: 101
      prefix: --in
  - id: keep_frames
    type:
      - 'null'
      - boolean
    doc: Whether to store frames exactly as measured or split them into 
      individual spectra by precursor isolation window (default is to split them
      - this is almost always what you want).
    inputBinding:
      position: 101
      prefix: --keep_frames
  - id: merge
    type:
      - 'null'
      - int
    doc: Number of consecutive frames to sum up (squash). This is useful to 
      boost S/N if exactly repeated frames are measured.
    inputBinding:
      position: 101
      prefix: --merge
  - id: no_keep_frames
    type:
      - 'null'
      - boolean
    doc: Whether to store frames exactly as measured or split them into 
      individual spectra by precursor isolation window (default is to split them
      - this is almost always what you want).
    inputBinding:
      position: 101
      prefix: --no-keep_frames
  - id: out
    type: string
    doc: The name of the output file (mzML).
    inputBinding:
      position: 101
      prefix: --out
  - id: overlap
    type:
      - 'null'
      - int
    doc: How many overlapping windows were recorded for the same m/z window - 
      will split the output into N output files.
    inputBinding:
      position: 101
      prefix: --overlap
  - id: verbose
    type:
      - 'null'
      - int
    doc: Verbosity.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/diapysef:1.0.10--pyh7cba7a3_0
stdout: diapysef_converttdftomzml.out
