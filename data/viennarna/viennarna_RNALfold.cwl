cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - RNALfold
label: viennarna_RNALfold
doc: |-
  Calculate locally stable secondary structures of long RNAs.

  Tool homepage: https://www.tbi.univie.ac.at/RNA/
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Be verbose.
    inputBinding:
      position: 10
      prefix: --verbose
  - id: infile
    type: File
    doc: Read a file instead of reading from stdin
    inputBinding:
      position: 10
      prefix: --infile=
      separate: false
  - id: outfile
    type:
      - 'null'
      - string
    doc: Print output to file instead of stdout.
    inputBinding:
      position: 10
      prefix: --outfile=
      separate: false
  - id: noconv
    type:
      - 'null'
      - boolean
    doc: Do not automatically substitute nucleotide "T" with "U".
    inputBinding:
      position: 10
      prefix: --noconv
  - id: auto_id
    type:
      - 'null'
      - boolean
    doc: Automatically generate an ID for each sequence.
    inputBinding:
      position: 10
      prefix: --auto-id
  - id: id_prefix
    type:
      - 'null'
      - string
    doc: Prefix for automatically generated IDs (as used in output file names).
    inputBinding:
      position: 10
      prefix: --id-prefix=
      separate: false
  - id: span
    type:
      - 'null'
      - int
    doc: Set the maximum distance between any two pairing nucleotides.
    inputBinding:
      position: 10
      prefix: --span=
      separate: false
  - id: zscore
    type:
      - 'null'
      - float
    doc: Limit the output to predictions with a Z-score below a threshold.
    inputBinding:
      position: 10
      prefix: --zscore=
      separate: false
  - id: zscore_pre_filter
    type:
      - 'null'
      - boolean
    doc: Apply the z-score filtering in the forward recursions.
    inputBinding:
      position: 10
      prefix: --zscore-pre-filter
  - id: zscore_report_subsumed
    type:
      - 'null'
      - boolean
    doc: Report subsumed structures if their z-score is less than that of the enclosing structure.
    inputBinding:
      position: 10
      prefix: --zscore-report-subsumed
  - id: backtrack_global
    type:
      - 'null'
      - boolean
    doc: Backtrack a global MFE structure.
    inputBinding:
      position: 10
      prefix: --backtrack-global
  - id: gquad
    type:
      - 'null'
      - boolean
    doc: Incoorporate G-Quadruplex formation into the structure prediction algorithm.
    inputBinding:
      position: 10
      prefix: --gquad
  - id: shape
    type:
      - 'null'
      - File
    doc: Use SHAPE reactivity data to guide structure predictions.
    inputBinding:
      position: 10
      prefix: --shape=
      separate: false
  - id: temp
    type:
      - 'null'
      - float
    doc: Rescale energy parameters to a temperature of temp C. Default is 37C.
    inputBinding:
      position: 10
      prefix: --temp=
      separate: false
  - id: param_file
    type:
      - 'null'
      - File
    doc: Read energy parameters from paramfile, instead of using the default parameter set.
    inputBinding:
      position: 10
      prefix: --paramFile=
      separate: false
  - id: salt
    type:
      - 'null'
      - float
    doc: Set salt concentration in molar (M). Default is 1.021M.
    inputBinding:
      position: 10
      prefix: --salt=
      separate: false
  - id: modifications
    type:
      - 'null'
      - string
    doc: Allow for modified bases within the RNA sequence string.
    inputBinding:
      position: 10
      prefix: --modifications=
      separate: false
  - id: mod_file
    type:
      - 'null'
      - string
    doc: Use additional modified base data from JSON file.
    inputBinding:
      position: 10
      prefix: --mod-file=
      separate: false
  - id: dangles
    type:
      - 'null'
      - int
    doc: How to treat "dangling end" energies for bases adjacent to helices in free ends and multi-loops.
    inputBinding:
      position: 10
      prefix: --dangles=
      separate: false
  - id: no_lp
    type:
      - 'null'
      - boolean
    doc: Produce structures without lonely pairs (helices of length 1).
    inputBinding:
      position: 10
      prefix: --noLP
outputs:
  - id: stdout
    type: stdout
    doc: Standard output of the program
  - id: outfile_result
    type:
      - 'null'
      - File
    doc: Output file written with --outfile
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
stdout: RNALfold.out
s:url: https://www.tbi.univie.ac.at/RNA/
$namespaces:
  s: https://schema.org/
