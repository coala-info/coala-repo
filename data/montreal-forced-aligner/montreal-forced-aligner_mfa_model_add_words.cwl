cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mfa
  - model
  - add_words
label: montreal-forced-aligner_mfa_model_add_words
doc: "Add words from one pronunciation dictionary to another pronunciation dictionary, so long as the new pronunciations do not contain any new phones.\n\nTool homepage: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner"
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: MFA_ROOT_DIR
        envValue: $(runtime.outdir)/mfa_root
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.dictionary_path.basename)
        entry: $(inputs.dictionary_path)
        writable: true
inputs:
  - id: dictionary_path
    type: File
    doc: "Pronunciation dictionary to add words to (a writable copy is edited in place)."
    inputBinding:
      position: 1
  - id: new_pronunciations_path
    type: File
    doc: "Pronunciation dictionary that holds the new words."
    inputBinding:
      position: 2
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
  - id: dictionary_path_out
    type: File
    doc: Edited pronunciation dictionary.
    outputBinding:
      glob: $(inputs.dictionary_path.basename)
hints:
  - class: DockerRequirement
    dockerPull: mmcauliffe/montreal-forced-aligner:v3.4.3
