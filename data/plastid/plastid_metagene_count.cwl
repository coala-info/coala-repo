cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metagene
  - count
label: plastid_metagene_count
doc: 'Count read densities around landmarks (for example start codons) and compute metagene profiles.


  Tool homepage: https://github.com/joshuagryphon/plastid'
inputs:
  - id: roi_file
    type: File
    doc: Text file containing maximal spanning windows and landmark positions, from the metagene generate subprogram
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
  - id: landmark
    type:
      - 'null'
      - string
    doc: Name of landmark at zero point, optional.
    inputBinding:
      position: 101
      prefix: --landmark
  - id: use_mean
    type:
      - 'null'
      - boolean
    doc: 'If supplied, use columnwise mean to generate profile (Default: use median)'
    inputBinding:
      position: 101
      prefix: --use_mean
  - id: keep
    type:
      - 'null'
      - boolean
    doc: 'Save intermediate count files. Useful for additional computations (Default: False)'
    inputBinding:
      position: 101
      prefix: --keep
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
  - id: maxmem
    type:
      - 'null'
      - int
    doc: 'Maximum desired memory footprint in MB to devote to BigBed/BigWig files. May be exceeded by large queries. (Default: 0, No maximum)'
    inputBinding:
      position: 101
      prefix: --maxmem
  - id: big_genome
    type:
      - 'null'
      - boolean
    doc: Use slower but memory-efficient implementation for big genomes or for memory-limited computers. For wiggle & bowtie files only.
    inputBinding:
      position: 101
      prefix: --big_genome
  - id: fiveprime_variable
    type:
      - 'null'
      - boolean
    doc: Map read alignment to a variable offset from 5' position of read, with offset determined by read length. Requires `--offset` below
    inputBinding:
      position: 101
      prefix: --fiveprime_variable
  - id: fiveprime
    type:
      - 'null'
      - boolean
    doc: Map read alignment to 5' position.
    inputBinding:
      position: 101
      prefix: --fiveprime
  - id: threeprime
    type:
      - 'null'
      - boolean
    doc: Map read alignment to 3' position
    inputBinding:
      position: 101
      prefix: --threeprime
  - id: center
    type:
      - 'null'
      - boolean
    doc: Subtract N positions from each end of read, and add 1/(length-N), to each remaining position, where N is specified by `--nibble`
    inputBinding:
      position: 101
      prefix: --center
  - id: offset
    type:
      - 'null'
      - int
      - File
    doc: 'For `--fiveprime` or `--threeprime`, provide an integer representing the offset into the read, starting from either the 5'' or 3'' end, at which data should be plotted. For `--fiveprime_variable`, provide the filename of a two-column tab-delimited text file, in which first column represents read length or the special keyword `''default''`, and the second column represents the offset from the five prime end of that read length at which the read should be mapped. (Default: 0)'
    inputBinding:
      position: 101
      prefix: --offset
  - id: nibble
    type:
      - 'null'
      - int
    doc: 'For use with `--center` only. nt to remove from each end of read before mapping (Default: 0)'
    inputBinding:
      position: 101
      prefix: --nibble
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
