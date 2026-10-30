cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seismic
  - graph
  - aucroll
label: seismic-rna_seismic_graph_aucroll
doc: 'Rolling AUC-ROC comparing a profile to a structure.


  Tool homepage: https://github.com/rouskinlab/seismic-rna'
inputs:
  - id: input_dir
    type: Directory
    doc: Output directory of the previous step(s). It is copied into the working directory
      under the name given by the output directory option (default out, or sim for
      the sim commands).
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
  - id: cgroup
    type:
      - 'null'
      - string
    doc: 'Put each Cluster in its own file, each K in its own file, or All clusters
      in one file [default: k]'
    inputBinding:
      position: 100
      prefix: --cgroup
  - id: verify_times
    type:
      - 'null'
      - boolean
    doc: ' Verify that report files from later steps have later timestamps [default:
      verify- times]'
    inputBinding:
      position: 100
      prefix: --verify-times
  - id: no_verify_times
    type:
      - 'null'
      - boolean
    doc: ' Verify that report files from later steps have later timestamps [default:
      verify- times]'
    inputBinding:
      position: 100
      prefix: --no-verify-times
  - id: use_ratio
    type:
      - 'null'
      - boolean
    doc: 'Graph ratios or counts [default: use-ratio]'
    inputBinding:
      position: 100
      prefix: --use-ratio
  - id: use_count
    type:
      - 'null'
      - boolean
    doc: 'Graph ratios or counts [default: use-ratio]'
    inputBinding:
      position: 100
      prefix: --use-count
  - id: rels
    type:
      - 'null'
      - string
    doc: 'Graph these relationship(s) [default: m]'
    inputBinding:
      position: 100
      prefix: --rels
  - id: quantile
    type:
      - 'null'
      - float
    doc: 'Normalize and winsorize ratios to this quantile (0.0 disables) [default:
      0.0]'
    inputBinding:
      position: 100
      prefix: --quantile
  - id: struct_file
    type:
      - 'null'
      - string
    doc: Compare mutational profiles to the structure(s) in this CT file (path of
      the CT file inside the staged output directory, for example out/<sample>/fold/<ref>/<region>/<profile>.ct)
    inputBinding:
      position: 100
      prefix: --struct-file
  - id: branch
    type:
      - 'null'
      - string
    doc: 'Create a new branch of the workflow with this name [default: ""]'
    inputBinding:
      position: 100
      prefix: --branch
  - id: fold_regions_file
    type:
      - 'null'
      - File
    doc: Fold regions of references from coordinates/primers in a CSV file
    inputBinding:
      position: 100
      prefix: --fold-regions-file
  - id: fold_coords
    type:
      - 'null'
      - type: array
        items: fold_coords_rec
        inputBinding:
          position: 100
    doc: ' Fold a region of a reference given its 5'' and 3'' end coordinates (give
      the option once per record)'
  - id: fold_primers
    type:
      - 'null'
      - type: array
        items: fold_primers_rec
        inputBinding:
          position: 100
    doc: ' Fold a region of a reference given its forward and reverse primers (give
      the option once per record)'
  - id: fold_full
    type:
      - 'null'
      - boolean
    doc: 'If no regions are specified, whether to default to the full region or to
      the table''s region [default: fold-full]'
    inputBinding:
      position: 100
      prefix: --fold-full
  - id: fold_table
    type:
      - 'null'
      - boolean
    doc: 'If no regions are specified, whether to default to the full region or to
      the table''s region [default: fold-full]'
    inputBinding:
      position: 100
      prefix: --fold-table
  - id: window
    type:
      - 'null'
      - int
    doc: 'Use a sliding window of this many bases [default: 45]'
    inputBinding:
      position: 100
      prefix: --window
  - id: winmin
    type:
      - 'null'
      - int
    doc: 'Mask sliding windows with fewer than this number of data [default: 9]'
    inputBinding:
      position: 100
      prefix: --winmin
  - id: csv
    type:
      - 'null'
      - boolean
    doc: 'Output the data for each graph in a Comma- Separated Values file [default:
      csv]'
    inputBinding:
      position: 100
      prefix: --csv
  - id: no_csv
    type:
      - 'null'
      - boolean
    doc: 'Output the data for each graph in a Comma- Separated Values file [default:
      csv]'
    inputBinding:
      position: 100
      prefix: --no-csv
  - id: html
    type:
      - 'null'
      - boolean
    doc: 'Output each graph in an interactive HyperText Markup Language file [default:
      html]'
    inputBinding:
      position: 100
      prefix: --html
  - id: no_html
    type:
      - 'null'
      - boolean
    doc: 'Output each graph in an interactive HyperText Markup Language file [default:
      html]'
    inputBinding:
      position: 100
      prefix: --no-html
  - id: svg
    type:
      - 'null'
      - boolean
    doc: 'Output each graph in a Scalable Vector Graphics file [default: no-svg]'
    inputBinding:
      position: 100
      prefix: --svg
  - id: no_svg
    type:
      - 'null'
      - boolean
    doc: 'Output each graph in a Scalable Vector Graphics file [default: no-svg]'
    inputBinding:
      position: 100
      prefix: --no-svg
  - id: pdf
    type:
      - 'null'
      - boolean
    doc: 'Output each graph in a Portable Document Format file [default: no-pdf]'
    inputBinding:
      position: 100
      prefix: --pdf
  - id: no_pdf
    type:
      - 'null'
      - boolean
    doc: 'Output each graph in a Portable Document Format file [default: no-pdf]'
    inputBinding:
      position: 100
      prefix: --no-pdf
  - id: png
    type:
      - 'null'
      - boolean
    doc: 'Output each graph in a Portable Network Graphics file [default: no-png]'
    inputBinding:
      position: 100
      prefix: --png
  - id: no_png
    type:
      - 'null'
      - boolean
    doc: 'Output each graph in a Portable Network Graphics file [default: no-png]'
    inputBinding:
      position: 100
      prefix: --no-png
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
  - id: num_cpus
    type:
      - 'null'
      - int
    doc: 'Use up to this many CPUs simultaneously [default: 20]'
    inputBinding:
      position: 100
      prefix: --num-cpus
outputs:
  - id: out_dir_result
    type: Directory
    doc: Output directory with all results
    outputBinding:
      glob: out
requirements:
  - class: SchemaDefRequirement
    types:
      - name: fold_coords_rec
        type: record
        fields:
          - name: reference
            type: string
            inputBinding:
              position: 1
              prefix: --fold-coords
          - name: end5
            type: int
            inputBinding:
              position: 2
          - name: end3
            type: int
            inputBinding:
              position: 3
      - name: fold_primers_rec
        type: record
        fields:
          - name: reference
            type: string
            inputBinding:
              position: 1
              prefix: --fold-primers
          - name: forward_primer
            type: string
            inputBinding:
              position: 2
          - name: reverse_primer
            type: string
            inputBinding:
              position: 3
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_dir)
        entryname: out
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
