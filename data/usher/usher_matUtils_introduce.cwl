cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- matUtils
- introduce
label: usher_matUtils_introduce
doc: 'matUtils introduce: given sample region information, heuristically identifies
  points of geographic introduction along the phylogeny.


  Tool homepage: https://github.com/yatisht/usher'
inputs:
- id: input_mat
  type: File
  doc: Input mutation-annotated tree file [REQUIRED]
  inputBinding:
    position: 101
    prefix: --input-mat
- id: population_samples
  type: File
  doc: Names of samples from the population of interest [REQUIRED].
  inputBinding:
    position: 101
    prefix: --population-samples
- id: additional_info
  type:
  - 'null'
  - boolean
  doc: 'Set to calculate additional phylogenetic trait association statistics for
    whole regions and individual introductions. WARNING: Adds significantly to runtime.'
  inputBinding:
    position: 101
    prefix: --additional-info
- id: clade_regions
  type:
  - 'null'
  - string
  doc: Set to optionally record, for each clade root in the tree, the support for
    that clade root being IN each region in the input, as a tsv with the indicated
    name.
  inputBinding:
    position: 101
    prefix: --clade-regions
- id: date_metadata
  type:
  - 'null'
  - File
  doc: Pass a TSV or CSV containing a 'date' column to use for date information. If
    not used, date will be inferred from the sample name where possible.
  inputBinding:
    position: 101
    prefix: --date-metadata
- id: full_output
  type:
  - 'null'
  - string
  doc: Name of the file to save by-sample introduction information to.
  inputBinding:
    position: 101
    prefix: --full-output
- id: origin_confidence
  type:
  - 'null'
  - float
  doc: 'Set the threshold for recording of putative origins of introductions. Default
    is 0.5 [default: 0.5]'
  inputBinding:
    position: 101
    prefix: --origin-confidence
- id: evaluate_metadata
  type:
  - 'null'
  - boolean
  doc: Set to assign each leaf a confidence value based on ancestor distance and confidence.
  inputBinding:
    position: 101
    prefix: --evaluate-metadata
- id: dump_assignments
  type:
  - 'null'
  - string
  doc: Indicate a directory to which two-column text files containing node assignment
    values should be dumped for downstream processing.
  inputBinding:
    position: 101
    prefix: --dump-assignments
- id: latest_date
  type:
  - 'null'
  - string
  doc: 'Use to filter to clusters which have samples after the indicated date. [default:
    1500/1/1]'
  inputBinding:
    position: 101
    prefix: --latest-date
- id: cluster_output
  type:
  - 'null'
  - string
  doc: Write by-cluster summary output to the indicated file.
  inputBinding:
    position: 101
    prefix: --cluster-output
- id: earliest_date
  type:
  - 'null'
  - string
  doc: 'Use to filter to clusters which have ALL samples after the indicated date.
    [default: 1500/1/1]'
  inputBinding:
    position: 101
    prefix: --earliest-date
- id: num_to_report
  type:
  - 'null'
  - int
  doc: 'Report the top r potential origins for any given cluster from a region in
    multi-region mode. Set to 0 to report as many as possible. [default: 1]'
  inputBinding:
    position: 101
    prefix: --num-to-report
- id: minimum_to_report
  type:
  - 'null'
  - float
  doc: 'Set to never report origins below the indicated confidence value. Default
    0.05. [default: 0.0500000007]'
  inputBinding:
    position: 101
    prefix: --minimum-to-report
- id: num_to_look
  type:
  - 'null'
  - int
  doc: 'Called introduction nodes must have this many nodes forward to root with lower
    confidences. Set to higher integers to merge nested clusters. Default 0 [default:
    0]'
  inputBinding:
    position: 101
    prefix: --num-to-look
- id: minimum_gap
  type:
  - 'null'
  - int
  doc: 'The minimum number of mutations between the last ancestor inferred to be in
    region to its parent to use the ancestor to define the cluster instead of the
    parent. Set to higher values to merge sibling clusters. Default 0. [default: 0]'
  inputBinding:
    position: 101
    prefix: --minimum-gap
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
- id: clade_regions_file
  type:
  - 'null'
  - File
  doc: Output file named by --clade-regions. Set to optionally record, for each clade
    root in the tree, the support for that clade root being IN each region in the
    input, as a tsv with the indicated name.
  outputBinding:
    glob: '${ return inputs.clade_regions ? inputs.clade_regions : []; }'
- id: full_output_file
  type:
  - 'null'
  - File
  doc: Output file named by --full-output. Name of the file to save by-sample introduction
    information to.
  outputBinding:
    glob: '${ return inputs.full_output ? inputs.full_output : []; }'
- id: dump_assignments_dir
  type:
  - 'null'
  - Directory
  doc: Directory named by --dump-assignments
  outputBinding:
    glob: '${ return inputs.dump_assignments ? inputs.dump_assignments : []; }'
- id: cluster_output_file
  type:
  - 'null'
  - File
  doc: Output file named by --cluster-output. Write by-cluster summary output to the
    indicated file.
  outputBinding:
    glob: '${ return inputs.cluster_output ? inputs.cluster_output : []; }'
- id: stdout_log
  type: stdout
  doc: Standard output (progress messages and summary).
stdout: matUtils_introduce_stdout.txt
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/usher:0.6.6--hdd55de9_4
