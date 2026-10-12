cwlVersion: v1.2
class: CommandLineTool
baseCommand: padel
label: padel
doc: "PaDEL-Descriptor calculates molecular descriptors and fingerprints from
  structure files (SDF, SMILES, MOL).\n\nTool homepage: http://www.yapcwsoft.com/dd/padeldescriptor/"
inputs:
  - id: maxruntime
    type: ['null', int]
    doc: Maximum running time per molecule (in milliseconds). Use -1 for unlimited.
    inputBinding:
      position: 101
      prefix: -maxruntime
  - id: waitingjobs
    type: ['null', int]
    doc: Maximum number of jobs to store in queue for worker threads to process. Use -1
      to set it to 50*Max threads.
    inputBinding:
      position: 101
      prefix: -waitingjobs
  - id: threads
    type: ['null', int]
    doc: Maximum number of threads to use. Use -1 to use as many threads as the number
      of cpu cores.
    inputBinding:
      position: 101
      prefix: -threads
  - id: calc_2d
    type: ['null', boolean]
    doc: Calculate 1D and 2D descriptors
    inputBinding:
      position: 101
      prefix: -2d
  - id: calc_3d
    type: ['null', boolean]
    doc: Calculate 3D descriptors
    inputBinding:
      position: 101
      prefix: -3d
  - id: config
    type: ['null', File]
    doc: Configuration file
    inputBinding:
      position: 101
      prefix: -config
  - id: convert3d
    type: ['null', boolean]
    doc: Convert molecule to 3D
    inputBinding:
      position: 101
      prefix: -convert3d
  - id: descriptortypes
    type: ['null', File]
    doc: Descriptor types file
    inputBinding:
      position: 101
      prefix: -descriptortypes
  - id: detectaromaticity
    type: ['null', boolean]
    doc: Remove existing aromaticity information and automatically detect aromaticity
      in the molecule before calculation of descriptors
    inputBinding:
      position: 101
      prefix: -detectaromaticity
  - id: directory
    type: Directory
    doc: Directory containing structural files
    inputBinding:
      position: 101
      prefix: -dir
  - id: output_file
    type: string
    doc: File name to save calculated descriptors
    inputBinding:
      position: 101
      prefix: -file
  - id: fingerprints
    type: ['null', boolean]
    doc: Calculate fingerprints
    inputBinding:
      position: 101
      prefix: -fingerprints
  - id: log
    type: ['null', boolean]
    doc: Create a log file. The name of the log file is the name of the descriptors file
      with a .log extension.
    inputBinding:
      position: 101
      prefix: -log
  - id: maxcpdperfile
    type: ['null', int]
    doc: Maximum number of compounds to be stored in each descriptor file. Use 0 for unlimited.
    inputBinding:
      position: 101
      prefix: -maxcpdperfile
  - id: removesalt
    type: ['null', boolean]
    doc: Remove salt from molecule
    inputBinding:
      position: 101
      prefix: -removesalt
  - id: retain3d
    type: ['null', boolean]
    doc: Retain 3D coordinates when standardizing structure. However, this may prevent
      some structures from being standardized.
    inputBinding:
      position: 101
      prefix: -retain3d
  - id: retainorder
    type: ['null', boolean]
    doc: Retain order of molecules in structural files for descriptor file. This may
      lead to large memory use if descriptor calculations are stuck at one molecule.
    inputBinding:
      position: 101
      prefix: -retainorder
  - id: standardizenitro
    type: ['null', boolean]
    doc: Standardize nitro groups to N(:O):O
    inputBinding:
      position: 101
      prefix: -standardizenitro
  - id: standardizetautomers
    type: ['null', boolean]
    doc: Standardize tautomers
    inputBinding:
      position: 101
      prefix: -standardizetautomers
  - id: tautomerlist
    type: ['null', File]
    doc: SMIRKS tautomers file
    inputBinding:
      position: 101
      prefix: -tautomerlist
  - id: usefilenameasmolname
    type: ['null', boolean]
    doc: Use filename (minus the extension) as molecule name
    inputBinding:
      position: 101
      prefix: -usefilenameasmolname
outputs:
  - id: descriptors
    type: File
    doc: Calculated descriptors (CSV)
    outputBinding:
      glob: $(inputs.output_file)
  - id: log_file
    type: ['null', File]
    doc: Log file written with the -log option
    outputBinding:
      glob: $(inputs.output_file).log
requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      - envName: JAVA_TOOL_OPTIONS
        envValue: -Djava.awt.headless=true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/padel:2.21
