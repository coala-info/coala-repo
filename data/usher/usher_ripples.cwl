cwlVersion: v1.2
class: CommandLineTool
baseCommand: ripples
label: usher_ripples
doc: 'ripples: detects recombination events in a mutation-annotated tree (MAT) by
  partial placement of candidate recombinant branches.


  Tool homepage: https://github.com/yatisht/usher'
inputs:
- id: input_mat
  type: File
  doc: Input mutation-annotated tree file to optimize [REQUIRED].
  inputBinding:
    position: 101
    prefix: --input-mat
- id: branch_length
  type:
  - 'null'
  - int
  doc: 'Minimum length of the branch to consider to recombination events [default:
    3]'
  inputBinding:
    position: 101
    prefix: --branch-length
- id: min_coordinate_range
  type:
  - 'null'
  - int
  doc: 'Minimum range of the genomic coordinates of the mutations on the recombinant
    branch [default: 1000]'
  inputBinding:
    position: 101
    prefix: --min-coordinate-range
- id: max_coordinate_range
  type:
  - 'null'
  - int
  doc: 'Maximum range of the genomic coordinates of the mutations on the recombinant
    branch [default: 10000000]'
  inputBinding:
    position: 101
    prefix: --max-coordinate-range
- id: outdir
  type:
  - 'null'
  - string
  doc: 'Output directory to dump output files [DEFAULT uses current directory] [default:
    .]'
  inputBinding:
    position: 101
    prefix: --outdir
- id: samples_filename
  type:
  - 'null'
  - File
  doc: Restrict the search to the ancestors of the samples specified in the input
    file
  inputBinding:
    position: 101
    prefix: --samples-filename
- id: parsimony_improvement
  type:
  - 'null'
  - int
  doc: 'Minimum improvement in parsimony score of the recombinant sequence during
    the partial placement [default: 3]'
  inputBinding:
    position: 101
    prefix: --parsimony-improvement
- id: num_descendants
  type:
  - 'null'
  - int
  doc: 'Minimum number of leaves that node should have to be considered for recombination.
    [default: 10]'
  inputBinding:
    position: 101
    prefix: --num-descendants
- id: threads
  type:
  - 'null'
  - int
  doc: 'Number of threads to use when possible [DEFAULT uses all available cores,
    20 detected on this machine] [default: 20]'
  inputBinding:
    position: 101
    prefix: --threads
- id: start_index
  type:
  - 'null'
  - int
  doc: 'start index [EXPERIMENTAL] [default: -1]'
  inputBinding:
    position: 101
    prefix: --start-index
- id: end_index
  type:
  - 'null'
  - int
  doc: 'end index [EXPERIMENTAL] [default: -1]'
  inputBinding:
    position: 101
    prefix: --end-index
outputs:
- id: outdir_dir
  type:
  - 'null'
  - Directory
  doc: Directory named by --outdir
  outputBinding:
    glob: '${ return inputs.outdir ? inputs.outdir : []; }'
- id: stdout_log
  type: stdout
  doc: Standard output (progress messages).
- id: descendants_tsv
  type:
  - 'null'
  - File
  doc: 'descendants.tsv: descendants of the candidate recombinant nodes.'
  outputBinding:
    glob: '${ return (inputs.outdir ? inputs.outdir : ''.'') + ''/descendants.tsv'';
      }'
- id: recombination_tsv
  type:
  - 'null'
  - File
  doc: 'recombination.tsv: detected recombination events.'
  outputBinding:
    glob: '${ return (inputs.outdir ? inputs.outdir : ''.'') + ''/recombination.tsv'';
      }'
stdout: ripples_stdout.txt
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/usher:0.6.6--hdd55de9_4
