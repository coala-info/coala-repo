cwlVersion: v1.2
class: CommandLineTool
baseCommand: samestr_filter
label: samestr_filter
doc: "Filter SNV profiles based on various criteria.\n\nTool homepage: https://github.com/danielpodlesny/samestr/"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Path to input SNV Profiles. Should have .npy, .npz or .npy.gz 
      extension.
    default: []
    inputBinding:
      position: 1
  - id: input_names
    type:
      type: array
      items: File
    doc: Path to input name files.
    default: []
    inputBinding:
      position: 2
  - id: clade
    type:
      - 'null'
      - type: array
        items: string
    doc: Clade to process from input files. Processing all if not specified. 
      Names must correspond to the taxonomy of the respective database [e.g. 
      t__SGB10068 for MetaPhlAn or ref_mOTU_v3_00095 for mOTUs]
    default: None
    inputBinding:
      position: 103
      prefix: --clade
  - id: clade_min_samples
    type:
      - 'null'
      - int
    doc: Skipping clades with fewer than `clade-min-samples` samples.
    default: 2
    inputBinding:
      position: 103
      prefix: --clade-min-samples
  - id: delete_pos
    type:
      - 'null'
      - boolean
    doc: Delete masked marker and global positions from array instead of np.nan
    default: false
    inputBinding:
      position: 103
      prefix: --delete-pos
  - id: global_pos_min_f_vcov
    type:
      - 'null'
      - float
    doc: Remove positions covered by fewer than `global-pos-min-f-vcov` fraction
      of samples.
    default: false
    inputBinding:
      position: 103
      prefix: --global-pos-min-f-vcov
  - id: global_pos_min_n_vcov
    type:
      - 'null'
      - int
    doc: Remove positions covered by fewer than `global-pos-min-n-vcov` number 
      of samples. Overrides `global-pos-min-f-vcov`.
    default: 2
    inputBinding:
      position: 103
      prefix: --global-pos-min-n-vcov
  - id: keep_mono
    type:
      - 'null'
      - boolean
    doc: Keep only positions that are monomorphic in all samples
    default: false
    inputBinding:
      position: 103
      prefix: --keep-mono
  - id: keep_poly
    type:
      - 'null'
      - boolean
    doc: Keep only positions that are polymorphic in at least one sample
    default: false
    inputBinding:
      position: 103
      prefix: --keep-poly
  - id: marker_dir
    type:
      - 'null'
      - Directory
    doc: Path to MetaPhlAn or mOTUs clade marker database.
    default: None
    inputBinding:
      position: 103
      prefix: --marker-dir
  - id: marker_keep
    type:
      - 'null'
      - File
    doc: List of Markers to keep for selected clade. Requires `clade` to be 
      specified. Overrides `marker-remove`.
    default: None
    inputBinding:
      position: 103
      prefix: --marker-keep
  - id: marker_remove
    type:
      - 'null'
      - File
    doc: List of Markers to remove for selected clade. Requires `clade` to be 
      specified.
    default: None
    inputBinding:
      position: 103
      prefix: --marker-remove
  - id: marker_trunc_len
    type:
      - 'null'
      - int
    doc: Number of Nucleotides to be cut from each two sides of a marker.
    default: 50
    inputBinding:
      position: 103
      prefix: --marker-trunc-len
  - id: nprocs
    type:
      - 'null'
      - int
    doc: The number of processing units to use.
    default: 1
    inputBinding:
      position: 103
      prefix: --nprocs
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Path to output directory.
    default: out_filter/
    inputBinding:
      position: 103
      prefix: --output-dir
  - id: sample_pos_min_n_vcov
    type:
      - 'null'
      - int
    doc: Remove positions with coverage below `sample-pos-min-n-vcov` 
      nucleotides.
    default: 1
    inputBinding:
      position: 103
      prefix: --sample-pos-min-n-vcov
  - id: sample_pos_min_sd_vcov
    type:
      - 'null'
      - float
    doc: Remove positions with coverage +-`sample-pos-min-sd-vcov` from the 
      mean.
    default: 3.0
    inputBinding:
      position: 103
      prefix: --sample-pos-min-sd-vcov
  - id: sample_var_min_f_vcov
    type:
      - 'null'
      - float
    doc: Remove variants with coverage below `sample-var-min-f-vcov` percent.
    default: 0.05
    inputBinding:
      position: 103
      prefix: --sample-var-min-f-vcov
  - id: sample_var_min_n_vcov
    type:
      - 'null'
      - int
    doc: Remove variants with coverage below `sample-var-min-n-vcov` 
      nucleotides.
    default: 2
    inputBinding:
      position: 103
      prefix: --sample-var-min-n-vcov
  - id: samples_min_f_hcov
    type:
      - 'null'
      - float
    doc: Remove samples with fraction of horizontal coverage below 
      `samples-min-f-hcov`.
    default: None
    inputBinding:
      position: 103
      prefix: --samples-min-f-hcov
  - id: samples_min_m_vcov
    type:
      - 'null'
      - float
    doc: Remove samples with mean coverage below `samples-min-m-vcov`.
    default: None
    inputBinding:
      position: 103
      prefix: --samples-min-m-vcov
  - id: samples_min_n_hcov
    type:
      - 'null'
      - int
    doc: Remove samples with horizontal coverage below `samples-min-n-hcov`.
    default: 5000
    inputBinding:
      position: 103
      prefix: --samples-min-n-hcov
  - id: samples_select
    type:
      - 'null'
      - type: array
        items: File
    doc: Path to names file with subsample of input names.
    default: []
    inputBinding:
      position: 103
      prefix: --samples-select
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samestr:1.2025.111--pyhdfd78af_0
stdout: samestr_filter.out
