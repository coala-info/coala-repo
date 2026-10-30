cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - spectrast_cluster.py
label: msproteomicstools_spectrast_cluster.py
doc: "Cluster the spectra of SpectraST sptxt files by iRT and write the clusters in separate .sptxt files.\n\nTool homepage: https://github.com/msproteomicstools/msproteomicstools"
inputs:
  - id: sptxt_files
    type: 'File[]'
    doc: "SpectraST .sptxt file(s)"
    inputBinding:
      position: 20
      valueFrom: $(self.map(function(f){return f.basename;}))
  - id: distance
    type: ['null', float]
    doc: "Cluster distance (default 1)"
    inputBinding:
      prefix: -d
outputs:
  - id: cluster_files
    type: 'File[]'
    doc: "Cluster files"
    outputBinding:
      glob: "*_[0-9]*.sptxt"
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.sptxt_files)
        writable: true
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
stdout: msproteomicstools_spectrast_cluster.py.out
