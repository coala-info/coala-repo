cwlVersion: v1.2
class: CommandLineTool
baseCommand: haystack_tf_activity_plane
label: haystack_bio_haystack_tf_activity_plane
doc: "HAYSTACK TF activity plane: relates transcription factor motif activity (from
  haystack_motifs output) to gene expression in a target cell type.\n\nTool homepage:
  https://github.com/pinellolab/haystack_bio"
inputs:
  - id: haystack_motifs_output_folder
    type: Directory
    doc: "A path to a folder created by the haystack_motifs utility"
    inputBinding:
      position: 1
  - id: gene_expression_samples_filename
    type: File
    doc: "A file containing the list of sample names and locations"
    inputBinding:
      position: 2
  - id: gene_expression_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "The gene expression files named in the samples file (staged in the working directory)"
  - id: target_cell_type
    type: string
    doc: "The sample name to use as a target for the analysis"
    inputBinding:
      position: 3
  - id: motif_mapping_filename
    type:
      - 'null'
      - File
    doc: "Custom motif to gene mapping file (the default is for JASPAR CORE 2016 database)"
    inputBinding:
      position: 104
      prefix: --motif_mapping_filename
  - id: output_directory
    type:
      - 'null'
      - string
    doc: "Output directory (default: current directory)"
    inputBinding:
      position: 104
      prefix: --output_directory
  - id: name
    type:
      - 'null'
      - string
    doc: "Define a custom output filename for the report"
    inputBinding:
      position: 104
      prefix: --name
  - id: plot_all
    type:
      - 'null'
      - boolean
    doc: "Disable the filter on the TF activity and correlation (default z-score TF>0 and rho>0.3)"
    inputBinding:
      position: 104
      prefix: --plot_all
  - id: rho_cutoff
    type:
      - 'null'
      - float
    doc: "The cutoff absolute correlation value (0.0 to 1) for which activity plots are generated (default: 0.3)"
    inputBinding:
      position: 104
      prefix: --rho_cutoff
  - id: tf_value_cuttoff
    type:
      - 'null'
      - float
    doc: "The cutoff z-score tf_value for which activity plots are generated (default: 0.0)"
    inputBinding:
      position: 104
      prefix: --tf_value_cuttoff
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output"
  - id: output_directory_dir
    type:
      - 'null'
      - Directory
    doc: "Output directory"
    outputBinding:
      glob: $(inputs.output_directory)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.gene_expression_files || [])
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haystack_bio:0.5.5--0
stdout: haystack_bio_haystack_tf_activity_plane.out
