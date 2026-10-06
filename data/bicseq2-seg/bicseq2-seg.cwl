cwlVersion: v1.2
class: CommandLineTool
baseCommand: NBICseq-seg.pl
label: bicseq2-seg
doc: "BIC-seq2 segmentation (NBICseq-seg.pl) for detecting copy number variations
  from normalized bin counts. The config file is tab-separated with a header line
  and the columns chromName and binFileNorm (plus a control column with --control).
  Give the bin files it names in bin_files and use their base names in the config.\n\
  \nTool homepage: http://compbio.med.harvard.edu/BIC-seq/"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.bin_files)
inputs:
  - id: config_file
    type: File
    doc: Tab-separated configuration file naming the normalized bin file of each
      chromosome
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: Output file for the CNV segments
    inputBinding:
      position: 2
  - id: bin_files
    type:
      type: array
      items: File
    doc: Normalized bin files (output of BIC-seq2 normalization) named in the config
      file
  - id: lambda
    type:
      - 'null'
      - float
    doc: The (positive) penalty used for BIC-seq
    inputBinding:
      position: 102
      prefix: --lambda
  - id: fig
    type:
      - 'null'
      - string
    doc: Plot the CNV profile in a png file
    inputBinding:
      position: 102
      prefix: --fig
  - id: title
    type:
      - 'null'
      - string
    doc: The title of the figure
    inputBinding:
      position: 102
      prefix: --title
  - id: nrm
    type:
      - 'null'
      - boolean
    doc: Do not remove likely germline CNVs (with a matched normal) or segments
      with bad mappability (without a matched normal)
    inputBinding:
      position: 102
      prefix: --nrm
  - id: bootstrap
    type:
      - 'null'
      - boolean
    doc: Perform bootstrap test to assign confidence (only for one sample case)
    inputBinding:
      position: 102
      prefix: --bootstrap
  - id: noscale
    type:
      - 'null'
      - boolean
    doc: Do not automatically adjust the lambda parameter according to the noise
      level in the data
    inputBinding:
      position: 102
      prefix: --noscale
  - id: strict
    type:
      - 'null'
      - boolean
    doc: Use a more stringent method to adjust the lambda parameter
    inputBinding:
      position: 102
      prefix: --strict
  - id: control
    type:
      - 'null'
      - boolean
    doc: The data has a control genome
    inputBinding:
      position: 102
      prefix: --control
  - id: detail
    type:
      - 'null'
      - boolean
    doc: Print the detailed segmentation result (for multiSample only)
    inputBinding:
      position: 102
      prefix: --detail
  - id: tmp_dir
    type: string
    default: bicseq2_tmp
    doc: The tmp directory (the tool default inside the image is not writable)
    inputBinding:
      position: 102
      prefix: --tmp
outputs:
  - id: segments
    type: File
    doc: CNV segments with observed/expected counts and log2 copy ratio
    outputBinding:
      glob: $(inputs.output)
  - id: figure
    type:
      - 'null'
      - File
    doc: CNV profile plot
    outputBinding:
      glob: $(inputs.fig)
  - id: log
    type: stdout
    doc: Standard output with the commands run
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bicseq2-seg:0.7.2--hec16e2b_3
stdout: bicseq2-seg.log
