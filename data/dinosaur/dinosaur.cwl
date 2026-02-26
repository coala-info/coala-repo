cwlVersion: v1.2
class: CommandLineTool
baseCommand: java -jar Dinosaur-1.2.0.jar
label: dinosaur
doc: "Analyze MzML files for isotope patterns.\n\nTool homepage: https://github.com/fickludd/dinosaur"
inputs:
  - id: mzml_file
    type: File
    doc: The shotgun MzML file to analyze
    inputBinding:
      position: 1
  - id: adv_help
    type:
      - 'null'
      - boolean
    doc: set to output adv param file help and quit
    default: false
    inputBinding:
      position: 102
      prefix: advHelp
  - id: adv_params
    type:
      - 'null'
      - File
    doc: path to adv param file
    inputBinding:
      position: 102
      prefix: advParams
  - id: concurrency
    type:
      - 'null'
      - int
    doc: the number of assays to analyze in parallel
    default: 2
    inputBinding:
      position: 102
      prefix: concurrency
  - id: force
    type:
      - 'null'
      - boolean
    doc: ignore missing mzML params
    default: false
    inputBinding:
      position: 102
      prefix: force
  - id: max_charge
    type:
      - 'null'
      - int
    doc: max searched ion charge
    default: 6
    inputBinding:
      position: 102
      prefix: maxCharge
  - id: min_charge
    type:
      - 'null'
      - int
    doc: min searched ion charge
    default: 1
    inputBinding:
      position: 102
      prefix: minCharge
  - id: mode
    type:
      - 'null'
      - string
    doc: 'analysis mode: global or target. Global mode reports all isotope patterns,
      targeted only those matching targets.'
    default: global
    inputBinding:
      position: 102
      prefix: mode
  - id: n_report
    type:
      - 'null'
      - int
    doc: number of random assay to export control figure for
    default: 10
    inputBinding:
      position: 102
      prefix: nReport
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: output directory (by default same as input mzML)
    inputBinding:
      position: 102
      prefix: outDir
  - id: out_name
    type:
      - 'null'
      - string
    doc: basename for output files (by default same as input mzML)
    inputBinding:
      position: 102
      prefix: outName
  - id: profiling
    type:
      - 'null'
      - boolean
    doc: set to enable CPU profiling
    default: false
    inputBinding:
      position: 102
      prefix: profiling
  - id: report_deiso_mz_height
    type:
      - 'null'
      - float
    doc: mz range in deisotoper reports
    default: 15.0
    inputBinding:
      position: 102
      prefix: reportDeisoMzHeight
  - id: report_high_res
    type:
      - 'null'
      - boolean
    doc: generate high-resolution plot trail when supported (for print)
    default: false
    inputBinding:
      position: 102
      prefix: reportHighRes
  - id: report_seed
    type:
      - 'null'
      - int
    doc: seed to use for report assay selection (<0 means random)
    default: -1
    inputBinding:
      position: 102
      prefix: reportSeed
  - id: report_targets
    type:
      - 'null'
      - boolean
    doc: set to create a special report figure for each target
    default: false
    inputBinding:
      position: 102
      prefix: reportTargets
  - id: seed
    type:
      - 'null'
      - int
    doc: seed to use for bootstrapping of mass calibration (<0 means random)
    default: -1
    inputBinding:
      position: 102
      prefix: seed
  - id: target_preference
    type:
      - 'null'
      - string
    doc: if multiple isotope patterns fit target, take the closest rt apex (rt) 
      or the most intense (intensity)
    default: rt
    inputBinding:
      position: 102
      prefix: targetPreference
  - id: targets
    type:
      - 'null'
      - File
    doc: path to isotope patterns target file (not used by default)
    inputBinding:
      position: 102
      prefix: targets
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: increase details in output
    default: false
    inputBinding:
      position: 102
      prefix: verbose
  - id: write_binary
    type:
      - 'null'
      - boolean
    doc: set to output binary MSFeatureProtocol file
    default: false
    inputBinding:
      position: 102
      prefix: writeBinary
  - id: write_hills
    type:
      - 'null'
      - boolean
    doc: set to output csv file with all hills assigned to isotope patterns
    default: false
    inputBinding:
      position: 102
      prefix: writeHills
  - id: write_ms_inspect
    type:
      - 'null'
      - boolean
    doc: set to output MsInspect feature csv file
    default: false
    inputBinding:
      position: 102
      prefix: writeMsInspect
  - id: write_quant_ml
    type:
      - 'null'
      - boolean
    doc: set to output mzQuantML file
    default: false
    inputBinding:
      position: 102
      prefix: writeQuantML
  - id: zip_qc_folder
    type:
      - 'null'
      - boolean
    doc: set to zip the entire qc folder on algorithm completion
    default: false
    inputBinding:
      position: 102
      prefix: zipQcFolder
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dinosaur:1.2.0--hdfd78af_1
stdout: dinosaur.out
