cwlVersion: v1.2
class: CommandLineTool
baseCommand: [searchgui, eu.isas.searchgui.cmd.SearchCLI]
label: searchgui_search_cli
doc: "SearchCLI searches spectrum files according to search parameters using multiple search engines.\n\nTool homepage: https://github.com/compomics/searchgui"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.output_folder)
        entry: "$({class: 'Directory', listing: []})"
        writable: true
      - entryname: $(inputs.temp_folder)
        entry: "$({class: 'Directory', listing: []})"
        writable: true
inputs:
  - id: spectrum_files
    type: 
      type: array
      items: File
    doc: "Spectrum files (mgf or mzml), comma separated list or an entire folder."
    inputBinding:
      position: 1
      prefix: -spectrum_files
      itemSeparator: ","
  - id: fasta_file
    type: File
    doc: "The complete path to the FASTA file."
    inputBinding:
      position: 1
      prefix: -fasta_file
  - id: output_folder
    type: string
    doc: "The output folder."
    inputBinding:
      position: 1
      prefix: -output_folder
  - id: id_params
    type: File
    doc: "The identification parameters file to use."
    inputBinding:
      position: 1
      prefix: -id_params
  - id: omssa
    type: ['null', int]
    doc: "Turn the OMSSA search on or off (0: off, 1: on,  default is '0')."
    inputBinding:
      position: 1
      prefix: -omssa
  - id: xtandem
    type: ['null', int]
    doc: "Turn the X!Tandem search on or off (0: off, 1: on, default is '0')."
    inputBinding:
      position: 1
      prefix: -xtandem
  - id: msgf
    type: ['null', int]
    doc: "Turn the MS-GF+ search on or off (0: off, 1: on, default is '0')."
    inputBinding:
      position: 1
      prefix: -msgf
  - id: ms_amanda
    type: ['null', int]
    doc: "Turn the MS Amanda search on or off (0: off, 1: on, default is '0')."
    inputBinding:
      position: 1
      prefix: -ms_amanda
  - id: myrimatch
    type: ['null', int]
    doc: "Turn the MyriMatch search on or off (0: off,1: on,  default is '0')."
    inputBinding:
      position: 1
      prefix: -myrimatch
  - id: comet
    type: ['null', int]
    doc: "Turn the Comet search on or off (0: off, 1: on, default is '0')."
    inputBinding:
      position: 1
      prefix: -comet
  - id: tide
    type: ['null', int]
    doc: "Turn the Tide search on or off (0: off, 1: on, default is '0')."
    inputBinding:
      position: 1
      prefix: -tide
  - id: andromeda
    type: ['null', int]
    doc: "Turn the Andromeda search on or off (0: off, 1: on, default is '0')."
    inputBinding:
      position: 1
      prefix: -andromeda
  - id: meta_morpheus
    type: ['null', int]
    doc: "Turn the MetaMorpheus search on or off (0: off, 1: on, default is '0')."
    inputBinding:
      position: 1
      prefix: -meta_morpheus
  - id: novor
    type: ['null', int]
    doc: "Turn the Novor sequencing on or off (0: off, 1: on, default is '0')."
    inputBinding:
      position: 1
      prefix: -novor
  - id: directag
    type: ['null', int]
    doc: "Turn the DirecTag sequencing on or off (0: off, 1: on, default is '0')."
    inputBinding:
      position: 1
      prefix: -directag
  - id: omssa_folder
    type: ['null', string]
    doc: "The folder where OMSSA is installed, defaults to the provided version for the given OS."
    inputBinding:
      position: 1
      prefix: -omssa_folder
  - id: xtandem_folder
    type: ['null', string]
    doc: "The folder where X!Tandem is installed, defaults to the provided version for the given OS."
    inputBinding:
      position: 1
      prefix: -xtandem_folder
  - id: msgf_folder
    type: ['null', string]
    doc: "The folder where MS-GF+ is installed, defaults to the included version."
    inputBinding:
      position: 1
      prefix: -msgf_folder
  - id: ms_amanda_folder
    type: ['null', string]
    doc: "The folder where MS Amanda is installed, defaults to the included version."
    inputBinding:
      position: 1
      prefix: -ms_amanda_folder
  - id: myrimatch_folder
    type: ['null', string]
    doc: "The folder where MyriMatch is installed, defaults to the included version."
    inputBinding:
      position: 1
      prefix: -myrimatch_folder
  - id: comet_folder
    type: ['null', string]
    doc: "The folder where Comet is installed, defaults to the included version."
    inputBinding:
      position: 1
      prefix: -comet_folder
  - id: tide_folder
    type: ['null', string]
    doc: "The folder where Tide is installed, defaults to the included version."
    inputBinding:
      position: 1
      prefix: -tide_folder
  - id: tide_index_file
    type: ['null', string]
    doc: "The folder where the Tide index should be stored. If this option is provided and the folder is not found, an index will be created in this folder and not deleted so that the index can be reused in subsequent runs. If this option is provided and the index is found, the creation of the index will be skipped. If this option is not provided, the index will always be created and stored either in the Tide or the temp folder and handled according to the Tide advanced parameters."
    inputBinding:
      position: 1
      prefix: -tide_index_file
  - id: andromeda_folder
    type: ['null', string]
    doc: "The folder where Andromeda is installed, defaults to the included version."
    inputBinding:
      position: 1
      prefix: -andromeda_folder
  - id: meta_morpheus_folder
    type: ['null', string]
    doc: "The folder where MetaMorpheus is installed, defaults to the included version."
    inputBinding:
      position: 1
      prefix: -meta_morpheus_folder
  - id: novor_folder
    type: ['null', string]
    doc: "The folder where Novor is installed, defaults to the included version."
    inputBinding:
      position: 1
      prefix: -novor_folder
  - id: directag_folder
    type: ['null', string]
    doc: "The folder where DirecTag is installed, defaults to the included version."
    inputBinding:
      position: 1
      prefix: -directag_folder
  - id: makeblastdb_folder
    type: ['null', string]
    doc: "The folder where makeblastdb is installed, defaults to the provided version for the given OS."
    inputBinding:
      position: 1
      prefix: -makeblastdb_folder
  - id: mgf_check_size
    type: ['null', int]
    doc: "Turn the mgf size check on or off (0: off, 1: on, default is '0')."
    inputBinding:
      position: 1
      prefix: -mgf_check_size
  - id: mgf_splitting
    type: ['null', int]
    doc: "The maximum mgf file size in MB before splitting the mgf. Default is '1000'."
    inputBinding:
      position: 1
      prefix: -mgf_splitting
  - id: mgf_spectrum_count
    type: ['null', int]
    doc: "The maximum number of spectra per mgf file when splitting. Default is '25000'."
    inputBinding:
      position: 1
      prefix: -mgf_spectrum_count
  - id: correct_titles
    type: ['null', int]
    doc: "Correct for duplicate spectrum titles. (0: no correction, 1: rename spectra, 2: delete spectra, default is '1')."
    inputBinding:
      position: 1
      prefix: -correct_titles
  - id: missing_titles
    type: ['null', int]
    doc: "Add missing spectrum titles. (0: no correction, 1: add missing spectrum titles, default is '0')."
    inputBinding:
      position: 1
      prefix: -missing_titles
  - id: output_default_name
    type: ['null', string]
    doc: "Optional output default name, default is 'searchgui_out'."
    inputBinding:
      position: 1
      prefix: -output_default_name
  - id: output_gzip
    type: ['null', int]
    doc: "Gzip result files (0: no, 1: yes, default is '1')."
    inputBinding:
      position: 1
      prefix: -output_gzip
  - id: output_option
    type: ['null', int]
    doc: "Optional result file packaging (0: Group all files in a single compressed zip folder, 1: Group files per run (i.e. spectrum file), 2: Group files per identification algorithm, 3: No file grouping), default is '0'."
    inputBinding:
      position: 1
      prefix: -output_option
  - id: output_data
    type: ['null', int]
    doc: "Include mgf and FASTA file in zipped output (0: no, 1: yes, default is '0')."
    inputBinding:
      position: 1
      prefix: -output_data
  - id: output_date
    type: ['null', int]
    doc: "Include date in output name (0: no, 1: yes, default is '0')."
    inputBinding:
      position: 1
      prefix: -output_date
  - id: rename_xtandem
    type: ['null', int]
    doc: "Turn the renaming of the X! Tandem files on/off. (0: off, 1: on, default is '1')."
    inputBinding:
      position: 1
      prefix: -rename_xtandem
  - id: threads
    type: ['null', int]
    doc: "Number of threads to use for the processing, default: the number of cores."
    inputBinding:
      position: 1
      prefix: -threads
  - id: ref_mass
    type: ['null', int]
    doc: "Reference mass for the conversion of the fragment ion tolerance from ppm to Dalton. Default is '2000'."
    inputBinding:
      position: 1
      prefix: -ref_mass
  - id: temp_folder
    type: string
    default: searchgui_tmp
    doc: "A folder for temporary file storage. Use only if you encounter problems with the default configuration."
    inputBinding:
      position: 1
      prefix: -temp_folder
  - id: config_folder
    type: ['null', string]
    doc: "The config folder."
    inputBinding:
      position: 1
      prefix: -config_folder
outputs:
  - id: output_dir
    type: Directory
    doc: Output folder with the search results
    outputBinding:
      glob: $(inputs.output_folder)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/searchgui:4.3.15--hdfd78af_0
stdout: searchgui_search_cli.out
