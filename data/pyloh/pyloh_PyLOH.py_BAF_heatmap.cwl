cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - PyLOH.py
  - BAF_heatmap
label: pyloh_PyLOH.py_BAF_heatmap
doc: "Generates a BAF heatmap from preprocessed files.\n\nTool homepage: https://github.com/uci-cbcl/PyLOH"
inputs:
  - id: filename_base
    type: string
    doc: Base name of preprocessed files created.
    inputBinding:
      position: 1
  - id: preprocessed_files
    type:
      type: array
      items: File
    doc: Preprocessed files created by the preprocess step (counts, segments and
      BAF heat map), staged in the working directory next to the base name.
outputs:
  - id: heatmap_plots
    type: Directory
    doc: Directory with the BAF heat map plot of each segment
    outputBinding:
      glob: $(inputs.filename_base).PyLOH.heatmap.plot
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: MPLBACKEND
        envValue: Agg
  - class: InitialWorkDirRequirement
    listing: $(inputs.preprocessed_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyloh:1.4.3--py27_0
stdout: pyloh_PyLOH.py_BAF_heatmap.out