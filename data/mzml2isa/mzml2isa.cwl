cwlVersion: v1.2
class: CommandLineTool
baseCommand: mzml2isa
label: mzml2isa
doc: "Extract meta information from (i)mzML files and create ISA-tab structure\n\n\
  Tool homepage: https://github.com/ISA-tools/mzml2isa"
inputs:
  - id: group_centroid_profile_samples
    type:
      - 'null'
      - boolean
    doc: do NOT group centroid & profile samples
    inputBinding:
      position: 101
      prefix: -c
  - id: input_path
    type: Directory
    doc: input folder or archive containing mzML files
    inputBinding:
      position: 101
      prefix: -i
  - id: jobs
    type:
      - 'null'
      - int
    doc: launch different processes for parsing
    inputBinding:
      position: 101
      prefix: -j
  - id: split_assay_files_by_polarity
    type:
      - 'null'
      - boolean
    doc: do NOT split assay files based on polarity
    inputBinding:
      position: 101
      prefix: -n
  - id: study_id
    type: string
    doc: study identifier (e.g. MTBLSxxx)
    inputBinding:
      position: 101
      prefix: -s
  - id: template_dir
    type:
      - 'null'
      - Directory
    doc: directory containing default template files
    inputBinding:
      position: 101
      prefix: -t
  - id: usermeta
    type:
      - 'null'
      - string
    doc: additional user provided metadata (JSON format)
    inputBinding:
      position: 101
      prefix: -m
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: show more output (default if tqdm is not installed)
    inputBinding:
      position: 101
      prefix: -v
  - id: warning_control
    type:
      - 'null'
      - string
    doc: warning control (with python default behaviour)
    inputBinding:
      position: 101
      prefix: -W
outputs:
  - id: output_path
    type: Directory
    doc: out folder (new files will be created here)
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mzml2isa:1.1.1--pyhdfd78af_0
