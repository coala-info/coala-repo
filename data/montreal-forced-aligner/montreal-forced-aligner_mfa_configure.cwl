cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mfa
  - configure
label: montreal-forced-aligner_mfa_configure
doc: "Set global defaults for MFA so you do not have to set them every time you call an MFA command. The settings are written to the profile file in the MFA root directory.\n\nTool homepage: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner"
requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      - envName: MFA_ROOT_DIR
        envValue: $(runtime.outdir)/mfa_root
inputs:
  - id: profile
    type:
      - 'null'
      - string
    doc: "Configuration profile to use, defaults to global"
    inputBinding:
      position: 1
      prefix: --profile
  - id: temporary_directory
    type:
      - 'null'
      - string
    doc: "Set the default temporary directory. Currently defaults to /mfa"
    inputBinding:
      position: 1
      prefix: --temporary_directory
  - id: num_jobs
    type:
      - 'null'
      - int
    doc: "Set the number of processes to use by default. Currently defaults to 3"
    inputBinding:
      position: 1
      prefix: --num_jobs
  - id: clean
    type:
      - 'null'
      - boolean
    doc: "Turn on/off mode where MFA will clean temporary files before each run. Currently defaults to True."
    inputBinding:
      position: 1
      valueFrom: '$(self === null ? null : (self ? "--always_clean" : "--never_clean"))'
  - id: final_clean
    type:
      - 'null'
      - boolean
    doc: "Turn on/off mode where MFA will clean temporary files at the end of each run. Currently defaults to False."
    inputBinding:
      position: 1
      valueFrom: '$(self === null ? null : (self ? "--always_final_clean" : "--never_final_clean"))'
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Turn on/off verbose mode where MFA will print more output. Currently defaults to False."
    inputBinding:
      position: 1
      valueFrom: '$(self === null ? null : (self ? "--always_verbose" : "--never_verbose"))'
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Turn on/off quiet mode where MFA will not print any output. Currently defaults to False."
    inputBinding:
      position: 1
      valueFrom: '$(self === null ? null : (self ? "--always_quiet" : "--never_quiet"))'
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "Turn on/off extra debugging functionality. Currently defaults to False."
    inputBinding:
      position: 1
      valueFrom: '$(self === null ? null : (self ? "--always_debug" : "--never_debug"))'
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: "Turn on/off overwriting export files. Currently defaults to False."
    inputBinding:
      position: 1
      valueFrom: '$(self === null ? null : (self ? "--always_overwrite" : "--never_overwrite"))'
  - id: enable_mp
    type:
      - 'null'
      - boolean
    doc: "Turn on/off multiprocessing. Multiprocessing allows faster executions. Currently defaults to True."
    inputBinding:
      position: 1
      valueFrom: '$(self === null ? null : (self ? "--enable_mp" : "--disable_mp"))'
  - id: textgrid_cleanup
    type:
      - 'null'
      - boolean
    doc: "Turn on/off post-processing of TextGrids that cleans up silences and recombines compound words and clitics. Currently defaults to True."
    inputBinding:
      position: 1
      valueFrom: '$(self === null ? null : (self ? "--enable_textgrid_cleanup" : "--disable_textgrid_cleanup"))'
  - id: auto_server
    type:
      - 'null'
      - boolean
    doc: "If auto_server is enabled, MFA starts a server at the beginning of a command and closes it at the end. Currently defaults to True."
    inputBinding:
      position: 1
      valueFrom: '$(self === null ? null : (self ? "--enable_auto_server" : "--disable_auto_server"))'
  - id: use_postgres
    type:
      - 'null'
      - boolean
    doc: "If use_postgres is enabled, MFA uses PostgreSQL as the database backend instead of sqlite. Currently defaults to False."
    inputBinding:
      position: 1
      valueFrom: '$(self === null ? null : (self ? "--enable_use_postgres" : "--disable_use_postgres"))'
  - id: blas_num_threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use for BLAS libraries, 1 is recommended due to how much MFA relies on multiprocessing. Currently defaults to 1."
    inputBinding:
      position: 1
      prefix: --blas_num_threads
  - id: github_token
    type:
      - 'null'
      - string
    doc: "Github token to use for model downloading."
    inputBinding:
      position: 1
      prefix: --github_token
  - id: seed
    type:
      - 'null'
      - int
    doc: "Random seed to set for various pseudorandom processes."
    inputBinding:
      position: 1
      prefix: --seed
outputs:
  - id: mfa_root_out
    type: Directory
    doc: MFA root directory that holds the written configuration (global_config.yaml or the profile file).
    outputBinding:
      glob: mfa_root
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: mmcauliffe/montreal-forced-aligner:v3.4.3
stdout: montreal-forced-aligner_mfa_configure.out
