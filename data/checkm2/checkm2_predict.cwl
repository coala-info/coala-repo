cwlVersion: v1.2
class: CommandLineTool
baseCommand: checkm2 predict
label: checkm2_predict
doc: "Predict the completeness and contamination of genome bins in a folder.\n\nTool
  homepage: https://github.com/chklovski/CheckM2"
inputs:
  - id: input
    type:
      type: array
      items: Directory
    doc: Path to folder containing MAGs or list of MAGS to be analyzed
    inputBinding:
      position: 1
  - id: allmodels
    type:
      - 'null'
      - boolean
    doc: Output quality prediction for both models for each genome.
    inputBinding:
      position: 102
      prefix: --allmodels
  - id: database_path
    type:
      - 'null'
      - Directory
    doc: 'Provide a location for the CheckM2 database for a given predict run [default:
      use either internal path set via <checkm2 database> or CHECKM2DB environmental
      variable]'
    inputBinding:
      position: 102
      prefix: --database_path
  - id: dbg_cos
    type:
      - 'null'
      - boolean
    doc: "DEBUG: write cosine similarity values to file [default: don't]"
    inputBinding:
      position: 102
      prefix: --dbg_cos
  - id: dbg_vectors
    type:
      - 'null'
      - boolean
    doc: "DEBUG: dump pickled feature vectors to file [default: don't]"
    inputBinding:
      position: 102
      prefix: --dbg_vectors
  - id: debug
    type:
      - 'null'
      - boolean
    doc: output debug information
    inputBinding:
      position: 102
      prefix: --debug
  - id: extension
    type:
      - 'null'
      - string
    doc: Extension of input files.
    inputBinding:
      position: 102
      prefix: --extension
  - id: force
    type:
      - 'null'
      - boolean
    doc: 'overwrite output directory [default: do not overwrite]'
    inputBinding:
      position: 102
      prefix: --force
  - id: general
    type:
      - 'null'
      - boolean
    doc: Force the use of the general quality prediction model (gradient boost)
    inputBinding:
      position: 102
      prefix: --general
  - id: genes
    type:
      - 'null'
      - boolean
    doc: Treat input files as protein files.
    inputBinding:
      position: 102
      prefix: --genes
  - id: lowmem
    type:
      - 'null'
      - boolean
    doc: Low memory mode. Reduces DIAMOND blocksize to significantly reduce RAM 
      usage at the expense of longer runtime
    inputBinding:
      position: 102
      prefix: --lowmem
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: only output errors
    inputBinding:
      position: 102
      prefix: --quiet
  - id: remove_intermediates
    type:
      - 'null'
      - boolean
    doc: "Remove all intermediate files (protein files, diamond output) [default:
      don't]"
    inputBinding:
      position: 102
      prefix: --remove_intermediates
  - id: resume
    type:
      - 'null'
      - boolean
    doc: 'Reuse Prodigal and DIAMOND results found in output directory [default: not
      set]'
    inputBinding:
      position: 102
      prefix: --resume
  - id: specific
    type:
      - 'null'
      - boolean
    doc: Force the use of the specific quality prediction model (neural network)
    inputBinding:
      position: 102
      prefix: --specific
  - id: stdout
    type:
      - 'null'
      - boolean
    doc: 'Print results to stdout [default: write to file]'
    inputBinding:
      position: 102
      prefix: --stdout
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPUS to use
    inputBinding:
      position: 102
      prefix: --threads
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: specify an alternative directory for temporary files
    inputBinding:
      position: 102
      prefix: --tmpdir
  - id: ttable
    type:
      - 'null'
      - string
    doc: 'Provide a specific progidal translation table for bins [default: automatically
      determine either 11 or 4]'
    inputBinding:
      position: 102
      prefix: --ttable
outputs:
  - id: output_directory
    type: Directory
    doc: Path output to folder
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/checkm2:1.1.0--pyh7e72e81_1
