cwlVersion: v1.2
class: CommandLineTool
baseCommand: gdi
label: genomics-data-index_gdi_load_vcf
doc: "Load variants from VCF files listed in an input file (columns Sample, VCF, Mask File) into the index.\n\nThe tool needs a project folder made by \"gdi init\". It is passed as project_dir.\n\nTool homepage: https://github.com/apetkau/genomics-data-index"
arguments:
  - position: 3
    valueFrom: load
  - position: 4
    valueFrom: vcf
  - position: 20
    valueFrom: |
      ${
        var r = [];
        (inputs.include_variants || []).forEach(function(s) { r.push("--include-variants"); r.push(s); });
        return r;
      }
inputs:
  - id: project_dir
    type: Directory
    doc: "project folder made by gdi init (global option --project-dir)"
    inputBinding:
      position: 1
      prefix: --project-dir
      valueFrom: $(self.basename)
  - id: ncores
    type:
      - 'null'
      - int
    doc: "Number of cores for any parallel processing"
    inputBinding:
      position: 1
      prefix: --ncores
  - id: log_level
    type:
      - 'null'
      - string
    doc: "Sets the log level (TRACE, DEBUG, INFO, WARNING, ERROR, CRITICAL)"
    inputBinding:
      position: 1
      prefix: --log-level
  - id: reference_file
    type:
      - 'null'
      - File
    doc: "Reference genome file"
    inputBinding:
      position: 10
      prefix: --reference-file
  - id: reference_name
    type:
      - 'null'
      - string
    doc: "Reference genome name"
    inputBinding:
      position: 11
      prefix: --reference-name
  - id: index_unknown
    type:
      - 'null'
      - boolean
    doc: "Enable indexing unknown/missing positions (default)"
    inputBinding:
      position: 12
      prefix: --index-unknown
  - id: no_index_unknown
    type:
      - 'null'
      - boolean
    doc: "Disable indexing unknown/missing positions (faster)"
    inputBinding:
      position: 13
      prefix: --no-index-unknown
  - id: sample_batch_size
    type:
      - 'null'
      - int
    doc: "Number of samples to process within a single batch. Default: 2000"
    inputBinding:
      position: 14
      prefix: --sample-batch-size
  - id: build_tree
    type:
      - 'null'
      - boolean
    doc: "Builds tree of all samples after loading"
    inputBinding:
      position: 15
      prefix: --build-tree
  - id: no_build_tree
    type:
      - 'null'
      - boolean
    doc: "Do not build a tree after loading (default)"
    inputBinding:
      position: 16
      prefix: --no-build-tree
  - id: align_type
    type:
      - 'null'
      - string
    doc: "The type of alignment to generate: core or full (\"core\" implies only --include-variants SNP). Default: full"
    inputBinding:
      position: 17
      prefix: --align-type
  - id: include_variants
    type:
      - 'null'
      - type: array
        items: string
    doc: "Which type of variant(s) to include in tree (SNP, MNP, DELETION, DELETION_OTHER). Default: SNP, MNP, DELETION"
  - id: extra_tree_params
    type:
      - 'null'
      - string
    doc: "Extra parameters to tree-building software"
    inputBinding:
      position: 19
      prefix: --extra-tree-params
  - id: fofn
    type: File
    doc: "Tab-separated file with the columns Sample, VCF and Mask File"
    inputBinding:
      position: 100
  - id: data_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files named in the input file (staged in the working directory so the relative names resolve)"
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output"
  - id: project_dir_out
    type:
      - 'null'
      - Directory
    doc: "The project folder with the new data"
    outputBinding:
      glob: $(inputs.project_dir.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      - envName: USER
        envValue: gdi
      - envName: QT_QPA_PLATFORM
        envValue: offscreen
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [{"entry": inputs.project_dir, "writable": true}];
        (inputs.data_files || []).forEach(function(f) { l.push(f); });
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomics-data-index:0.9.2--pyhdfd78af_0
stdout: genomics-data-index_gdi_load_vcf.out
