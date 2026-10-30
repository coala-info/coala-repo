cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - spectrast2tsv.py
label: msproteomicstools_spectrast2tsv.py
doc: "Filter SpectraST library files into SWATH assay libraries (OpenSWATH or Peakview format).\n\nTool homepage: https://github.com/msproteomicstools/msproteomicstools"
inputs:
  - id: spectrast_files
    type: 'File[]'
    doc: "SpectraST file(s)"
    inputBinding:
      position: 99
  - id: remove_duplicate_masses
    type: ['null', boolean]
    doc: "Remove duplicate masses from labeling"
    inputBinding:
      prefix: -d
  - id: theoretical_mass
    type: ['null', boolean]
    doc: "Use theoretical mass"
    inputBinding:
      prefix: -e
  - id: fasta_file
    type: ['null', File]
    doc: "Fasta file to relate peptides to their proteins"
    inputBinding:
      prefix: -f
  - id: mass_modifs
    type: ['null', string]
    doc: "List of allowed fragment mass modifications, e.g. -79.97,-97.98,-17.03,-18.01"
    inputBinding:
      prefix: -g
  - id: labeling_file
    type: ['null', File]
    doc: "File containing the amino acid isotopic labeling mass shifts (generates heavy transitions)"
    inputBinding:
      prefix: -i
  - id: output_key
    type: ['null', string]
    doc: "Output provided: openswath or peakview (default peakview)"
    inputBinding:
      prefix: -k
  - id: mass_limits
    type: ['null', string]
    doc: "Lower and upper mass limits of fragment ions, e.g. 400,2000"
    inputBinding:
      prefix: -l
  - id: mods_file
    type: ['null', File]
    doc: "File with the modifications delta mass"
    inputBinding:
      prefix: -m
  - id: max_ions
    type: ['null', int]
    doc: "Max number of reported ions per peptide/z (default 20)"
    inputBinding:
      prefix: -n
  - id: min_ions
    type: ['null', int]
    doc: "Min number of reported ions per peptide/z (default 3)"
    inputBinding:
      prefix: -o
  - id: max_error
    type: ['null', float]
    doc: "Maximum error allowed at the annotation of a fragment ion (default 0.05)"
    inputBinding:
      prefix: -p
  - id: processors
    type: ['null', int]
    doc: "Number of processors to use (only for isoforms; default 1)"
    inputBinding:
      prefix: -q
  - id: ion_series
    type: ['null', string]
    doc: "List of ion series to be used, e.g. y,b"
    inputBinding:
      prefix: -s
  - id: time_scale
    type: ['null', {type: enum, symbols: [minutes, seconds]}]
    doc: "Time scale of the retention times (default seconds)"
    inputBinding:
      prefix: -t
  - id: unimod_code
    type: ['null', int]
    doc: "Unimod code used as a switching modification, e.g. 21"
    inputBinding:
      prefix: -u
  - id: verbose
    type: ['null', boolean]
    doc: "Verbose mode"
    inputBinding:
      prefix: -v
  - id: swaths_file
    type: ['null', File]
    doc: "File containing the swath ranges, used to remove transitions with Q3 in the swath mass range"
    inputBinding:
      prefix: -w
  - id: allowed_frg_z
    type: ['null', string]
    doc: "Fragment ion charge states allowed (default 1,2)"
    inputBinding:
      prefix: -x
  - id: uis_order
    type: ['null', int]
    doc: "UIS order to be calculated with a switching modification; -1 reports all transitions (default 2)"
    inputBinding:
      prefix: -y
  - id: output_path
    type: ['null', string]
    doc: "Output file name (default: appends _peakview.txt)"
    inputBinding:
      prefix: -a
outputs:
  - id: output
    type: ['null', File]
    doc: "Assay library"
    outputBinding:
      glob: "$(inputs.output_path)"
  - id: default_outputs
    type: 'File[]'
    doc: "Libraries written next to the input with the default name"
    outputBinding:
      glob: "*_peakview.txt"
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
stdout: msproteomicstools_spectrast2tsv.py.out
