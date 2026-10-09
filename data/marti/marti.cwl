cwlVersion: v1.2
class: CommandLineTool
baseCommand: marti
label: marti
doc: "Metagenomic Analysis in Real TIme (MARTi) Engine\n\nTool homepage: https://github.com/richardmleggett/MARTi"
inputs:
  - id: config_file
    type:
      - 'null'
      - File
    doc: Configuration file for MARTi analysis. MARTi needs absolute paths for
      RawDataDir and SampleDir. Write @WORKDIR@ in the config and it is
      replaced with the job working directory, where support_dirs and
      support_files are staged (e.g. RawDataDir:@WORKDIR@/raw).
    loadContents: true
    inputBinding:
      position: 101
      prefix: -config
      valueFrom: marti_config.txt
  - id: fix_random_seed
    type:
      - 'null'
      - long
    doc: Fix the random number seed used for debugging
    inputBinding:
      position: 101
      prefix: -fixrandom
  - id: init_mode
    type:
      - 'null'
      - boolean
    doc: Enter initialisation mode and output version information.
    inputBinding:
      position: 101
      prefix: -init
  - id: log_level
    type:
      - 'null'
      - int
    doc: Set the level of logging to logs/engine.txt from 0 (none) to 5 
      (maximum)
    inputBinding:
      position: 101
      prefix: -loglevel
  - id: options_file
    type:
      - 'null'
      - File
    doc: Specify the location of a marti_engine_options.txt file to use.
    inputBinding:
      position: 101
      prefix: -options
  - id: slurm_partition
    type:
      - 'null'
      - string
    doc: Set default SLURM partition
    inputBinding:
      position: 101
      prefix: -queue
  - id: write_config_file
    type:
      - 'null'
      - string
    doc: Generate a new config file
    inputBinding:
      position: 101
      prefix: -writeconfig
  - id: write_options_file
    type:
      - 'null'
      - string
    doc: Generate a new options file
    inputBinding:
      position: 101
      prefix: -writeoptions
  - id: support_dirs
    type:
      - 'null'
      - type: array
        items: Directory
    doc: Directories named in the config (reads folder, taxonomy, databases), 
      staged in the working directory.
  - id: support_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files named in the config (for example BLAST database files), staged
      in the working directory.
  - id: sample_dir
    type:
      - 'null'
      - string
    doc: Name of the SampleDir folder the config writes inside the working 
      directory (for example sample_out). Only used to collect the results.
outputs:
  - id: config_out
    type:
      - 'null'
      - File
    doc: Config file written by -writeconfig
    outputBinding:
      glob: $(inputs.write_config_file)
  - id: options_out
    type:
      - 'null'
      - File
    doc: Options file written by -writeoptions
    outputBinding:
      glob: $(inputs.write_options_file)
  - id: sample_dir_out
    type:
      - 'null'
      - Directory
    doc: SampleDir written by the analysis (logs, results)
    outputBinding:
      glob: $(inputs.sample_dir)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: marti_config.txt
        entry: "$(inputs.config_file ? inputs.config_file.contents.split('@WORKDIR@').join(runtime.outdir)
          : null)"
      - $(inputs.support_dirs)
      - $(inputs.support_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/marti:0.9.29--hdfd78af_0
stdout: marti.out
