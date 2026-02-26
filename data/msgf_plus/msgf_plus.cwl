cwlVersion: v1.2
class: CommandLineTool
baseCommand: java -Xmx3500M -jar MSGFPlus.jar
label: msgf_plus
doc: "MS-GF+ Release (v2024.03.26) (26 March 2024)\n\nTool homepage: https://msgfplus.github.io/"
inputs:
  - id: add_features
    type:
      - 'null'
      - int
    doc: "Include additional features in the output (enable this to post-process results
      with Percolator), Default: 0\n0 means Output basic scores only (Default)\n1
      means Output additional features"
    default: 0
    inputBinding:
      position: 101
      prefix: -addFeatures
  - id: allow_dense_centroided_peaks
    type:
      - 'null'
      - int
    doc: "Allow centroid scans with dense peaks (Default: 0)\n(for mzML or mzXML files,
      the console output will tell you if you might want to use this), Default: 0"
    default: 0
    inputBinding:
      position: 101
      prefix: -allowDenseCentroidedPeaks
  - id: charge_carrier_mass
    type:
      - 'null'
      - float
    doc: 'Mass of charge carrier; Default: mass of proton (1.00727649)'
    default: 1.00727649
    inputBinding:
      position: 101
      prefix: -ccm
  - id: configuration_file
    type:
      - 'null'
      - File
    doc: Configuration file path; options specified at the command line will 
      override settings in the config file
    inputBinding:
      position: 101
      prefix: -conf
  - id: database_file
    type:
      - 'null'
      - File
    doc: '*.fasta or *.fa or *.faa'
    inputBinding:
      position: 101
      prefix: -d
  - id: decoy_prefix
    type:
      - 'null'
      - string
    doc: Prefix for decoy protein names
    default: XXX
    inputBinding:
      position: 101
      prefix: -decoy
  - id: enzyme_id
    type:
      - 'null'
      - int
    doc: '0: unspecific cleavage, 1: Trypsin (Default), 2: Chymotrypsin, 3: Lys-C,
      4: Lys-N, 5: glutamyl endopeptidase, 6: Arg-C, 7: Asp-N, 8: alphaLP, 9: no cleavage'
    default: 1
    inputBinding:
      position: 101
      prefix: -e
  - id: fragmentation_method_id
    type:
      - 'null'
      - int
    doc: "Fragmentation Method, Default: 0\n0 means as written in the spectrum or
      CID if no info (Default)\n1 means CID\n2 means ETD\n3 means HCD"
    default: 0
    inputBinding:
      position: 101
      prefix: -m
  - id: instrument_id
    type:
      - 'null'
      - int
    doc: '0: Low-res LCQ/LTQ (Default), 1: Orbitrap/FTICR/Lumos, 2: TOF, 3: Q-Exactive'
    default: 0
    inputBinding:
      position: 101
      prefix: -inst
  - id: isotope_error_range
    type:
      - 'null'
      - string
    doc: "Range of allowed isotope peak errors; Default: 0,1\nTakes into account the
      error introduced by choosing a non-monoisotopic peak for fragmentation.\nThe
      combination of -t and -ti determines the precursor mass tolerance.\nE.g. \"\
      -t 20ppm -ti -1,2\" tests abs(ObservedPepMass - TheoreticalPepMass - n * 1.00335Da)
      < 20ppm for n = -1, 0, 1, 2."
    default: 0,1
    inputBinding:
      position: 101
      prefix: -ti
  - id: max_charge
    type:
      - 'null'
      - int
    doc: Maximum precursor charge to consider if charges are not specified in 
      the spectrum file
    default: 3
    inputBinding:
      position: 101
      prefix: -maxCharge
  - id: max_missed_cleavages
    type:
      - 'null'
      - int
    doc: 'Exclude peptides with more than this number of missed cleavages from the
      search; Default: -1 (no limit)'
    default: -1
    inputBinding:
      position: 101
      prefix: -maxMissedCleavages
  - id: max_peptide_length
    type:
      - 'null'
      - int
    doc: Maximum peptide length to consider
    default: 40
    inputBinding:
      position: 101
      prefix: -maxLength
  - id: min_charge
    type:
      - 'null'
      - int
    doc: Minimum precursor charge to consider if charges are not specified in 
      the spectrum file
    default: 2
    inputBinding:
      position: 101
      prefix: -minCharge
  - id: min_peptide_length
    type:
      - 'null'
      - int
    doc: Minimum peptide length to consider
    default: 6
    inputBinding:
      position: 101
      prefix: -minLength
  - id: modification_file
    type:
      - 'null'
      - File
    doc: 'Modification file; Default: standard amino acids with fixed C+57; only if
      -mod is not specified'
    inputBinding:
      position: 101
      prefix: -mod
  - id: ntt
    type:
      - 'null'
      - int
    doc: "Number of Tolerable Termini, Default: 2\nE.g. For trypsin, 0: non-tryptic,
      1: semi-tryptic, 2: fully-tryptic peptides only."
    default: 2
    inputBinding:
      position: 101
      prefix: -ntt
  - id: num_dynamic_mods
    type:
      - 'null'
      - int
    doc: Maximum number of dynamic (variable) modifications per peptide
    default: 3
    inputBinding:
      position: 101
      prefix: -numMods
  - id: num_matches_per_spectrum
    type:
      - 'null'
      - int
    doc: Number of matches per spectrum to be reported
    default: 1
    inputBinding:
      position: 101
      prefix: -n
  - id: num_tasks
    type:
      - 'null'
      - int
    doc: "Override the number of tasks to use on the threads; Default: (internally
      calculated based on inputs)\nMore tasks than threads will reduce the memory
      requirements of the search, but will be slower (how much depends on the inputs).\n\
      1 <= tasks <= numThreads: will create one task per thread, which is the original
      behavior.\ntasks = 0: use default calculation - minimum of: (threads*3) and
      (numSpectra/250).\ntasks < 0: multiply number of threads by abs(tasks) to determine
      number of tasks (i.e., -2 means \"2 * numThreads\" tasks).\nOne task per thread
      will use the most memory, but will usually finish the fastest.\n2-3 tasks per
      thread will use comparably less memory, but may cause the search to take 1.5
      to 2 times as long."
    inputBinding:
      position: 101
      prefix: -tasks
  - id: num_threads
    type:
      - 'null'
      - int
    doc: "Number of concurrent threads to be executed; Default: Number of available
      cores\nThis is best set to the number of physical cores in a single NUMA node.\n\
      Generally a single NUMA node is 1 physical processor.\nThe default will try
      to use hyperthreading cores, which can increase the amount of time this process
      will take.\nThis is because the part of Scoring param generation that is multithreaded
      is also I/O intensive."
    inputBinding:
      position: 101
      prefix: -thread
  - id: precursor_mass_tolerance
    type:
      - 'null'
      - string
    doc: "e.g. 2.5Da, 20ppm or 0.5Da,2.5Da; Default: 20ppm\nUse a comma to define
      asymmetric values. E.g. \"-t 0.5Da,2.5Da\" will set 0.5Da to the left (ObsMass
      < TheoMass) and 2.5Da to the right (ObsMass > TheoMass)"
    default: 20ppm
    inputBinding:
      position: 101
      prefix: -t
  - id: protocol_id
    type:
      - 'null'
      - int
    doc: '0: Automatic (Default), 1: Phosphorylation, 2: iTRAQ, 3: iTRAQPhospho, 4:
      TMT, 5: Standard'
    default: 0
    inputBinding:
      position: 101
      prefix: -protocol
  - id: spectrum_file
    type:
      - 'null'
      - File
    doc: "*.mzML, *.mzXML, *.mgf, *.ms2, *.pkl or *_dta.txt\nSpectra should be centroided
      (see below for MSConvert example). Profile spectra will be ignored."
    inputBinding:
      position: 101
      prefix: -s
  - id: tda
    type:
      - 'null'
      - int
    doc: "Target decoy strategy, Default: 0\n0 means Don't search decoy database (Default)\n\
      1 means search the decoy database (forward + reverse proteins)"
    default: 0
    inputBinding:
      position: 101
      prefix: -tda
  - id: verbose
    type:
      - 'null'
      - int
    doc: "Console output message verbosity, Default: 0\n0 means Report total progress
      only\n1 means Report total and per-thread progress/status"
    default: 0
    inputBinding:
      position: 101
      prefix: -verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: '*.mzid (Default: [SpectrumFileName].mzid)'
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msgf_plus:2024.03.26--hdfd78af_0
