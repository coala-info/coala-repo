cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seismic
  - migrate
label: seismic-rna_seismic_migrate
doc: 'Migrate output directories from v0.23 to v0.24


  Tool homepage: https://github.com/rouskinlab/seismic-rna'
inputs:
  - id: input_path
    type:
      type: array
      items: Directory
    doc: Output directories from SEISMIC-RNA v0.23 to migrate
    inputBinding:
      position: 201
  - id: out_dir
    type: string
    default: out
    doc: 'Write all output files to this directory [default: ./out]'
    inputBinding:
      position: 100
      prefix: --out-dir
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
      glob: $(inputs.out_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
