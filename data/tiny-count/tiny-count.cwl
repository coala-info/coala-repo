cwlVersion: v1.2
class: CommandLineTool
baseCommand: tiny-count
label: tiny-count
doc: "tiny-count is a precision counting tool for hierarchical classification and\n  quantification of small RNA-seq reads. The Paths File names the Samples Sheet, the\n  Features Sheet and the GFF files; stage every file it names in the working\n  directory with referenced_files and use relative paths (./name) in the Paths File.\n\nTool homepage: https://github.com/MontgomeryLab/tinyRNA"
inputs:
  - id: paths_file
    type:
      - 'null'
      - File
    doc: Your Paths File
    inputBinding:
      position: 1
      prefix: --paths-file
      valueFrom: $(self.basename)
  - id: referenced_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files named in the Paths File (Samples Sheet, Features Sheet, SAM/BAM
      files, GFF files, reference files). They are staged in the working
      directory under their file names.
  - id: get_templates
    type:
      - 'null'
      - boolean
    doc: Copies the template configuration files required by tiny-count into
      the current directory.
    inputBinding:
      position: 2
      prefix: --get-templates
  - id: out_prefix
    type:
      - 'null'
      - string
    doc: The output prefix to use for file names. All occurrences of the
      substring {timestamp} will be replaced with the current date and time.
      (default tiny-count_{timestamp})
    inputBinding:
      position: 3
      prefix: --out-prefix
  - id: normalize_by_genomic_hits
    type:
      - 'null'
      - string
    doc: Normalize counts by genomic hits, T or F. (default T)
    inputBinding:
      position: 4
      prefix: --normalize-by-genomic-hits
  - id: normalize_by_feature_hits
    type:
      - 'null'
      - string
    doc: Normalize counts by feature hits, T or F. (default T)
    inputBinding:
      position: 5
      prefix: --normalize-by-feature-hits
  - id: verify_stats
    type:
      - 'null'
      - string
    doc: Verify that all reported stats are internally consistent, T or F.
      (default T)
    inputBinding:
      position: 6
      prefix: --verify-stats
  - id: decollapse
    type:
      - 'null'
      - boolean
    doc: Create a decollapsed SAM copy of all files listed in your Samples
      Sheet. This option is ignored for non-collapsed inputs.
    inputBinding:
      position: 7
      prefix: --decollapse
  - id: stepvector
    type:
      - 'null'
      - string
    doc: Select which StepVector implementation is used to find features
      overlapping an interval, Cython or HTSeq. (default Cython)
    inputBinding:
      position: 8
      prefix: --stepvector
  - id: in_pipeline
    type:
      - 'null'
      - boolean
    doc: Indicates that tiny-count was invoked as part of a pipeline run and that
      input files should be sourced as such.
    inputBinding:
      position: 9
      prefix: --in-pipeline
  - id: report_diags
    type:
      - 'null'
      - boolean
    doc: Produce diagnostic information about uncounted/eliminated selection
      elements.
    inputBinding:
      position: 10
      prefix: --report-diags
outputs:
  - id: results
    type:
      - 'null'
      - type: array
        items: File
    doc: Counting results (feature counts, statistics and logs) written to the
      working directory
    outputBinding:
      glob: $(inputs.out_prefix)*
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = (inputs.referenced_files || []).slice();
        if (inputs.paths_file) { l.push(inputs.paths_file); }
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tiny-count:1.5.0--py39h9948957_2
