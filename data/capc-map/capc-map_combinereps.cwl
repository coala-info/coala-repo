cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - capC-MAP
  - combinereps
label: capc-map_combinereps
doc: "Combine multiple replicates into a single data set, and run binning, smoothing or normalization. A single configuration file, and multiple processed data directories are required.\n\nTool homepage: https://capc-map.readthedocs.io/"
inputs:
  - id: configfile
    type: File
    doc: "configuration file"
    inputBinding:
      position: 1
      prefix: -c
  - id: indir
    type:
      type: array
      items: Directory
      inputBinding:
        prefix: -i
    doc: "directory containing output from capC-MAP for a replicate (option must appear multiple times)."
    inputBinding:
      position: 1
  - id: outdir
    type: string
    doc: "directory to be created for combined output"
    inputBinding:
      position: 1
      prefix: -o
  - id: config_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files named in the configuration file (TARGETS and RESTFRAGS); staged in the working directory so the names in the configuration file resolve"
outputs:
  - id: combined_dir
    type: Directory
    doc: "directory with the combined output"
    outputBinding:
      glob: $(inputs.outdir)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.config_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/capc-map:1.1.3--py36h8619c78_0
