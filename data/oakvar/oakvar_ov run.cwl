cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - oakvar_ov
  - run
label: oakvar_ov run
doc: "Run OakVar on input files.\n\nTool homepage: http://www.oakvar.com"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: "Input file(s). One or more variant files in a\n                        supported
      format like VCF. See the -i/--input-format\n                        flag for
      supported formats. In the special case where\n                        you want
      to add annotations to an existing OakVar\n                        analysis,
      provide the output sqlite database from the\n                        previous
      run as input instead of a variant input file."
    inputBinding:
      position: 1
  - id: annotators
    type:
      - 'null'
      - type: array
        items: string
    doc: "Annotator module names or directories. If --package is\n               \
      \         used also, annotator modules defined with -a will be\n           \
      \             added. Use '-a all' to run all installed annotators."
    inputBinding:
      position: 102
      prefix: --annotators
  - id: annotators_replace
    type:
      - 'null'
      - type: array
        items: string
    doc: "Annotator module names or directories. If --package\n                  \
      \      option also is used, annotator modules defined with -A\n            \
      \            will replace those defined with --package. -A has\n           \
      \             priority over -a."
    inputBinding:
      position: 102
      prefix: --annotators-replace
  - id: clean_run
    type:
      - 'null'
      - boolean
    doc: "Deletes all previous output files for the job and\n                    \
      \    generate new ones."
    inputBinding:
      position: 102
      prefix: --cleanrun
  - id: combine_input
    type:
      - 'null'
      - boolean
    doc: Combine input files into one result
    inputBinding:
      position: 102
      prefix: --combine-input
  - id: confpath
    type:
      - 'null'
      - File
    doc: path to a conf file
    inputBinding:
      position: 102
      prefix: --confpath
  - id: converter_module
    type:
      - 'null'
      - string
    doc: Converter module
    inputBinding:
      position: 102
      prefix: --converter-module
  - id: delete_existing_db
    type:
      - 'null'
      - boolean
    doc: "deletes the existing result database and creates a new\n               \
      \         one."
    inputBinding:
      position: 102
      prefix: -x
  - id: endat
    type:
      - 'null'
      - string
    doc: ends after given stage.
    inputBinding:
      position: 102
      prefix: --endat
  - id: exclude_sample
    type:
      - 'null'
      - type: array
        items: string
    doc: Sample IDs to exclude
    inputBinding:
      position: 102
      prefix: --excludesample
  - id: excludes
    type:
      - 'null'
      - type: array
        items: string
    doc: modules to exclude
    inputBinding:
      position: 102
      prefix: --excludes
  - id: filter
    type:
      - 'null'
      - string
    doc: Path to a filter file
    inputBinding:
      position: 102
      prefix: --filter
  - id: filter_path
    type:
      - 'null'
      - File
    doc: Path to a filter file
    inputBinding:
      position: 102
      prefix: -f
  - id: filter_sql
    type:
      - 'null'
      - string
    doc: Filter SQL
    inputBinding:
      position: 102
      prefix: --filtersql
  - id: genome
    type:
      - 'null'
      - string
    doc: "reference genome of input. OakVar will lift over to\n                  \
      \      hg38 if needed."
    inputBinding:
      position: 102
      prefix: --genome
  - id: ignore_sample
    type:
      - 'null'
      - boolean
    doc: Ignore samples
    inputBinding:
      position: 102
      prefix: --ignore-sample
  - id: include_sample
    type:
      - 'null'
      - type: array
        items: string
    doc: Sample IDs to include
    inputBinding:
      position: 102
      prefix: --includesample
  - id: input_encoding
    type:
      - 'null'
      - string
    doc: Encoding of input files
    inputBinding:
      position: 102
      prefix: --input-encoding
  - id: input_format
    type:
      - 'null'
      - string
    doc: Force input format
    inputBinding:
      position: 102
      prefix: --input-format
  - id: job_name
    type:
      - 'null'
      - type: array
        items: string
    doc: Job ID for server version
    inputBinding:
      position: 102
      prefix: --job-name
  - id: keep_liftover_failed
    type:
      - 'null'
      - boolean
    doc: Keep variants that failed liftover
    inputBinding:
      position: 102
      prefix: --keep-liftover-failed
  - id: keep_ref
    type:
      - 'null'
      - boolean
    doc: Keep reference variants
    inputBinding:
      position: 102
      prefix: --keep-ref
  - id: keep_temp
    type:
      - 'null'
      - boolean
    doc: Leave temporary files after run is complete.
    inputBinding:
      position: 102
      prefix: --keep-temp
  - id: log_level
    type:
      - 'null'
      - string
    doc: Logging level (DEBUG, INFO, WARN, ERROR)
    inputBinding:
      position: 102
      prefix: --loglevel
  - id: log_to_file
    type:
      - 'null'
      - boolean
    doc: "Path to a log file. If given without a path, the job's\n               \
      \         run_name.log will be the log path."
    inputBinding:
      position: 102
      prefix: --logtofile
  - id: mapper_name
    type:
      - 'null'
      - type: array
        items: string
    doc: Mapper module name or mapper module directory
    inputBinding:
      position: 102
      prefix: --mapper-name
  - id: module_options
    type:
      - 'null'
      - type: array
        items: string
    doc: "Module-specific option in module_name.key=value\n                      \
      \  syntax. For example, --module-options\n                        vcfreporter.type=separate"
    inputBinding:
      position: 102
      prefix: --module-options
  - id: mp
    type:
      - 'null'
      - int
    doc: number of processes to use to run annotators
    inputBinding:
      position: 102
      prefix: --mp
  - id: new_log
    type:
      - 'null'
      - boolean
    doc: deletes the existing log file and creates a new one.
    inputBinding:
      position: 102
      prefix: --newlog
  - id: note
    type:
      - 'null'
      - string
    doc: note for the job
    inputBinding:
      position: 102
      prefix: --note
  - id: output_dir
    type:
      - 'null'
      - type: array
        items: Directory
    doc: directory for output files
    inputBinding:
      position: 102
      prefix: --output-dir
  - id: package
    type:
      - 'null'
      - string
    doc: Use package
    inputBinding:
      position: 102
      prefix: --package
  - id: postaggregators
    type:
      - 'null'
      - type: array
        items: string
    doc: "Postaggregators to run. Additionally, tagsampler and\n                 \
      \       vcfinfo will automatically run depending on\n                      \
      \  conditions."
    inputBinding:
      position: 102
      prefix: --postaggregators
  - id: preparers
    type:
      - 'null'
      - type: array
        items: string
    doc: "Names or directories of preparer modules, which will\n                 \
      \       be run in the given order."
    inputBinding:
      position: 102
      prefix: --preparers
  - id: primary_transcript
    type:
      - 'null'
      - type: array
        items: string
    doc: "\"mane\" for MANE transcripts as primary transcripts, or\n             \
      \           a path to a file of primary transcripts. MANE is\n             \
      \           default."
    inputBinding:
      position: 102
      prefix: --primary-transcript
  - id: report_types
    type:
      - 'null'
      - type: array
        items: string
    doc: Reporter types or reporter module directories
    inputBinding:
      position: 102
      prefix: --report-types
  - id: run_name
    type:
      - 'null'
      - type: array
        items: string
    doc: name of oakvar run
    inputBinding:
      position: 102
      prefix: --run-name
  - id: separate_sample
    type:
      - 'null'
      - boolean
    doc: Separate variant results by sample
    inputBinding:
      position: 102
      prefix: --separatesample
  - id: skip
    type:
      - 'null'
      - type: array
        items: string
    doc: skips given stage(s).
    inputBinding:
      position: 102
      prefix: --skip
  - id: skip_variant_deduplication
    type:
      - 'null'
      - boolean
    doc: Skip de-duplication of variants
    inputBinding:
      position: 102
      prefix: --skip-variant-deduplication
  - id: startat
    type:
      - 'null'
      - string
    doc: starts at given stage
    inputBinding:
      position: 102
      prefix: --startat
  - id: system_option
    type:
      - 'null'
      - type: array
        items: string
    doc: "System option in key=value syntax. For example,\n                      \
      \  --system-option modules_dir=/home/user/oakvar/modules"
    inputBinding:
      position: 102
      prefix: --system-option
  - id: uid
    type:
      - 'null'
      - string
    doc: Optional UID of the job
    inputBinding:
      position: 102
      prefix: --uid
  - id: vcf2vcf
    type:
      - 'null'
      - boolean
    doc: "analyze with the vcf to vcf workflow. It is faster\n                   \
      \     than a normal run, but only if both input and output\n               \
      \         formats are VCF."
    inputBinding:
      position: 102
      prefix: --vcf2vcf
  - id: write_admin_db
    type:
      - 'null'
      - boolean
    doc: Write job information to admin db after job completion
    inputBinding:
      position: 102
      prefix: --writeadmindb
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oakvar:2.12.25--pyhdfd78af_0
stdout: oakvar_ov run.out
