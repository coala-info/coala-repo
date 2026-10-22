cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seismic
  - mask
label: seismic-rna_seismic_mask
doc: 'Define mutations and regions to filter reads and positions.


  Tool homepage: https://github.com/rouskinlab/seismic-rna'
inputs:
  - id: input_dir
    type: Directory
    doc: Output directory of the previous step. It is copied into the working directory
      as the output directory (named by --out-dir, default out)
  - id: input_path
    type:
      - 'null'
      - type: array
        items: string
    default:
      - out
    doc: Files or directories inside the output directory to process (paths start
      with the output directory name)
    inputBinding:
      position: 201
  - id: branch
    type:
      - 'null'
      - string
    doc: 'Create a new branch of the workflow with this name [default: ""]'
    inputBinding:
      position: 100
      prefix: --branch
  - id: tmp_pfx
    type:
      - 'null'
      - string
    doc: 'Write all temporary files to a directory with this prefix [default: ./tmp]'
    inputBinding:
      position: 100
      prefix: --tmp-pfx
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: 'Keep temporary files after finishing [default: erase-tmp]'
    inputBinding:
      position: 100
      prefix: --keep-tmp
  - id: erase_tmp
    type:
      - 'null'
      - boolean
    doc: 'Keep temporary files after finishing [default: erase-tmp]'
    inputBinding:
      position: 100
      prefix: --erase-tmp
  - id: mask_coords
    type:
      - 'null'
      - type: array
        items: mask_coords_rec
        inputBinding:
          position: 100
    doc: ' Select a region of a reference given its 5'' and 3'' end coordinates'
  - id: mask_primers
    type:
      - 'null'
      - type: array
        items: mask_primers_rec
        inputBinding:
          position: 100
    doc: ' Select a region of a reference given its forward and reverse primers'
  - id: primer_gap
    type:
      - 'null'
      - int
    doc: 'Leave a gap of this many bases between the primer and the region [default:
      0]'
    inputBinding:
      position: 100
      prefix: --primer-gap
  - id: mask_regions_file
    type:
      - 'null'
      - File
    doc: Select regions of references from coordinates/primers in a CSV file
    inputBinding:
      position: 100
      prefix: --mask-regions-file
  - id: mask_del
    type:
      - 'null'
      - boolean
    doc: 'Mask deletions [default: mask-del]'
    inputBinding:
      position: 100
      prefix: --mask-del
  - id: keep_del
    type:
      - 'null'
      - boolean
    doc: 'Mask deletions [default: mask-del]'
    inputBinding:
      position: 100
      prefix: --keep-del
  - id: mask_ins
    type:
      - 'null'
      - boolean
    doc: 'Mask insertions [default: mask-ins]'
    inputBinding:
      position: 100
      prefix: --mask-ins
  - id: keep_ins
    type:
      - 'null'
      - boolean
    doc: 'Mask insertions [default: mask-ins]'
    inputBinding:
      position: 100
      prefix: --keep-ins
  - id: mask_mut
    type:
      - 'null'
      - string
    doc: Mask this type of mutation
    inputBinding:
      position: 100
      prefix: --mask-mut
  - id: count_mut
    type:
      - 'null'
      - string
    doc: Count only this type of mutation
    inputBinding:
      position: 100
      prefix: --count-mut
  - id: mask_polya
    type:
      - 'null'
      - int
    doc: 'Mask stretches of at least this many consecutive A bases (0 disables) [default:
      5]'
    inputBinding:
      position: 100
      prefix: --mask-polya
  - id: mask_gu
    type:
      - 'null'
      - boolean
    doc: 'Mask G and U bases [default: mask-gu]'
    inputBinding:
      position: 100
      prefix: --mask-gu
  - id: keep_gu
    type:
      - 'null'
      - boolean
    doc: 'Mask G and U bases [default: mask-gu]'
    inputBinding:
      position: 100
      prefix: --keep-gu
  - id: mask_pos
    type:
      - 'null'
      - type: array
        items: mask_pos_rec
        inputBinding:
          position: 100
    doc: Mask this position in this reference
  - id: mask_pos_file
    type:
      - 'null'
      - File
    doc: Mask positions in references from a file
    inputBinding:
      position: 100
      prefix: --mask-pos-file
  - id: min_ninfo_pos
    type:
      - 'null'
      - int
    doc: 'Mask positions with fewer than this many informative base calls [default:
      1000]'
    inputBinding:
      position: 100
      prefix: --min-ninfo-pos
  - id: max_fmut_pos
    type:
      - 'null'
      - float
    doc: 'Mask positions with more than this fraction of mutated base calls [default:
      1.0]'
    inputBinding:
      position: 100
      prefix: --max-fmut-pos
  - id: mask_read
    type:
      - 'null'
      - string
    doc: Mask the read with this name
    inputBinding:
      position: 100
      prefix: --mask-read
  - id: mask_read_file
    type:
      - 'null'
      - File
    doc: Mask the reads with names in this file
    inputBinding:
      position: 100
      prefix: --mask-read-file
  - id: mask_discontig
    type:
      - 'null'
      - boolean
    doc: ' Mask paired-end reads with discontiguous mates [default: mask-discontig]'
    inputBinding:
      position: 100
      prefix: --mask-discontig
  - id: keep_discontig
    type:
      - 'null'
      - boolean
    doc: ' Mask paired-end reads with discontiguous mates [default: mask-discontig]'
    inputBinding:
      position: 100
      prefix: --keep-discontig
  - id: min_ncov_read
    type:
      - 'null'
      - int
    doc: 'Mask reads with fewer than this many bases covering the region [default:
      1]'
    inputBinding:
      position: 100
      prefix: --min-ncov-read
  - id: min_finfo_read
    type:
      - 'null'
      - float
    doc: 'Mask reads with less than this fraction of informative base calls [default:
      0.95]'
    inputBinding:
      position: 100
      prefix: --min-finfo-read
  - id: max_fmut_read
    type:
      - 'null'
      - float
    doc: 'Mask reads with more than this fraction of mutated base calls [default:
      1.0]'
    inputBinding:
      position: 100
      prefix: --max-fmut-read
  - id: min_mut_gap
    type:
      - 'null'
      - int
    doc: 'Mask reads with two mutations separated by fewer than this many bases [default:
      4]'
    inputBinding:
      position: 100
      prefix: --min-mut-gap
  - id: quick_unbias
    type:
      - 'null'
      - boolean
    doc: ' Correct observer bias using a quick (typically linear time) heuristic [default:
      quick-unbias]'
    inputBinding:
      position: 100
      prefix: --quick-unbias
  - id: exact_unbias
    type:
      - 'null'
      - boolean
    doc: ' Correct observer bias using a quick (typically linear time) heuristic [default:
      quick-unbias]'
    inputBinding:
      position: 100
      prefix: --exact-unbias
  - id: quick_unbias_thresh
    type:
      - 'null'
      - float
    doc: 'Treat mutated fractions under this threshold as 0 with --quick-unbias [default:
      0.001]'
    inputBinding:
      position: 100
      prefix: --quick-unbias-thresh
  - id: max_mask_iter
    type:
      - 'null'
      - int
    doc: 'Stop masking after this many iterations (0 for no limit) [default: 0]'
    inputBinding:
      position: 100
      prefix: --max-mask-iter
  - id: mask_pos_table
    type:
      - 'null'
      - boolean
    doc: ' Tabulate relationships per position for mask data [default: mask-pos-table]'
    inputBinding:
      position: 100
      prefix: --mask-pos-table
  - id: no_mask_pos_table
    type:
      - 'null'
      - boolean
    doc: ' Tabulate relationships per position for mask data [default: mask-pos-table]'
    inputBinding:
      position: 100
      prefix: --no-mask-pos-table
  - id: mask_read_table
    type:
      - 'null'
      - boolean
    doc: ' Tabulate relationships per read for mask data [default: mask-read-table]'
    inputBinding:
      position: 100
      prefix: --mask-read-table
  - id: no_mask_read_table
    type:
      - 'null'
      - boolean
    doc: ' Tabulate relationships per read for mask data [default: mask-read-table]'
    inputBinding:
      position: 100
      prefix: --no-mask-read-table
  - id: brotli_level
    type:
      - 'null'
      - int
    doc: 'Compress pickle files with this level of Brotli (0 - 11) [default: 10]'
    inputBinding:
      position: 100
      prefix: --brotli-level
  - id: num_cpus
    type:
      - 'null'
      - int
    doc: 'Use up to this many CPUs simultaneously [default: 20]'
    inputBinding:
      position: 100
      prefix: --num-cpus
  - id: force
    type:
      - 'null'
      - boolean
    doc: 'Force all tasks to run, overwriting any existing output files [default:
      no-force]'
    inputBinding:
      position: 100
      prefix: --force
  - id: no_force
    type:
      - 'null'
      - boolean
    doc: 'Force all tasks to run, overwriting any existing output files [default:
      no-force]'
    inputBinding:
      position: 100
      prefix: --no-force
outputs:
  - id: out_dir_result
    type: Directory
    doc: Output directory with all results
    outputBinding:
      glob: out
requirements:
  - class: InlineJavascriptRequirement
  - class: SchemaDefRequirement
    types:
      - name: mask_coords_rec
        type: record
        fields:
          - name: reference
            type: string
            inputBinding:
              position: 1
              prefix: --mask-coords
          - name: end5
            type: int
            inputBinding:
              position: 2
          - name: end3
            type: int
            inputBinding:
              position: 3
      - name: mask_primers_rec
        type: record
        fields:
          - name: reference
            type: string
            inputBinding:
              position: 1
              prefix: --mask-primers
          - name: forward_primer
            type: string
            inputBinding:
              position: 2
          - name: reverse_primer
            type: string
            inputBinding:
              position: 3
      - name: mask_pos_rec
        type: record
        fields:
          - name: reference
            type: string
            inputBinding:
              position: 1
              prefix: --mask-pos
          - name: position
            type: int
            inputBinding:
              position: 2
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_dir)
        entryname: out
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
