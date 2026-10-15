cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - psite
label: plastid_psite
doc: 'Estimate P-site offsets for each ribosome-protected footprint length from a ribosome profiling dataset.


  Tool homepage: https://github.com/joshuagryphon/plastid'
inputs:
  - id: roi_file
    type: File
    doc: ROI file surrounding start codons, from the metagene generate subprogram
    inputBinding:
      position: 1
  - id: outbase
    type: string
    doc: Basename for output files
    inputBinding:
      position: 2
  - id: min_counts
    type:
      - 'null'
      - int
    doc: 'Minimum counts required in normalization region to be included in metagene average (Default: 10)'
    inputBinding:
      position: 101
      prefix: --min_counts
  - id: normalize_over
    type:
      - 'null'
      - type: array
        items: int
    doc: 'Portion of each window against which its individual raw count profile will be normalized. Specify two integers, in nucleotide distance from landmark (negative for upstream, positive for downstream. Surround negative numbers with quotes.). (Default: 20 50)'
    inputBinding:
      position: 101
      prefix: --normalize_over
  - id: norm_region
    type:
      - 'null'
      - type: array
        items: int
    doc: 'Deprecated. Use ``--normalize_over`` instead. Formerly, Portion of each window against which its individual raw count profile will be normalized. Specify two integers, in nucleotide distance, from 5'' end of window. (Default: 70 100)'
    inputBinding:
      position: 101
      prefix: --norm_region
  - id: require_upstream
    type:
      - 'null'
      - boolean
    doc: If supplied, the P-site offset is taken to be the distance between the largest peak upstream of the start codon and the start codon itself. Otherwise, the P-site offset is taken to be the distance between the largest peak in the entire ROI and the start codon. Ignored if ``--constrain`` is used.
    inputBinding:
      position: 101
      prefix: --require_upstream
  - id: constrain
    type:
      - 'null'
      - type: array
        items: int
    doc: 'Constrain P-site offset to be between specified distance from start codon. Useful for noisy data. (Reasonable set: 10 15; default: not constrained)'
    inputBinding:
      position: 101
      prefix: --constrain
  - id: aggregate
    type:
      - 'null'
      - boolean
    doc: 'Estimate P-site from aggregate reads at each position, instead of median normalized read density. Noisier, but helpful for lower-count data or read lengths with few counts. (Default: False)'
    inputBinding:
      position: 101
      prefix: --aggregate
  - id: keep
    type:
      - 'null'
      - boolean
    doc: 'Save intermediate count files. Useful for additional computations (Default: False)'
    inputBinding:
      position: 101
      prefix: --keep
  - id: default
    type:
      - 'null'
      - int
    doc: 'Default 5'' P-site offset for read lengths that are not present or evaluated in the dataset. Unaffected by ``--constrain`` (Default: 13)'
    inputBinding:
      position: 101
      prefix: --default
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress all warning messages. Cannot use with '-v'.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Increase verbosity. With ''-v'', show every warning. With ''-vv'', turn warnings into exceptions. Cannot use with ''-q''. (Default: show each type of warning once)'
    inputBinding:
      position: 101
      prefix: --verbose
  - id: count_files
    type:
      - 'null'
      - type: array
        items: File
    doc: One or more count or alignment file(s) from a single sample or set of samples to be pooled.
    secondaryFiles:
      - pattern: .bai
        required: false
    inputBinding:
      position: 101
      prefix: --count_files
  - id: countfile_format
    type:
      - 'null'
      - string
    doc: 'Format of file containing alignments or counts (Default: BAM)'
    inputBinding:
      position: 101
      prefix: --countfile_format
  - id: sum
    type:
      - 'null'
      - float
    doc: 'Sum used in normalization of counts and RPKM/RPNT calculations (Default: total mapped reads/counts in dataset)'
    inputBinding:
      position: 101
      prefix: --sum
  - id: min_length
    type:
      - 'null'
      - int
    doc: 'Minimum read length required to be included (BAM & bowtie files only. Default: 25)'
    inputBinding:
      position: 101
      prefix: --min_length
  - id: max_length
    type:
      - 'null'
      - int
    doc: 'Maximum read length permitted to be included (BAM & bowtie files only. Default: 100)'
    inputBinding:
      position: 101
      prefix: --max_length
  - id: figformat
    type:
      - 'null'
      - string
    doc: 'File format for figure(s); Default: png)'
    inputBinding:
      position: 101
      prefix: --figformat
  - id: figsize
    type:
      - 'null'
      - type: array
        items: int
    doc: 'Figure width and height, in inches. (Default: use matplotlibrc params)'
    inputBinding:
      position: 101
      prefix: --figsize
  - id: title
    type:
      - 'null'
      - string
    doc: Base title for plot(s).
    inputBinding:
      position: 101
      prefix: --title
  - id: cmap
    type:
      - 'null'
      - string
    doc: 'Matplotlib color map from which palette will be made (e.g. ''Blues'',''autumn'',''Set1''; default: use colors from ``--stylesheet`` if given, or color cycle in matplotlibrc)'
    inputBinding:
      position: 101
      prefix: --cmap
  - id: dpi
    type:
      - 'null'
      - int
    doc: 'Figure resolution (Default: 150)'
    inputBinding:
      position: 101
      prefix: --dpi
  - id: stylesheet
    type:
      - 'null'
      - string
    doc: Use this matplotlib stylesheet instead of matplotlibrc params
    inputBinding:
      position: 101
      prefix: --stylesheet
outputs:
  - id: outputs
    type:
      type: array
      items: File
    doc: Files written with the given output basename
    outputBinding:
      glob: $(inputs.outbase)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plastid:0.6.1--py38h7d1810a_2
