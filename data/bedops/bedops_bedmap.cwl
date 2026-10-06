cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedmap
label: bedops_bedmap
doc: Traverse <ref-file>, while applying <operation(s)> on qualified, 
  overlapping elements from <map-file>. Output is one line for each line in 
  <ref-file>, sent to standard output.
inputs:
  - id: ref_file
    type: File
    doc: Reference BED or Starch input file (must be sorted per sort-bed).
    inputBinding:
      position: 201
  - id: map_file
    type:
      - 'null'
      - File
    doc: Map BED or Starch input file (must be sorted per sort-bed). If omitted,
      ref-file is treated as both ref-file and map-file.
    inputBinding:
      position: 202
  - id: chrom
    type:
      - 'null'
      - string
    doc: Jump to and process data for given <chromosome> only.
    inputBinding:
      position: 103
      prefix: --chrom
  - id: delim
    type:
      - 'null'
      - string
    doc: Change output delimiter from '|' to <delim> between columns (e.g. 
      '\t').
    inputBinding:
      position: 103
      prefix: --delim
  - id: ec
    type:
      - 'null'
      - boolean
    doc: Error check all input files (slower).
    inputBinding:
      position: 103
      prefix: --ec
  - id: faster
    type:
      - 'null'
      - boolean
    doc: '(advanced) Strong input assumptions are made. Compatible with: --bp-ovr,
      --range, --fraction-both, and --exact overlap options only.'
    inputBinding:
      position: 103
      prefix: --faster
  - id: header
    type:
      - 'null'
      - boolean
    doc: Accept headers (VCF, GFF, SAM, BED, WIG) in any input file.
    inputBinding:
      position: 103
      prefix: --header
  - id: min_memory
    type:
      - 'null'
      - boolean
    doc: Minimize memory usage (slower).
    inputBinding:
      position: 103
      prefix: --min-memory
  - id: multidelim
    type:
      - 'null'
      - string
    doc: Change delimiter of multi-value output columns from ';' to <delim>.
    inputBinding:
      position: 103
      prefix: --multidelim
  - id: prec
    type:
      - 'null'
      - int
    doc: Change the post-decimal precision of scores to <int>. 0 <= <int>.
    inputBinding:
      position: 103
      prefix: --prec
  - id: sci
    type:
      - 'null'
      - boolean
    doc: Use scientific notation for score outputs.
    inputBinding:
      position: 103
      prefix: --sci
  - id: skip_unmapped
    type:
      - 'null'
      - boolean
    doc: Print no output for a row with no mapped elements.
    inputBinding:
      position: 103
      prefix: --skip-unmapped
  - id: sweep_all
    type:
      - 'null'
      - boolean
    doc: Ensure <map-file> is read completely (helps to prevent broken pipes).
    inputBinding:
      position: 103
      prefix: --sweep-all
  - id: unmapped_val
    type:
      - 'null'
      - string
    doc: Print <val> on unmapped --echo-map* and --min/max-element* operations. 
      The default is to print nothing.
    inputBinding:
      position: 103
      prefix: --unmapped-val
  - id: bp_ovr
    type:
      - 'null'
      - int
    doc: Require <int> bp overlap between elements of input files.
    inputBinding:
      position: 103
      prefix: --bp-ovr
  - id: exact
    type:
      - 'null'
      - boolean
    doc: First 3 fields from <map-file> must be identical to <ref-file>'s.
    inputBinding:
      position: 103
      prefix: --exact
  - id: fraction_both
    type:
      - 'null'
      - float
    doc: Both --fraction-ref <val> and --fraction-map <val> must be true to 
      qualify as overlapping. Expect 0 < val <= 1.
    inputBinding:
      position: 103
      prefix: --fraction-both
  - id: fraction_either
    type:
      - 'null'
      - float
    doc: Either --fraction-ref <val> or --fraction-map <val> must be true to 
      qualify as overlapping. Expect 0 < val <= 1.
    inputBinding:
      position: 103
      prefix: --fraction-either
  - id: fraction_map
    type:
      - 'null'
      - float
    doc: The fraction of the element's size from <map-file> that must overlap 
      the element in <ref-file>. Expect 0 < val <= 1.
    inputBinding:
      position: 103
      prefix: --fraction-map
  - id: fraction_ref
    type:
      - 'null'
      - float
    doc: The fraction of the element's size from <ref-file> that must overlap an
      element in <map-file>. Expect 0 < val <= 1.
    inputBinding:
      position: 103
      prefix: --fraction-ref
  - id: range
    type:
      - 'null'
      - int
    doc: Grab <map-file> elements within <int> bp of <ref-file>'s element, where
      0 <= int. --range 0 is an alias for --bp-ovr 1.
    inputBinding:
      position: 103
      prefix: --range
  - id: cv
    type:
      - 'null'
      - boolean
    doc: The result of --stdev divided by the result of --mean.
    inputBinding:
      position: 103
      prefix: --cv
  - id: kth
    type:
      - 'null'
      - float
    doc: Generalized median. Report the value, x, such that the fraction <val> 
      of overlapping elements' scores from <map-file> is less than x, and the 
      fraction 1-<val> of scores is greater than x. 0 < val <= 1.
    inputBinding:
      position: 103
      prefix: --kth
  - id: mad
    type:
      - 'null'
      - float
    doc: The median absolute deviation of overlapping elements in <map-file>. 
      Multiply mad score by <mult>. 0 < mult, and mult is 1 by default.
    inputBinding:
      position: 103
      prefix: --mad
  - id: max
    type:
      - 'null'
      - boolean
    doc: The highest score from overlapping elements in <map-file>.
    inputBinding:
      position: 103
      prefix: --max
  - id: max_element
    type:
      - 'null'
      - boolean
    doc: A (non-random) highest-scoring and overlapping element in <map-file>.
    inputBinding:
      position: 103
      prefix: --max-element
  - id: max_element_rand
    type:
      - 'null'
      - boolean
    doc: A random highest-scoring and overlapping element in <map-file>.
    inputBinding:
      position: 103
      prefix: --max-element-rand
  - id: mean
    type:
      - 'null'
      - boolean
    doc: The average score from overlapping elements in <map-file>.
    inputBinding:
      position: 103
      prefix: --mean
  - id: median
    type:
      - 'null'
      - boolean
    doc: The median score from overlapping elements in <map-file>.
    inputBinding:
      position: 103
      prefix: --median
  - id: min
    type:
      - 'null'
      - boolean
    doc: The lowest score from overlapping elements in <map-file>.
    inputBinding:
      position: 103
      prefix: --min
  - id: min_element
    type:
      - 'null'
      - boolean
    doc: A (non-random) lowest-scoring and overlapping element in <map-file>.
    inputBinding:
      position: 103
      prefix: --min-element
  - id: min_element_rand
    type:
      - 'null'
      - boolean
    doc: A random lowest-scoring and overlapping element in <map-file>.
    inputBinding:
      position: 103
      prefix: --min-element-rand
  - id: stdev
    type:
      - 'null'
      - boolean
    doc: The square root of the result of --variance.
    inputBinding:
      position: 103
      prefix: --stdev
  - id: sum
    type:
      - 'null'
      - boolean
    doc: Accumulated scores from overlapping elements in <map-file>.
    inputBinding:
      position: 103
      prefix: --sum
  - id: tmean
    type:
      - 'null'
      - type: array
        items: float
    doc: The mean score from overlapping elements in <map-file>, after ignoring 
      the bottom <low> and top <hi> fractions of those scores. 0 <= low <= 1. 0 
      <= hi <= 1. low+hi <= 1.
    inputBinding:
      position: 103
      prefix: --tmean
  - id: variance
    type:
      - 'null'
      - boolean
    doc: The variance of scores from overlapping elements in <map-file>.
    inputBinding:
      position: 103
      prefix: --variance
  - id: wmean
    type:
      - 'null'
      - boolean
    doc: Weighted mean, scaled in proportion to the coverage of the <ref-file> 
      element by each overlapping <map-file> element.
    inputBinding:
      position: 103
      prefix: --wmean
  - id: bases
    type:
      - 'null'
      - boolean
    doc: The total number of overlapping bases from <map-file>.
    inputBinding:
      position: 103
      prefix: --bases
  - id: bases_uniq
    type:
      - 'null'
      - boolean
    doc: The number of distinct bases from <ref-file>'s element covered by 
      overlapping elements in <map-file>.
    inputBinding:
      position: 103
      prefix: --bases-uniq
  - id: bases_uniq_f
    type:
      - 'null'
      - boolean
    doc: The fraction of distinct bases from <ref-file>'s element covered by 
      overlapping elements in <map-file>.
    inputBinding:
      position: 103
      prefix: --bases-uniq-f
  - id: count
    type:
      - 'null'
      - boolean
    doc: The number of overlapping elements in <map-file>.
    inputBinding:
      position: 103
      prefix: --count
  - id: echo
    type:
      - 'null'
      - boolean
    doc: Print each line from <ref-file>.
    inputBinding:
      position: 103
      prefix: --echo
  - id: echo_map
    type:
      - 'null'
      - boolean
    doc: List all overlapping elements from <map-file>.
    inputBinding:
      position: 103
      prefix: --echo-map
  - id: echo_map_id
    type:
      - 'null'
      - boolean
    doc: List IDs from all overlapping <map-file> elements.
    inputBinding:
      position: 103
      prefix: --echo-map-id
  - id: echo_map_id_uniq
    type:
      - 'null'
      - boolean
    doc: List unique IDs from overlapping <map-file> elements.
    inputBinding:
      position: 103
      prefix: --echo-map-id-uniq
  - id: echo_map_range
    type:
      - 'null'
      - boolean
    doc: Print genomic range of overlapping elements from <map-file>.
    inputBinding:
      position: 103
      prefix: --echo-map-range
  - id: echo_map_score
    type:
      - 'null'
      - boolean
    doc: List scores from overlapping <map-file> elements.
    inputBinding:
      position: 103
      prefix: --echo-map-score
  - id: echo_map_size
    type:
      - 'null'
      - boolean
    doc: List the full length of every overlapping element.
    inputBinding:
      position: 103
      prefix: --echo-map-size
  - id: echo_overlap_size
    type:
      - 'null'
      - boolean
    doc: List lengths of overlaps.
    inputBinding:
      position: 103
      prefix: --echo-overlap-size
  - id: echo_ref_name
    type:
      - 'null'
      - boolean
    doc: Print the first 3 fields of <ref-file> using chrom:start-end format.
    inputBinding:
      position: 103
      prefix: --echo-ref-name
  - id: echo_ref_row_id
    type:
      - 'null'
      - boolean
    doc: Print 'id-' followed by the line number of <ref-file>.
    inputBinding:
      position: 103
      prefix: --echo-ref-row-id
  - id: echo_ref_size
    type:
      - 'null'
      - boolean
    doc: Print the length of each line from <ref-file>.
    inputBinding:
      position: 103
      prefix: --echo-ref-size
  - id: indicator
    type:
      - 'null'
      - boolean
    doc: Print 1 if there exists an overlapping element in <map-file>, 0 
      otherwise.
    inputBinding:
      position: 103
      prefix: --indicator
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedops:2.4.42--hd6d6fdc_1
stdout: bedmap.out
s:url: http://bedops.readthedocs.io
$namespaces:
  s: https://schema.org/
