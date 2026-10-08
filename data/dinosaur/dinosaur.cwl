cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dinosaur
label: dinosaur
doc: "Analyze MzML files for isotope patterns.\n\nTool homepage: https://github.com/fickludd/dinosaur"
inputs:
  - id: mzml_file
    type: File
    doc: The shotgun MzML file to analyze
    inputBinding:
      position: 200
  - id: adv_params
    type:
      - 'null'
      - File
    doc: path to adv param file
    inputBinding:
      position: 102
      prefix: --advParams=
      separate: false
  - id: concurrency
    type:
      - 'null'
      - int
    doc: the number of assays to analyze in parallel
    inputBinding:
      position: 102
      prefix: --concurrency=
      separate: false
  - id: force
    type:
      - 'null'
      - boolean
    doc: ignore missing mzML params
    inputBinding:
      position: 102
      prefix: --force
  - id: max_charge
    type:
      - 'null'
      - int
    doc: max searched ion charge
    inputBinding:
      position: 102
      prefix: --maxCharge=
      separate: false
  - id: min_charge
    type:
      - 'null'
      - int
    doc: min searched ion charge
    inputBinding:
      position: 102
      prefix: --minCharge=
      separate: false
  - id: mode
    type:
      - 'null'
      - string
    doc: 'analysis mode: global or target. Global mode reports all isotope patterns,
      targeted only those matching targets.'
    inputBinding:
      position: 102
      prefix: --mode=
      separate: false
  - id: n_report
    type:
      - 'null'
      - int
    doc: number of random assay to export control figure for
    inputBinding:
      position: 102
      prefix: --nReport=
      separate: false
  - id: out_dir
    type: string
    default: .
    doc: output directory (by default same as input mzML; the input folder is read-only here, so it defaults to the working directory)
    inputBinding:
      position: 102
      prefix: --outDir=
      separate: false
  - id: out_name
    type:
      - 'null'
      - string
    doc: basename for output files (by default same as input mzML)
    inputBinding:
      position: 102
      prefix: --outName=
      separate: false
  - id: profiling
    type:
      - 'null'
      - boolean
    doc: set to enable CPU profiling
    inputBinding:
      position: 102
      prefix: --profiling
  - id: report_deiso_mz_height
    type:
      - 'null'
      - float
    doc: mz range in deisotoper reports
    inputBinding:
      position: 102
      prefix: --reportDeisoMzHeight=
      separate: false
  - id: report_high_res
    type:
      - 'null'
      - boolean
    doc: generate high-resolution plot trail when supported (for print)
    inputBinding:
      position: 102
      prefix: --reportHighRes
  - id: report_seed
    type:
      - 'null'
      - int
    doc: seed to use for report assay selection (<0 means random)
    inputBinding:
      position: 102
      prefix: --reportSeed=
      separate: false
  - id: report_targets
    type:
      - 'null'
      - boolean
    doc: set to create a special report figure for each target
    inputBinding:
      position: 102
      prefix: --reportTargets
  - id: seed
    type:
      - 'null'
      - int
    doc: seed to use for bootstrapping of mass calibration (<0 means random)
    inputBinding:
      position: 102
      prefix: --seed=
      separate: false
  - id: target_preference
    type:
      - 'null'
      - string
    doc: if multiple isotope patterns fit target, take the closest rt apex (rt) 
      or the most intense (intensity)
    inputBinding:
      position: 102
      prefix: --targetPreference=
      separate: false
  - id: targets
    type:
      - 'null'
      - File
    doc: path to isotope patterns target file (not used by default)
    inputBinding:
      position: 102
      prefix: --targets=
      separate: false
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: increase details in output
    inputBinding:
      position: 102
      prefix: --verbose
  - id: write_binary
    type:
      - 'null'
      - boolean
    doc: set to output binary MSFeatureProtocol file
    inputBinding:
      position: 102
      prefix: --writeBinary
  - id: write_hills
    type:
      - 'null'
      - boolean
    doc: set to output csv file with all hills assigned to isotope patterns
    inputBinding:
      position: 102
      prefix: --writeHills
  - id: write_ms_inspect
    type:
      - 'null'
      - boolean
    doc: set to output MsInspect feature csv file
    inputBinding:
      position: 102
      prefix: --writeMsInspect
  - id: write_quant_ml
    type:
      - 'null'
      - boolean
    doc: set to output mzQuantML file
    inputBinding:
      position: 102
      prefix: --writeQuantML
  - id: zip_qc_folder
    type:
      - 'null'
      - boolean
    doc: set to zip the entire qc folder on algorithm completion
    inputBinding:
      position: 102
      prefix: --zipQcFolder
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: features
    type: File
    doc: Feature (isotope pattern) table
    outputBinding:
      glob: |
        $(inputs.out_dir + '/' + (inputs.out_name ? inputs.out_name : inputs.mzml_file.nameroot) + '.features.tsv')
  - id: hills
    type:
      - 'null'
      - File
    doc: CSV file with all hills assigned to isotope patterns (writeHills)
    outputBinding:
      glob: |
        $(inputs.out_dir + '/' + (inputs.out_name ? inputs.out_name : inputs.mzml_file.nameroot) + '.hills.csv')
  - id: ms_inspect
    type:
      - 'null'
      - File
    doc: MsInspect feature file (writeMsInspect)
    outputBinding:
      glob: |
        $(inputs.out_dir + '/' + (inputs.out_name ? inputs.out_name : inputs.mzml_file.nameroot) + '.msInspect.tsv')
  - id: quant_ml
    type:
      - 'null'
      - File
    doc: mzQuantML file (writeQuantML)
    outputBinding:
      glob: |
        $(inputs.out_dir + '/' + (inputs.out_name ? inputs.out_name : inputs.mzml_file.nameroot) + '.mzq')
  - id: binary
    type:
      - 'null'
      - File
    doc: Binary MSFeatureProtocol file (writeBinary)
    outputBinding:
      glob: |
        $(inputs.out_dir + '/' + (inputs.out_name ? inputs.out_name : inputs.mzml_file.nameroot) + '.features.bin')
  - id: qc
    type:
      type: array
      items: [File, Directory]
    doc: QC report files and folder
    outputBinding:
      glob: |
        $(inputs.out_dir + '/' + (inputs.out_name ? inputs.out_name : inputs.mzml_file.nameroot) + '.qc*')
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dinosaur:1.2.0--hdfd78af_1
stdout: dinosaur.out
