cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mfa
  - transcribe_whisper
label: montreal-forced-aligner_mfa_transcribe_whisper
doc: "Transcribe utterances using a Whisper ASR model via faster-whisper.\n\nTool homepage: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner"
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: MFA_ROOT_DIR
        envValue: $(runtime.outdir)/mfa_root
  - class: NetworkAccess
    networkAccess: true
inputs:
  - id: input_path
    type:
      - File
      - Directory
    doc: "Audio file or corpus directory to transcribe."
    inputBinding:
      position: 1
  - id: output_path
    type: string
    doc: "Directory where the transcripts are written."
    inputBinding:
      position: 2
  - id: architecture
    type:
      - 'null'
      - type: enum
        symbols:
          - large-v3
          - distil-large-v3
          - medium
          - base
          - tiny
          - small
    doc: "Model size to use"
    inputBinding:
      position: 100
      prefix: --architecture
  - id: language
    type:
      - 'null'
      - string
    doc: "Language to use for tokenizers and other preprocessing (a name such as english, french or mandarin)."
    inputBinding:
      position: 100
      prefix: --language
  - id: config_path
    type:
      - 'null'
      - File
    doc: "Path to config file to use for transcription."
    inputBinding:
      position: 100
      prefix: --config_path
  - id: speaker_characters
    type:
      - 'null'
      - string
    doc: "Number of characters of file names to use for determining speaker, default is to use directory names."
    inputBinding:
      position: 100
      prefix: --speaker_characters
  - id: audio_directory
    type:
      - 'null'
      - Directory
    doc: "Audio directory root to use for finding audio files."
    inputBinding:
      position: 100
      prefix: --audio_directory
  - id: cuda
    type:
      - 'null'
      - boolean
    doc: "Flag for using CUDA for Whisper's model"
    inputBinding:
      position: 100
      valueFrom: '$(self === null ? null : (self ? "--cuda" : "--no_cuda"))'
  - id: evaluate
    type:
      - 'null'
      - boolean
    doc: "Evaluate the transcription against golden texts."
    inputBinding:
      position: 100
      prefix: --evaluate
  - id: vad
    type:
      - 'null'
      - boolean
    doc: "Use VAD to split utterances."
    inputBinding:
      position: 100
      prefix: --vad
  - id: incremental
    type:
      - 'null'
      - boolean
    doc: "Save outputs immediately and use previous progress."
    inputBinding:
      position: 100
      prefix: --incremental
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
  - id: output_path_out
    type: Directory
    doc: "Directory where the transcripts are written."
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: mmcauliffe/montreal-forced-aligner:v3.4.3
