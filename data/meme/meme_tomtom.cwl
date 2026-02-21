cwlVersion: v1.2
class: CommandLineTool
baseCommand: tomtom
label: meme_tomtom
doc: "Compare a query motif database against one or more target motif databases.\n
  \nTool homepage: https://meme-suite.org"
inputs:
  - id: query_file
    type: File
    doc: Query motif database file
    inputBinding:
      position: 1
  - id: target_files
    type:
      type: array
      items: File
    doc: One or more target motif database files
    inputBinding:
      position: 2
  - id: background_file
    type:
      - 'null'
      - File
    doc: 'Name of background file; default: use the background from the query motif
      database'
    inputBinding:
      position: 103
      prefix: -bfile
  - id: convert_alphabet
    type:
      - 'null'
      - boolean
    doc: 'Convert the alphabet of the target motif databases to the alphabet of the
      query motif database assuming the core symbols of the target motif alphabet
      are a subset; default: reject differences'
    inputBinding:
      position: 103
      prefix: -xalph
  - id: distance_metric
    type:
      - 'null'
      - string
    doc: 'Distance metric for scoring alignments (allr|ed|kullback|pearson|sandelin|blic1|blic5|llr1|llr5);
      default: ed'
    default: ed
    inputBinding:
      position: 103
      prefix: -dist
  - id: eps_logos
    type:
      - 'null'
      - boolean
    doc: "Create EPS logos; default: don't create EPS logos"
    inputBinding:
      position: 103
      prefix: -eps
  - id: incomplete_scores
    type:
      - 'null'
      - boolean
    doc: 'Ignore unaligned columns in computing scores; default: use complete set
      of columns'
    inputBinding:
      position: 103
      prefix: -incomplete-scores
  - id: internal_alignments
    type:
      - 'null'
      - boolean
    doc: 'Only allow internal alignments; default: allow overhangs'
    inputBinding:
      position: 103
      prefix: -internal
  - id: min_overlap
    type:
      - 'null'
      - int
    doc: 'Minimum overlap between query and target; default: 1'
    default: 1
    inputBinding:
      position: 103
      prefix: -min-overlap
  - id: motif_id
    type:
      - 'null'
      - type: array
        items: string
    doc: Use only query motifs with a specified id; may be repeated
    inputBinding:
      position: 103
      prefix: -m
  - id: motif_index
    type:
      - 'null'
      - type: array
        items: int
    doc: Use only query motifs with a specified index; may be repeated
    inputBinding:
      position: 103
      prefix: -mi
  - id: motif_pseudo
    type:
      - 'null'
      - float
    doc: 'Apply the pseudocount to the query and target motifs; default: apply a pseudocount
      of 0.1'
    default: 0.1
    inputBinding:
      position: 103
      prefix: -motif-pseudo
  - id: no_reverse_complement
    type:
      - 'null'
      - boolean
    doc: Do not score the reverse complements of targets
    inputBinding:
      position: 103
      prefix: -norc
  - id: no_small_sample_correction
    type:
      - 'null'
      - boolean
    doc: "Don't apply small-sample correction to logos; default: use small-sample
      correction"
    inputBinding:
      position: 103
      prefix: -no-ssc
  - id: png_logos
    type:
      - 'null'
      - boolean
    doc: "Create PNG logos; default: don't create PNG logos"
    inputBinding:
      position: 103
      prefix: -png
  - id: text_output
    type:
      - 'null'
      - boolean
    doc: 'Output in text (TSV) format to stdout; overrides -o and -oc; default: output
      all formats to files in <output dir>'
    inputBinding:
      position: 103
      prefix: -text
  - id: threshold
    type:
      - 'null'
      - float
    doc: 'Significance threshold; default: 0.5'
    default: 0.5
    inputBinding:
      position: 103
      prefix: -thresh
  - id: time_limit
    type:
      - 'null'
      - int
    doc: quit before <time> seconds elapsed; <time> must be > 0. The Default is unlimited
      elapsed time
    inputBinding:
      position: 103
      prefix: -time
  - id: use_evalue
    type:
      - 'null'
      - boolean
    doc: 'Use E-value threshold; default: q-value'
    inputBinding:
      position: 103
      prefix: -evalue
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Set the verbosity of the program; default: 2 (normal)'
    default: 2
    inputBinding:
      position: 103
      prefix: -verbosity
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Name of directory for output files; will not replace existing directory
    outputBinding:
      glob: $(inputs.output_dir)
  - id: output_dir_replace
    type:
      - 'null'
      - Directory
    doc: Name of directory for output files; will replace existing directory
    outputBinding:
      glob: $(inputs.output_dir_replace)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meme:5.5.9--pl5321h1ca524f_0
