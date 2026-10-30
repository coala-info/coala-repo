cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seismic
  - draw
label: seismic-rna_seismic_draw
doc: 'Draw RNA structures with reactivities using RNArtistCore.


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
  - id: struct_num
    type:
      - 'null'
      - int
    doc: Draw the specified structure (zero-indexed) or -1 for all structures. By
      default, draw the structure with the best AUROC.
    inputBinding:
      position: 100
      prefix: --struct-num
  - id: color
    type:
      - 'null'
      - boolean
    doc: 'Color bases by their reactivity [default: color]'
    inputBinding:
      position: 100
      prefix: --color
  - id: no_color
    type:
      - 'null'
      - boolean
    doc: 'Color bases by their reactivity [default: color]'
    inputBinding:
      position: 100
      prefix: --no-color
  - id: draw_svg
    type:
      - 'null'
      - boolean
    doc: 'Output each drawing in a Scalable Vector Graphics file [default: draw-svg]'
    inputBinding:
      position: 100
      prefix: --draw-svg
  - id: no_draw_svg
    type:
      - 'null'
      - boolean
    doc: 'Output each drawing in a Scalable Vector Graphics file [default: draw-svg]'
    inputBinding:
      position: 100
      prefix: --no-draw-svg
  - id: draw_png
    type:
      - 'null'
      - boolean
    doc: 'Output each drawing in a Portable Network Graphics file [default: no-draw-png]'
    inputBinding:
      position: 100
      prefix: --draw-png
  - id: no_draw_png
    type:
      - 'null'
      - boolean
    doc: 'Output each drawing in a Portable Network Graphics file [default: no-draw-png]'
    inputBinding:
      position: 100
      prefix: --no-draw-png
  - id: update_rnartistcore
    type:
      - 'null'
      - boolean
    doc: ' Check for and install updates to RNArtistCore. [default: no-update- rnartistcore]'
    inputBinding:
      position: 100
      prefix: --update-rnartistcore
  - id: no_update_rnartistcore
    type:
      - 'null'
      - boolean
    doc: ' Check for and install updates to RNArtistCore. [default: no-update- rnartistcore]'
    inputBinding:
      position: 100
      prefix: --no-update-rnartistcore
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
