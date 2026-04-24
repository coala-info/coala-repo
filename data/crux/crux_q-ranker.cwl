cwlVersion: v1.2
class: CommandLineTool
baseCommand: crux q-ranker
label: crux_q-ranker
doc: "Rank fragmentation spectra using search results.\n\nTool homepage: https://github.com/redbadger/crux"
inputs:
  - id: fragmentation_spectra
    type: File
    doc: The fragmentation spectra must be provided in MS2, mzXML, or MGF 
      format.
    inputBinding:
      position: 1
  - id: search_results
    type: File
    doc: Search results in the tab-delimited text format produced by Crux or in 
      SQT format. Like the spectra, the search results can be provided as a 
      single file, a list of files or a directory of files. Note, however, that 
      the input mode for spectra and for search results must be the same; i.e., 
      if you provide a list of files for the spectra, then you must also provide
      a list of files containing your search results. When the MS2 files and 
      tab-delimited text files are provided via a file listing, it is assumed 
      that the order of the MS2 files matches the order of the tab-delimited 
      files. Alternatively, when the MS2 files and tab-delimited files are 
      provided via directories, the program will search for pairs of files with 
      the same root name but different extensions (".ms2" and ".txt").
    inputBinding:
      position: 2
  - id: decoy_prefix
    type:
      - 'null'
      - string
    doc: Specifies the prefix of the protein names that indicate a decoy.
    inputBinding:
      position: 103
      prefix: --decoy-prefix
  - id: enzyme
    type:
      - 'null'
      - string
    doc: 'Specify the enzyme used to digest the proteins in silico. Available enzymes
      (with the corresponding digestion rules indicated in parentheses) include no-enzyme
      ([X]|[X]), trypsin ([RK]|{P}), trypsin/p ([RK]|[]), chymotrypsin ([FWYL]|{P}),
      elastase ([ALIV]|{P}), clostripain ([R]|[]), cyanogen-bromide ([M]|[]), iodosobenzoate
      ([W]|[]), proline-endopeptidase ([P]|[]), staph-protease ([E]|[]), asp-n ([]|[D]),
      lys-c ([K]|{P}), lys-n ([]|[K]), arg-c ([R]|{P}), glu-c ([DE]|{P}), pepsin-a
      ([FL]|{P}), elastase-trypsin-chymotrypsin ([ALIVKRWFY]|{P}). Specifying --enzyme
      no-enzyme yields a non-enzymatic digest. Warning: the resulting index may be
      quite large.'
    inputBinding:
      position: 103
      prefix: --enzyme
  - id: feature_file_out
    type:
      - 'null'
      - boolean
    doc: Output the computed features in tab-delimited Percolator input (.pin) 
      format. The features will be normalized, using either unit norm or 
      standard deviation normalization (depending upon the value of the 
      unit-norm option).
    inputBinding:
      position: 103
      prefix: --feature-file-out
  - id: fileroot
    type:
      - 'null'
      - string
    doc: The fileroot string will be added as a prefix to all output file names.
    inputBinding:
      position: 103
      prefix: --fileroot
  - id: list_of_files
    type:
      - 'null'
      - boolean
    doc: Specify that the search results are provided as lists of files, rather 
      than as individual files.
    inputBinding:
      position: 103
      prefix: --list-of-files
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: The name of the directory where output files will be created.
    inputBinding:
      position: 103
      prefix: --output-dir
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Replace existing files if true or fail when trying to overwrite a file 
      if false.
    inputBinding:
      position: 103
      prefix: --overwrite
  - id: parameter_file
    type:
      - 'null'
      - File
    doc: A file containing parameters.
    inputBinding:
      position: 103
      prefix: --parameter-file
  - id: pepxml_output
    type:
      - 'null'
      - boolean
    doc: Output a pepXML results file to the output directory.
    inputBinding:
      position: 103
      prefix: --pepxml-output
  - id: re_run
    type:
      - 'null'
      - string
    doc: Re-run a previous analysis using a previously computed set of lookup 
      tables. For this option to work, the --skip-cleanup option must have been 
      set to true when the program was run the first time.
    inputBinding:
      position: 103
      prefix: --re-run
  - id: separate_searches
    type:
      - 'null'
      - string
    doc: If the target and decoy searches were run separately, rather than using
      a concatenated database, then the program will assume that the database 
      search results provided as a required argument are from the target 
      database search. This option then allows the user to specify the location 
      of the decoy search results. Like the required arguments, these search 
      results can be provided as a single file, a list of files or a directory. 
      However, the choice (file, list or directory) must be consistent for the 
      MS2 files and the target and decoy tab-delimited files. Also, if the MS2 
      and tab-delimited files are provided in directories, then Q-ranker will 
      use the MS2 filename (foo.ms2) to identify corresponding target and decoy 
      tab-delimited files with names like foo*.target.txt and foo*.decoy.txt. 
      This naming convention allows the target and decoy txt files to reside in 
      the same directory.
    inputBinding:
      position: 103
      prefix: --separate-searches
  - id: skip_cleanup
    type:
      - 'null'
      - boolean
    doc: Analysis begins with a pre-processsing step that creates a set of 
      lookup tables which are then used during training. Normally, these lookup 
      tables are deleted at the end of the analysis, but setting this option to 
      T prevents the deletion of these tables. Subsequently, analyses can be 
      repeated more efficiently by specifying the --re-run option.
    inputBinding:
      position: 103
      prefix: --skip-cleanup
  - id: spectrum_parser
    type:
      - 'null'
      - string
    doc: Specify the parser to use for reading in MS/MS spectra.
    inputBinding:
      position: 103
      prefix: --spectrum-parser
  - id: txt_output
    type:
      - 'null'
      - boolean
    doc: Output a tab-delimited results file to the output directory.
    inputBinding:
      position: 103
      prefix: --txt-output
  - id: use_spec_features
    type:
      - 'null'
      - boolean
    doc: Use an enriched feature set, including separate features for each ion 
      type.
    inputBinding:
      position: 103
      prefix: --use-spec-features
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Specify the verbosity of the current processes. Each level prints the following
      messages, including all those at lower verbosity levels: 0-fatal errors, 10-non-fatal
      errors, 20-warnings, 30-information on the progress of execution, 40-more progress
      information, 50-debug info, 60-detailed debug info.'
    inputBinding:
      position: 103
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/crux:v3.2_cv3
stdout: crux_q-ranker.out
