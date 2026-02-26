cwlVersion: v1.2
class: CommandLineTool
baseCommand: f5pack
label: fast5_f5pack
doc: "Pack and unpack ONT fast5 files.\n\nTool homepage: https://github.com/mateidavid/fast5"
inputs:
  - id: inputs
    type:
      - 'null'
      - type: array
        items: File
    doc: Input directories, fast5 files, or files of fast5 file names. For input
      directories, the subdirectory hierarchy (if traversed with --recurse) is 
      recreated in the output directory.
    inputBinding:
      position: 1
  - id: al_policy
    type:
      - 'null'
      - string
    doc: 'Policy for basecall alignment. Options: {drop,pack,unpack,copy}'
    inputBinding:
      position: 102
      prefix: --al
  - id: archive
    type:
      - 'null'
      - boolean
    doc: Pack raw samples data, drop rest.
    inputBinding:
      position: 102
      prefix: --archive
  - id: ed_policy
    type:
      - 'null'
      - string
    doc: 'Policy for eventdetection events. Options: {drop,pack,unpack,copy}'
    inputBinding:
      position: 102
      prefix: --ed
  - id: ev_policy
    type:
      - 'null'
      - string
    doc: 'Policy for basecall events. Options: {drop,pack,unpack,copy}'
    inputBinding:
      position: 102
      prefix: --ev
  - id: fastq
    type:
      - 'null'
      - boolean
    doc: Pack fastq data, drop rest.
    inputBinding:
      position: 102
      prefix: --fastq
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing destination files.
    inputBinding:
      position: 102
      prefix: --force
  - id: fq_policy
    type:
      - 'null'
      - string
    doc: 'Policy for fastq. Options: {drop,pack,unpack,copy}'
    inputBinding:
      position: 102
      prefix: --fq
  - id: log
    type:
      - 'null'
      - string
    doc: log level
    inputBinding:
      position: 102
      prefix: --log
  - id: p_model_state_bits
    type:
      - 'null'
      - int
    doc: p_model_state bits to keep.
    inputBinding:
      position: 102
      prefix: --p-model-state-bits
  - id: pack
    type:
      - 'null'
      - boolean
    doc: Pack data (default).
    inputBinding:
      position: 102
      prefix: --pack
  - id: qv_bits
    type:
      - 'null'
      - int
    doc: QV bits to keep.
    inputBinding:
      position: 102
      prefix: --qv-bits
  - id: recurse
    type:
      - 'null'
      - boolean
    doc: Recurse in input directories.
    inputBinding:
      position: 102
      prefix: --recurse
  - id: rs_policy
    type:
      - 'null'
      - string
    doc: 'Policy for raw samples. Options: {drop,pack,unpack,copy}'
    inputBinding:
      position: 102
      prefix: --rs
  - id: unpack
    type:
      - 'null'
      - boolean
    doc: Unpack data.
    inputBinding:
      position: 102
      prefix: --unpack
outputs:
  - id: output
    type: Directory
    doc: Output directory.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fast5:v0.6.5-2-deb_cv1
