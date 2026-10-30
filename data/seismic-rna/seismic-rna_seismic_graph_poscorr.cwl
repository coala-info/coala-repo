cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seismic
  - graph
  - poscorr
label: seismic-rna_seismic_graph_poscorr
doc: 'Phi correlations between pairs of positions.


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
  - id: rels
    type:
      - 'null'
      - string
    doc: 'Graph these relationship(s) [default: m]'
    inputBinding:
      position: 100
      prefix: --rels
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
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_dir)
        entryname: out
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
