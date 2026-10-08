cwlVersion: v1.2
class: CommandLineTool
baseCommand: gdi
label: genomics-data-index_gdi_build_alignment
doc: "Build a multiple sequence alignment from the variants in the index.\n\nThe tool needs a project folder made by \"gdi init\". It is passed as project_dir.\n\nTool homepage: https://github.com/apetkau/genomics-data-index"
arguments:
  - position: 3
    valueFrom: build
  - position: 4
    valueFrom: alignment
  - position: 20
    valueFrom: |
      ${
        var r = [];
        (inputs.include_variants || []).forEach(function(s) { r.push("--include-variants"); r.push(s); });
        return r;
      }
  - position: 20
    valueFrom: |
      ${
        var r = [];
        (inputs.sample || []).forEach(function(s) { r.push("--sample"); r.push(s); });
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
  - id: output_file
    type: string
    doc: "Output file"
    inputBinding:
      position: 10
      prefix: --output-file
  - id: reference_name
    type: string
    doc: "Reference genome name"
    inputBinding:
      position: 11
      prefix: --reference-name
  - id: align_type
    type:
      - 'null'
      - string
    doc: "The type of alignment to generate: core or full (\"core\" implies only --include-variants SNP). Default: full"
    inputBinding:
      position: 12
      prefix: --align-type
  - id: include_variants
    type:
      - 'null'
      - type: array
        items: string
    doc: "Which type of variant(s) to include in tree (SNP, MNP, DELETION, DELETION_OTHER). Default: SNP, MNP, DELETION"
  - id: sample
    type:
      - 'null'
      - type: array
        items: string
    doc: "Sample to include in alignment (can list more than one)"
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output"
  - id: output_file_out
    type:
      - 'null'
      - File
    doc: "Alignment file"
    outputBinding:
      glob: $(inputs.output_file)
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
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomics-data-index:0.9.2--pyhdfd78af_0
stdout: genomics-data-index_gdi_build_alignment.out
