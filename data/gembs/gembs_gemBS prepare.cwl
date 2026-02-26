cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gemBS
  - prepare
label: gembs_gemBS prepare
doc: "Sets up pipeline directories and controls files. Input Files: Two files are
  required, a configuration file describing the model parameters and analysis directory
  structure, and second file describing the sample metadata and associated data files.
  The sample file will normally be a text file in CSV format with a header line, although
  there is also the option to import a JSON file from the CNAG LIMS. A full description
  of the input file formats can be found in the gemBS documentation. The prepare command
  reads in the configuration files and writes a JSON file with the data from both
  files, that is used by the subsequent gemBS commands. Any parameters supplied in
  the configuration files is used as the default by the other gemBS commands, so judicious
  use can prevent a lot of typing and help standardize analyses. The prepare command
  will then check that the mimum required information has been provided, and will
  check for the existence of key input files (notable the genome reference fasta file).
  A persistant (disk-based) sqlite3 database is used by default so that gemBS can
  track at what stage the pipeline has reached and handle pipeline steps that failed.
  This allows normal operation and restarting of the pipeline to be achieved using
  minimal input from the user. The use of the disk-base database is recommended for
  normal operations but does require a shared filesystem (that supports non-local
  file locks) across all instances of gemBS that are running on the same datafiles.
  If this is not the case then this can be turned off using the --no-db option. Use
  of this option will require that the user tracks the state of the analysis themselves.
  Note that if multiple instances of gemBS are run simultaneously on common analysis
  directories (i.e., using a shared filesystem, stroing output files in the same locations)
  then the disk based database must be used to avoid interference between the different
  gemBS instances. By default the database (if used) is stored in the file .gemBS/gemBS.db
  and the output JSON file is stored in .gemBS/gemBS.json. If the -no-db option is
  set then the JSON file will be stored to the file gemBS.json in the current directory.
  The --output option can be used to specify an alternate locationn for the JSON file
  and the --db-file option can specify an alternate locaiton for the database file.
  The database location is stored in the JSON file so that it can be recovered by
  subsequent calls to gemBS. However if the default location is not used for the JSON
  file them it will be necessary to specify the location of the JSON file for each
  gemBS command. It is therefore advised to stay with the default option if possible.\n\
  \nTool homepage: https://github.com/heathsc/gemBS"
inputs:
  - id: config
    type: File
    doc: Text config file with gemBS parameters.
    inputBinding:
      position: 101
      prefix: --config
  - id: db_file
    type:
      - 'null'
      - File
    doc: Specify location for database file.
    inputBinding:
      position: 101
      prefix: --db-file
  - id: lims_cnag_json
    type:
      - 'null'
      - File
    doc: Lims CNAG subproject JSON file.
    inputBinding:
      position: 101
      prefix: --lims-cnag-json
  - id: no_db
    type:
      - 'null'
      - boolean
    doc: Do not use disk base database.
    inputBinding:
      position: 101
      prefix: --no-db
  - id: text_metadata
    type:
      - 'null'
      - File
    doc: Sample metadata in csv file. See documentation for description of file 
      format.
    inputBinding:
      position: 101
      prefix: --text-metadata
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output JSON file. See documentation for description of file format.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gembs:3.5.5_IHEC--py39h6859054_8
