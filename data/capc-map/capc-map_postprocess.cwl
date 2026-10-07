cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - capC-MAP
  - postprocess
label: capc-map_postprocess
doc: "Run binning, smoothing or normalization on capture c profiles. Required inputs are a config file (only lines relating to binning are read), and the directory containing raw pile-ups or validpairs files from capC-MAP run.\n\nTool homepage: https://capc-map.readthedocs.io/"
inputs:
  - id: configfile
    type: File
    doc: "configuration file"
    inputBinding:
      position: 1
      prefix: -c
  - id: outdir
    type: Directory
    doc: "directory with capC-MAP output for the experiment (captured_report.dat, captured_validpairs_*.pairs); staged writable, new files are added to it"
    inputBinding:
      position: 1
      prefix: -o
      valueFrom: $(self.basename)
  - id: config_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files named in the configuration file (TARGETS and RESTFRAGS); staged in the working directory so the names in the configuration file resolve"
outputs:
  - id: processed_dir
    type: Directory
    doc: "the output directory with the new pile-ups and binned profiles"
    outputBinding:
      glob: $(inputs.outdir.basename)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.outdir)
        writable: true
      - $(inputs.config_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/capc-map:1.1.3--py36h8619c78_0
