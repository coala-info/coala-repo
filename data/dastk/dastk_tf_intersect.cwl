cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tf_intersect
label: dastk_tf_intersect
doc: "Venn Diagram Generator. Generates a Venn Diagram for lists of significant TFs
  coming out of the DAStk differential MD score stats file results.\n\nTool homepage:
  https://github.com/Dowell-Lab/DAStk"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: "$({class: 'Directory', basename: inputs.output_dir, listing: []})"
        writable: true
inputs:
  - id: stats_files
    type:
      type: array
      items: File
    doc: Stats files (minimum of two). EITHER results from differential_md_score
      OR process_atac may be used, but file types should not be combined. File
      type is determined by 'differential' in the file name.
    inputBinding:
      position: 101
      prefix: --stats
  - id: rootname
    type: string
    doc: Rootname for saving plots.
    inputBinding:
      position: 101
      prefix: --rootname
  - id: output_dir
    type: string
    doc: Folder where plots will be saved (created by the wrapper).
    inputBinding:
      position: 101
      prefix: --output
  - id: unweighted
    type:
      - 'null'
      - boolean
    doc: Produce an unweighted (vs. propotional, default) venn diagram.
    inputBinding:
      position: 101
      prefix: --unweighted
  - id: significant
    type:
      - 'null'
      - boolean
    doc: Intersect motifs which are significant (differential MD score stats
      files only).
    inputBinding:
      position: 101
      prefix: --significant
  - id: enriched
    type:
      - 'null'
      - boolean
    doc: Intersect motifs which are enriched (either differentially or raw MD
      scores).
    inputBinding:
      position: 101
      prefix: --enriched
  - id: depleted
    type:
      - 'null'
      - boolean
    doc: Intersect motifs which are depleted (either differentially or raw MD
      scores).
    inputBinding:
      position: 101
      prefix: --depleted
  - id: pvalue
    type:
      - 'null'
      - float
    doc: p-value threshold for significant values which will be plotted.
      Default = 1e-6.
    inputBinding:
      position: 101
      prefix: --pvalue
  - id: md_score_threshold
    type:
      - 'null'
      - float
    doc: Differential MD score threshold for values which will be plotted
      (positive OR negative). Default = 0.1.
    inputBinding:
      position: 101
      prefix: --md-score-threshold
  - id: depleted_threshold
    type:
      - 'null'
      - float
    doc: Threshold for depletion raw MD score files. Default = 0.08.
    inputBinding:
      position: 101
      prefix: --depleted-threshold
  - id: enriched_threshold
    type:
      - 'null'
      - float
    doc: Threshold for enrichment raw MD score files. Default = 0.2.
    inputBinding:
      position: 101
      prefix: --enriched-threshold
  - id: labels
    type:
      - 'null'
      - type: array
        items: string
    doc: Plot labels for files provided. Number of labels provided must match
      the number of files provided.
    inputBinding:
      position: 101
      prefix: --labels
  - id: colors
    type:
      - 'null'
      - type: array
        items: string
    doc: Hex colors for files provided (one per file for 2 or 3 files, or 2 for
      the upset catplots of 4 or more files).
    inputBinding:
      position: 101
      prefix: --colors
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: motif_lists
    type:
      - 'null'
      - File
    doc: Motifs passing the thresholds in each file (<rootname>_motifs.txt)
    outputBinding:
      glob: $(inputs.output_dir)/$(inputs.rootname)_motifs.txt
  - id: plots
    type:
      type: array
      items: File
    doc: Venn diagram or upset plot (<rootname>_venn2.png, _venn3.png,
      _upset.png, ...)
    outputBinding:
      glob: $(inputs.output_dir)/$(inputs.rootname)_*.png
  - id: tables
    type:
      type: array
      items: File
    doc: Upset data or common motif tables (4 or more files)
    outputBinding:
      glob:
        - $(inputs.output_dir)/$(inputs.rootname)_upset_data.txt
        - $(inputs.output_dir)/$(inputs.rootname)_common_motif_data.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dastk:1.0.1--pyh7cba7a3_0
stdout: dastk_tf_intersect.out
