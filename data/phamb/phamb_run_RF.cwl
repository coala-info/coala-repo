cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - run_RF.py
label: phamb_run_RF
doc: "Predict viral bins from VAMB clusters with the PHAMB random forest model.
  The annotation directory must hold all.DVF.predictions.txt, all.hmmVOG.tbl and
  all.hmmMiComplete105.tbl.\n\nTool homepage: https://github.com/RasmussenLab/phamb"
inputs:
  - id: fastafile
    type: File
    doc: Path to concatenated assembly VAMB
    inputBinding:
      position: 1
  - id: clusterspath
    type: File
    doc: Path to clusters.tsv
    inputBinding:
      position: 2
  - id: annotationdir
    type: Directory
    doc: Path to directory with contig annotations
    inputBinding:
      position: 3
  - id: directoryout
    type: string
    doc: Path to directory out
    inputBinding:
      position: 4
  - id: min_bin_size
    type:
      - 'null'
      - int
    doc: Minimum size of bins - default [5000]
    inputBinding:
      position: 5
      prefix: -m
  - id: separator
    type:
      - 'null'
      - string
    doc: Binsplit separator
    inputBinding:
      position: 6
      prefix: -s
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory with the RF predictions and the viral bins
    outputBinding:
      glob: $(inputs.directoryout)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.directoryout)
        entry: '$({"class": "Directory", "basename": inputs.directoryout, "listing": []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phamb:1.0.1--pyhdfd78af_0
