cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gemBS
  - map
label: gembs_gemBS map
doc: "Maps single end or paired end bisulfite sequence using the GEM3 mapper. By default
  the map command will try and perform mapping on all datafiles that it knows about
  that have not already been mapped. If all datafiles for a sample have been mapped
  then the map command will merge the BAM files if multiple BAMs exist for the sample.
  The resulting BAM will then be indexed and the md5 sum calculated. If the option
  --remove is set or 'remove_individual_bams' is set to True in the configuration
  file then the individual BAM files will be deleted after the merge step has been
  successfully completed. The --no-merge options will prevent this automatic merging
  - this can be useful for batch processing. Aside from the --no-merge option, if
  no disk based database is being used for gemBS and separate instances of gemBS are
  being run on non- shared file systems then the merging will not always be performed
  automatically. When the merging is not performed automatically for whatever reason,
  it can be invoked manually using the merge-bams command. The mapping process can
  be restricted to a single sample using the option '-n <SAMPLE NAME>' or '-b <SAMPLE
  BARCODE>'. The mapping can also be restricted to a single dataset ID using the option
  '-D <DATASET>' The locations of the input and output data are given by the configuration
  files; see the gemBS documentation for details. The --dry-run option will output
  a list of the mapping / merging operations that would be run by the map command
  without executing any of the commands. The --json <JSON OUTPUT> options is similar
  to --dry-run, but writes the commands to be executed in JSON format to the supplied
  output file, including information about the input and output files for the commands.
  The --ignore-db option modifies the --dry-run and --json options such that the database
  is not consulted (i.e., gemBS assumes that nothing has already been completed.\n\
  \nTool homepage: https://github.com/heathsc/gemBS"
inputs:
  - id: barcode
    type:
      - 'null'
      - string
    doc: Barcode of sample to be mapped.
    inputBinding:
      position: 101
      prefix: --barcode
  - id: benchmark_mode
    type:
      - 'null'
      - boolean
    doc: Omit dates etc. to make file comparison simpler
    inputBinding:
      position: 101
      prefix: --benchmark-mode
  - id: dataset
    type:
      - 'null'
      - string
    doc: Dataset to be mapped.
    inputBinding:
      position: 101
      prefix: --dataset
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Output mapping commands without execution
    inputBinding:
      position: 101
      prefix: --dry-run
  - id: ignore_db
    type:
      - 'null'
      - boolean
    doc: Ignore database for --dry-run and --json commands
    inputBinding:
      position: 101
      prefix: --ignore-db
  - id: map_threads
    type:
      - 'null'
      - int
    doc: Number of threads for GEM mapper.
    default: threads
    inputBinding:
      position: 101
      prefix: --map-threads
  - id: merge_threads
    type:
      - 'null'
      - int
    doc: Number of threads for the merge operations.
    default: threads
    inputBinding:
      position: 101
      prefix: --merge-threads
  - id: no_merge
    type:
      - 'null'
      - boolean
    doc: Do not automatically merge BAMs
    inputBinding:
      position: 101
      prefix: --no-merge
  - id: non_bs
    type:
      - 'null'
      - boolean
    doc: Use regular (non bisulfite) index
    inputBinding:
      position: 101
      prefix: --non-bs
  - id: overconversion_sequence
    type:
      - 'null'
      - string
    doc: Name of methylated sequencing control.
    inputBinding:
      position: 101
      prefix: --overconversion-sequence
  - id: paired_end
    type:
      - 'null'
      - boolean
    doc: Input data is Paired End
    inputBinding:
      position: 101
      prefix: --paired-end
  - id: read_non_stranded
    type:
      - 'null'
      - boolean
    doc: Automatically selects the proper C->T and G->A read conversions based 
      on the level of Cs and Gs on the read.
    inputBinding:
      position: 101
      prefix: --read-non-stranded
  - id: remove
    type:
      - 'null'
      - boolean
    doc: Remove individual BAM files after merging.
    inputBinding:
      position: 101
      prefix: --remove
  - id: reverse_conversion
    type:
      - 'null'
      - boolean
    doc: Perform G2A conversion on read 1 and C2T on read 2 rather than the 
      reverse.
    inputBinding:
      position: 101
      prefix: --reverse-conversion
  - id: sample_name
    type:
      - 'null'
      - string
    doc: Name of sample to be mapped.
    inputBinding:
      position: 101
      prefix: --sample-name
  - id: sort_memory
    type:
      - 'null'
      - string
    doc: Per thread memory used for the sort operation.
    default: 768M
    inputBinding:
      position: 101
      prefix: --sort-memory
  - id: sort_threads
    type:
      - 'null'
      - int
    doc: Number of threads for the sort operations.
    default: threads
    inputBinding:
      position: 101
      prefix: --sort-threads
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads for the mapping pipeline.
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Temporary folder to perform sorting operations.
    default: /tmp
    inputBinding:
      position: 101
      prefix: --tmp-dir
  - id: type
    type:
      - 'null'
      - string
    doc: Type of data file (PAIRED, SINGLE, INTERLEAVED, STREAM, BAM)
    inputBinding:
      position: 101
      prefix: --type
  - id: underconversion_sequence
    type:
      - 'null'
      - string
    doc: Name of unmethylated sequencing control.
    inputBinding:
      position: 101
      prefix: --underconversion-sequence
outputs:
  - id: json_file
    type:
      - 'null'
      - File
    doc: Output JSON file with details of pending commands
    outputBinding:
      glob: $(inputs.json_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gembs:3.5.5_IHEC--py39h6859054_8
