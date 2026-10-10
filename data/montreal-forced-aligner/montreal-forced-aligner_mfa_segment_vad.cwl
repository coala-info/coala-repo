cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mfa
  - segment_vad
label: montreal-forced-aligner_mfa_segment_vad
doc: "Create segments based on SpeechBrain's voice activity detection (VAD) model or a basic energy-based algorithm.\n\nTool homepage: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner"
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: MFA_ROOT_DIR
        envValue: $(runtime.outdir)/mfa_root
inputs:
  - id: corpus_directory
    type: Directory
    doc: "Directory with the corpus."
    inputBinding:
      position: 1
  - id: output_directory
    type: string
    doc: "Directory where the segmented corpus is written."
    inputBinding:
      position: 2
  - id: config_path
    type:
      - 'null'
      - File
    doc: "Path to config file to use for training."
    inputBinding:
      position: 100
      prefix: --config_path
  - id: output_format
    type:
      - 'null'
      - type: enum
        symbols:
          - long_textgrid
          - short_textgrid
          - json
          - csv
    doc: "Format for aligned output files (default is long_textgrid)."
    inputBinding:
      position: 100
      prefix: --output_format
  - id: speechbrain
    type:
      - 'null'
      - boolean
    doc: "Flag for using SpeechBrain's pretrained VAD model"
    inputBinding:
      position: 100
      valueFrom: '$(self === null ? null : (self ? "--speechbrain" : "--no_speechbrain"))'
  - id: cuda
    type:
      - 'null'
      - boolean
    doc: "Flag for using CUDA for SpeechBrain's model"
    inputBinding:
      position: 100
      valueFrom: '$(self === null ? null : (self ? "--cuda" : "--no_cuda"))'
  - id: segment_transcripts
    type:
      - 'null'
      - boolean
    doc: "Flag for using CUDA for SpeechBrain's model"
    inputBinding:
      position: 100
      valueFrom: '$(self === null ? null : (self ? "--segment_transcripts" : "--no_segment_transcripts"))'
  - id: profile
    type:
      - 'null'
      - string
    doc: "Configuration profile to use, defaults to \"global\""
    inputBinding:
      position: 100
      prefix: --profile
  - id: temporary_directory
    type:
      - 'null'
      - string
    doc: "Set the default temporary directory, default is /mfa"
    inputBinding:
      position: 100
      prefix: --temporary_directory
  - id: num_jobs
    type:
      - 'null'
      - int
    doc: "Set the number of processes to use by default, defaults to 3"
    inputBinding:
      position: 100
      prefix: --num_jobs
  - id: clean
    type:
      - 'null'
      - boolean
    doc: "Remove files from previous runs, default is True"
    inputBinding:
      position: 100
      valueFrom: '$(self === null ? null : (self ? "--clean" : "--no_clean"))'
  - id: final_clean
    type:
      - 'null'
      - boolean
    doc: "Remove temporary files at the end of run, default is False"
    inputBinding:
      position: 100
      valueFrom: '$(self === null ? null : (self ? "--final_clean" : "--no_final_clean"))'
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Output debug messages, default is False"
    inputBinding:
      position: 100
      valueFrom: '$(self === null ? null : (self ? "--verbose" : "--no_verbose"))'
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Suppress all output messages (overrides verbose), default is False"
    inputBinding:
      position: 100
      valueFrom: '$(self === null ? null : (self ? "--quiet" : "--no_quiet"))'
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: "Overwrite output files when they exist, default is False"
    inputBinding:
      position: 100
      valueFrom: '$(self === null ? null : (self ? "--overwrite" : "--no_overwrite"))'
  - id: use_mp
    type:
      - 'null'
      - boolean
    doc: "Turn on/off multiprocessing. Multiprocessing is recommended will allow for faster executions."
    inputBinding:
      position: 100
      valueFrom: '$(self === null ? null : (self ? "--use_mp" : "--no_use_mp"))'
  - id: use_threading
    type:
      - 'null'
      - boolean
    doc: "Use threading library rather than multiprocessing library. Multiprocessing is recommended will allow for faster executions."
    inputBinding:
      position: 100
      valueFrom: '$(self === null ? null : (self ? "--use_threading" : "--no_use_threading"))'
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "Run extra steps for debugging issues, default is False"
    inputBinding:
      position: 100
      valueFrom: '$(self === null ? null : (self ? "--debug" : "--no_debug"))'
  - id: use_postgres
    type:
      - 'null'
      - boolean
    doc: "Use postgres instead of sqlite for extra functionality, default is False"
    inputBinding:
      position: 100
      valueFrom: '$(self === null ? null : (self ? "--use_postgres" : "--no_use_postgres"))'
  - id: single_speaker
    type:
      - 'null'
      - boolean
    doc: "Single speaker mode creates multiprocessing splits based on utterances rather than speakers. This mode also disables speaker adaptation equivalent to `--uses_speaker_adaptation false`."
    inputBinding:
      position: 100
      prefix: --single_speaker
  - id: textgrid_cleanup
    type:
      - 'null'
      - boolean
    doc: "Turn on/off post-processing of TextGrids that cleans up silences and recombines compound words and clitics."
    inputBinding:
      position: 100
      valueFrom: '$(self === null ? null : (self ? "--textgrid_cleanup" : "--no_textgrid_cleanup"))'
outputs:
  - id: output_directory_out
    type: Directory
    doc: "Directory where the segmented corpus is written."
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: mmcauliffe/montreal-forced-aligner:v3.4.3
