cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mfa
  - adapt
label: montreal-forced-aligner_mfa_adapt
doc: "Adapt an acoustic model to a new corpus.\n\nTool homepage: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner"
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
  - id: dictionary_path
    type: File
    doc: "Pronunciation dictionary file."
    inputBinding:
      position: 2
  - id: acoustic_model_path
    type: File
    doc: "Acoustic model (zip) to adapt."
    inputBinding:
      position: 3
  - id: output_model_path
    type: string
    doc: "Path of the adapted acoustic model (zip) to write."
    inputBinding:
      position: 4
  - id: output_directory
    type:
      - 'null'
      - string
    doc: "Path to save alignments."
    inputBinding:
      position: 100
      prefix: --output_directory
  - id: config_path
    type:
      - 'null'
      - File
    doc: "Path to config file to use for training."
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
  - id: include_original_text
    type:
      - 'null'
      - boolean
    doc: "Flag to include original utterance text in the output."
    inputBinding:
      position: 100
      prefix: --include_original_text
  - id: no_tokenization
    type:
      - 'null'
      - boolean
    doc: "Flag to disable any pretrained tokenization."
    inputBinding:
      position: 100
      prefix: --no_tokenization
  - id: reference_directory
    type:
      - 'null'
      - Directory
    doc: "Directory containing gold standard alignments to use in training"
    inputBinding:
      position: 100
      prefix: --reference_directory
  - id: custom_mapping_path
    type:
      - 'null'
      - File
    doc: "YAML file for mapping phones from acoustic model phone set to phone set in golden alignments."
    inputBinding:
      position: 100
      prefix: --custom_mapping_path
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
  - id: output_model_path_out
    type: File
    doc: "Path of the adapted acoustic model (zip) to write."
    outputBinding:
      glob: $(inputs.output_model_path)
  - id: output_directory_out
    type:
      - 'null'
      - Directory
    doc: "Path to save alignments."
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: mmcauliffe/montreal-forced-aligner:v3.4.3
