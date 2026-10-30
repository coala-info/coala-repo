cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- matUtils
- uncertainty
label: usher_matUtils_uncertainty
doc: 'matUtils uncertainty: calculates sample placement uncertainty metrics and writes
  the results to tsv files.


  Tool homepage: https://github.com/yatisht/usher'
inputs:
- id: input_mat
  type: File
  doc: Input mutation-annotated tree file [REQUIRED]
  inputBinding:
    position: 101
    prefix: --input-mat
- id: samples
  type:
  - 'null'
  - File
  doc: Path to a simple text file of sample names to calculate uncertainty for.
  inputBinding:
    position: 101
    prefix: --samples
- id: find_epps
  type:
  - 'null'
  - string
  doc: Name for an Auspice-compatible tsv file output of equally parsimonious placements
    and neighborhood sizes for input samples.
  inputBinding:
    position: 101
    prefix: --find-epps
- id: record_placements
  type:
  - 'null'
  - string
  doc: Name for an Auspice-compatible two-column tsv which records potential parents
    for each sample in the query set.
  inputBinding:
    position: 101
    prefix: --record-placements
- id: dropout_mutations
  type:
  - 'null'
  - string
  doc: Name a file to calculate and save mutations which may be associated with primer
    dropout [EXPERIMENTAL].
  inputBinding:
    position: 101
    prefix: --dropout-mutations
- id: threads
  type:
  - 'null'
  - int
  doc: 'Number of threads to use when possible [DEFAULT uses all available cores,
    20 detected on this machine] [default: 20]'
  inputBinding:
    position: 101
    prefix: --threads
outputs:
- id: find_epps_file
  type:
  - 'null'
  - File
  doc: Output file named by --find-epps. Name for an Auspice-compatible tsv file output
    of equally parsimonious placements and neighborhood sizes for input samples.
  outputBinding:
    glob: '${ return inputs.find_epps ? inputs.find_epps : []; }'
- id: record_placements_file
  type:
  - 'null'
  - File
  doc: Output file named by --record-placements. Name for an Auspice-compatible two-column
    tsv which records potential parents for each sample in the query set.
  outputBinding:
    glob: '${ return inputs.record_placements ? inputs.record_placements : []; }'
- id: dropout_mutations_file
  type:
  - 'null'
  - File
  doc: Output file named by --dropout-mutations. Name a file to calculate and save
    mutations which may be associated with primer dropout [EXPERIMENTAL].
  outputBinding:
    glob: '${ return inputs.dropout_mutations ? inputs.dropout_mutations : []; }'
- id: stdout_log
  type: stdout
  doc: Standard output (progress messages).
stdout: matUtils_uncertainty_stdout.txt
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/usher:0.6.6--hdd55de9_4
