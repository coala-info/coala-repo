cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - PyClone
  - build_mutations_file
label: pyclone_build_mutations_file
doc: "Build a YAML format file with mutation data and states prior to be used for PyClone analysis.\n\nTool homepage: https://github.com/Roth-Lab/pyclone"
inputs:
  - id: in_file
    type: File
    doc: "Path to tab separated input file with header and the columns mutation_id, ref_counts, var_counts, normal_cn, minor_cn, major_cn."
    inputBinding:
      position: 1
      prefix: --in_file
  - id: out_file
    type: string
    doc: "Path where YAML formatted PyClone input file will be written."
    inputBinding:
      position: 1
      prefix: --out_file
  - id: prior
    type:
      - 'null'
      - string
    doc: "Method used to set the possible genotypes (major_copy_number, parental_copy_number or total_copy_number). Default is major_copy_number."
    inputBinding:
      position: 1
      prefix: --prior
outputs:
  - id: mutations_yaml
    type: File
    doc: "YAML formatted PyClone mutations file."
    outputBinding:
      glob: $(inputs.out_file)
requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      - envName: MPLBACKEND
        envValue: Agg
      - envName: NUMBA_CACHE_DIR
        envValue: /tmp
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyclone:0.13.1--py_0
