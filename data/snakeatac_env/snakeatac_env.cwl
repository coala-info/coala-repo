cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakeatac_env
label: snakeatac_env
doc: "Environment variables for snakeatac\n\nTool homepage: https://github.com/sebastian-gregoricchio/snakeATAC"
inputs:
  - id: conda_default_env
    type:
      - 'null'
      - Directory
    doc: CONDA_DEFAULT_ENV environment variable
    inputBinding:
      position: 101
      prefix: --conda-default-env
  - id: conda_prefix
    type:
      - 'null'
      - Directory
    doc: CONDA_PREFIX environment variable
    inputBinding:
      position: 101
      prefix: --conda-prefix
  - id: conda_prompt_modifier
    type:
      - 'null'
      - string
    doc: CONDA_PROMPT_MODIFIER environment variable
    inputBinding:
      position: 101
      prefix: --conda-prompt-modifier
  - id: conda_shlvl
    type:
      - 'null'
      - int
    doc: CONDA_SHLVL environment variable
    inputBinding:
      position: 101
      prefix: --conda-shlvl
  - id: gsettings_schema_dir
    type:
      - 'null'
      - Directory
    doc: GSETTINGS_SCHEMA_DIR environment variable
    inputBinding:
      position: 101
      prefix: --gsettings-schema-dir
  - id: gsettings_schema_dir_conda_backup
    type:
      - 'null'
      - string
    doc: GSETTINGS_SCHEMA_DIR_CONDA_BACKUP environment variable
    inputBinding:
      position: 101
      prefix: --gsettings-schema-dir-conda-backup
  - id: home
    type:
      - 'null'
      - Directory
    doc: HOME environment variable
    inputBinding:
      position: 101
      prefix: --home
  - id: hostname
    type:
      - 'null'
      - string
    doc: Hostname of the environment
    inputBinding:
      position: 101
      prefix: --hostname
  - id: java_home
    type:
      - 'null'
      - Directory
    doc: JAVA_HOME environment variable
    inputBinding:
      position: 101
      prefix: --java-home
  - id: java_ld_library_path
    type:
      - 'null'
      - string
    doc: JAVA_LD_LIBRARY_PATH environment variable
    inputBinding:
      position: 101
      prefix: --java-ld-library-path
  - id: lang
    type:
      - 'null'
      - string
    doc: LANG environment variable
    inputBinding:
      position: 101
      prefix: --lang
  - id: path
    type:
      - 'null'
      - string
    doc: PATH environment variable
    inputBinding:
      position: 101
      prefix: --path
  - id: pwd
    type:
      - 'null'
      - Directory
    doc: Current working directory
    inputBinding:
      position: 101
      prefix: --pwd
  - id: rstudio_which_r
    type:
      - 'null'
      - File
    doc: RSTUDIO_WHICH_R environment variable
    inputBinding:
      position: 101
      prefix: --rstudio-which-r
  - id: shlvl
    type:
      - 'null'
      - int
    doc: SHLVL environment variable
    inputBinding:
      position: 101
      prefix: --shlvl
  - id: xml_catalog_files
    type:
      - 'null'
      - string
    doc: XML_CATALOG_FILES environment variable
    inputBinding:
      position: 101
      prefix: --xml-catalog-files
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakeatac_env:0.1.1--pyha70a07d_0
stdout: snakeatac_env.out
