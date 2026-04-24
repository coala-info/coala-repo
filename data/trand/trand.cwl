cwlVersion: v1.2
class: CommandLineTool
baseCommand: trand
label: trand
doc: "Perform transcript distance, complexity and transcriptome comparison analyses.\n\
  \nTool homepage: https://github.com/McIntyre-Lab/TranD"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: One or two input GTF file(s).
    inputBinding:
      position: 1
  - id: complexity_only
    type:
      - 'null'
      - boolean
    doc: "Used with 1 or 2 GTF input file(s). Output only complexity measures. If
      used in presence of the '-- consolidate' flag, complexity is calculated on the
      consolidated GTF(s). Default: Perform all analyses and comparisons including
      complexity calculations"
    inputBinding:
      position: 102
      prefix: --complexityOnly
  - id: consol_prefix
    type:
      - 'null'
      - string
    doc: Used with 1 GTF input file. Requires '--consolidate' flag. Specify the 
      prefix to use for consolidated transcript_id values. Prefix must be 
      alphanumeric with no spaces. Underscore ("_") is the only allowed special 
      character.
    inputBinding:
      position: 102
      prefix: --consolPrefix
  - id: consolidate
    type:
      - 'null'
      - boolean
    doc: "Used with 1 GTF input file. Consolidate transcripts remove 5'/3' transcript
      end variation in redundantly spliced transcripts) with identical junctions prior
      to complexity calculations, events and summary plotting. Default: No consolidation"
    inputBinding:
      position: 102
      prefix: --consolidate
  - id: cpu_cores
    type:
      - 'null'
      - int
    doc: Number of CPU cores to use for parallelization.
    inputBinding:
      position: 102
      prefix: --cpus
  - id: ea
    type:
      - 'null'
      - string
    doc: 'Specify type of within gene transcript comparison: pairwise - Used with
      1 or 2 GTF input files. Compare pairs of transcripts within a gene. gene - Used
      iwth 1 GTF input file. Compare all transcripts within a gene'
    inputBinding:
      position: 102
      prefix: --ea
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite existing output directory and files within.
    inputBinding:
      position: 102
      prefix: --force
  - id: keepir
    type:
      - 'null'
      - boolean
    doc: 'Keep transcripts with Intron Retention(s) when generating transcript events.
      Only used with 1 GTF input file. Default: remove'
    inputBinding:
      position: 102
      prefix: --keepir
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log file name for logging processing events to file.
    inputBinding:
      position: 102
      prefix: --logfile
  - id: name1
    type:
      - 'null'
      - string
    doc: Used with 2 GTF input files. User-specified name to be used for 
      labeling output files related to the first GTF file. Name must be 
      alphanumeric, can only include "_" special character and not contain any 
      spaces.
    inputBinding:
      position: 102
      prefix: --name1
  - id: name2
    type:
      - 'null'
      - string
    doc: Used with 2 GTF input files. User-specified name to be used for 
      labeling output files related to the second GTF file. Name must be 
      alphanumeric, can only include "_" special character and not contain any 
      spaces.
    inputBinding:
      position: 102
      prefix: --name2
  - id: pairs
    type:
      - 'null'
      - string
    doc: 'Used with 2 GTF input files. The TranD metrics can be for all transcript
      pairs in both GTF files or for a subset of transcript pairs using the following
      options: both - Trand metrics for the minimum pairs in both GTF files, first
      - TranD metrics for the minimum pairs in the first GTF file, second - TranD
      metrics for the minimum pairs in the second GTF file all - TranD metrics for
      all transcript pairs in both GTF files'
    inputBinding:
      position: 102
      prefix: --pairs
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Output prefix of various output files. \" Default: no prefix for 1GTF, 'name1_vs_name2'
      for 2GTF."
    inputBinding:
      position: 102
      prefix: --prefix
  - id: skip_intermediate
    type:
      - 'null'
      - boolean
    doc: Skip intermediate file output (junction and exon region/fragment 
      files).
    inputBinding:
      position: 102
      prefix: --skip-intermediate
  - id: skip_plots
    type:
      - 'null'
      - boolean
    doc: Skip generation of all plots.
    inputBinding:
      position: 102
      prefix: --skip-plots
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory, created if missing.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trand:22.10.13--pyhdfd78af_0
