cwlVersion: v1.2
class: CommandLineTool
baseCommand: proseg
label: rust-proseg_proseg
doc: "High-speed cell segmentation of transcript-resolution spatial transcriptomics
  data.\n\nTool homepage: https://github.com/dcjones/proseg"
inputs:
  - id: transcript_csv
    type: File
    doc: CSV with transcript information. How this is interpreted is determined 
      either by using a preset (`--xenium`, `--cosmx`, `--cosmx-micron`, 
      `--merfish`) or by manually setting column names using (`--x-column`, 
      `--transcript-column`, etc)
    inputBinding:
      position: 1
  - id: burnin_dispersion
    type:
      - 'null'
      - float
    doc: Fixed dispersion parameter value during burn-in
    default: 1
    inputBinding:
      position: 102
      prefix: --burnin-dispersion
  - id: cell_assignment_column
    type:
      - 'null'
      - string
    doc: Column indicating whether a transcript is assigned to a cell
    inputBinding:
      position: 102
      prefix: --cell-assignment-column
  - id: cell_assignment_unassigned
    type:
      - 'null'
      - string
    doc: Value in the cell assignment column indicating an unassigned transcript
    inputBinding:
      position: 102
      prefix: --cell-assignment-unassigned
  - id: cell_id_column
    type:
      - 'null'
      - string
    doc: Name of column containing the cell ID
    inputBinding:
      position: 102
      prefix: --cell-id-column
  - id: cell_id_unassigned
    type:
      - 'null'
      - string
    doc: Value in the cell ID column indicating an unassigned transcript
    inputBinding:
      position: 102
      prefix: --cell-id-unassigned
  - id: cells_per_chunk
    type:
      - 'null'
      - int
    doc: Target number of cells per chunk in the parallelization scheme Smaller 
      number enabled more parallelization, but too small a number risks 
      inconsistent updates
    default: 100
    inputBinding:
      position: 102
      prefix: --cells-per-chunk
  - id: check_consistency
    type:
      - 'null'
      - boolean
    doc: Run time consuming checks to make sure data structures are in a 
      consistent state
    inputBinding:
      position: 102
      prefix: --check-consistency
  - id: compartment_column
    type:
      - 'null'
      - string
    doc: Name of column containing the cellular compartment
    inputBinding:
      position: 102
      prefix: --compartment-column
  - id: compartment_nuclear
    type:
      - 'null'
      - string
    doc: Value in the cellular compartment column indicated the nucleus
    inputBinding:
      position: 102
      prefix: --compartment-nuclear
  - id: coordinate_scale
    type:
      - 'null'
      - float
    doc: Scale transcript coordinates by this factor to arrive at microns
    inputBinding:
      position: 102
      prefix: --coordinate-scale
  - id: cosmx
    type:
      - 'null'
      - boolean
    doc: Preset for NanoString CosMx data that using pixel coordinates. Output 
      will still be in microns
    inputBinding:
      position: 102
      prefix: --cosmx
  - id: cosmx_micron
    type:
      - 'null'
      - boolean
    doc: Preset for NanoString CosMx data that has been pre-scaled to microns
    inputBinding:
      position: 102
      prefix: --cosmx-micron
  - id: count_pr_cutoff
    type:
      - 'null'
      - float
    default: 0.1
    inputBinding:
      position: 102
      prefix: --count-pr-cutoff
  - id: detect_layers
    type:
      - 'null'
      - boolean
    doc: Detect the number of z-layers from the data when it's discrete
    inputBinding:
      position: 102
      prefix: --detect-layers
  - id: diffusion_probability
    type:
      - 'null'
      - float
    doc: Probability of transcript diffusion
    default: 0.2
    inputBinding:
      position: 102
      prefix: --diffusion-probability
  - id: diffusion_proposal_sigma
    type:
      - 'null'
      - float
    doc: Stddev of the proposal distribution for transcript repositioning
    default: 4
    inputBinding:
      position: 102
      prefix: --diffusion-proposal-sigma
  - id: diffusion_sigma_far
    type:
      - 'null'
      - float
    doc: Stddev parameter for repositioning of diffused transcripts
    default: 4
    inputBinding:
      position: 102
      prefix: --diffusion-sigma-far
  - id: diffusion_sigma_near
    type:
      - 'null'
      - float
    doc: Stddev parameter for repositioning of non-diffused transcripts
    default: 0.5
    inputBinding:
      position: 102
      prefix: --diffusion-sigma-near
  - id: dispersion
    type:
      - 'null'
      - float
    doc: Fixed dispersion parameter throughout sampling
    inputBinding:
      position: 102
      prefix: --dispersion
  - id: enforce_connectivity
    type:
      - 'null'
      - boolean
    doc: Use connectivity checks to prevent cells from having any disconnected 
      voxels
    inputBinding:
      position: 102
      prefix: --enforce-connectivity
  - id: excluded_genes
    type:
      - 'null'
      - string
    doc: Regex pattern matching names of genes/features to be excluded
    inputBinding:
      position: 102
      prefix: --excluded-genes
  - id: foreground_pr_cutoff
    type:
      - 'null'
      - float
    default: 0.9
    inputBinding:
      position: 102
      prefix: --foreground-pr-cutoff
  - id: fov_column
    type:
      - 'null'
      - string
    doc: Name of column containing the field of view
    inputBinding:
      position: 102
      prefix: --fov-column
  - id: gene_column
    type:
      - 'null'
      - string
    doc: Name of column containing the feature/gene name
    inputBinding:
      position: 102
      prefix: --gene-column
  - id: hyperparam_e_phi
    type:
      - 'null'
      - float
    default: 1
    inputBinding:
      position: 102
      prefix: --hyperparam-e-phi
  - id: hyperparam_f_phi
    type:
      - 'null'
      - float
    default: 1
    inputBinding:
      position: 102
      prefix: --hyperparam-f-phi
  - id: hyperparam_neg_mu_phi
    type:
      - 'null'
      - float
    default: 1
    inputBinding:
      position: 102
      prefix: --hyperparam-neg-mu-phi
  - id: hyperparam_tau_phi
    type:
      - 'null'
      - float
    default: 0.1
    inputBinding:
      position: 102
      prefix: --hyperparam-tau-phi
  - id: ignore_z_coord
    type:
      - 'null'
      - boolean
    doc: Ignore the z coordinate if any, treating the data as 2D
    inputBinding:
      position: 102
      prefix: --ignore-z-coord
  - id: initial_perturbation_sd
    type:
      - 'null'
      - float
    doc: Perturb initial transcript positions with this standard deviation
    inputBinding:
      position: 102
      prefix: --initial-perturbation-sd
  - id: initial_voxel_size
    type:
      - 'null'
      - float
    doc: Initial size x/y size of voxels
    inputBinding:
      position: 102
      prefix: --initial-voxel-size
  - id: max_transcript_nucleus_distance
    type:
      - 'null'
      - int
    doc: Exclude transcripts that are more than this distance from any nucleus
    default: 60
    inputBinding:
      position: 102
      prefix: --max-transcript-nucleus-distance
  - id: merfish
    type:
      - 'null'
      - boolean
    doc: (Deprecated) Preset for Vizgen MERFISH/MERSCOPE
    inputBinding:
      position: 102
      prefix: --merfish
  - id: merscope
    type:
      - 'null'
      - boolean
    doc: Preset for Vizgen MERFISH/MERSCOPE
    inputBinding:
      position: 102
      prefix: --merscope
  - id: min_qv
    type:
      - 'null'
      - float
    doc: Filter out transcripts with quality values below this threshold
    inputBinding:
      position: 102
      prefix: --min-qv
  - id: monitor_cell_polygons_freq
    type:
      - 'null'
      - int
    doc: How frequently to output cell polygons during monitoring
    default: 10
    inputBinding:
      position: 102
      prefix: --monitor-cell-polygons-freq
  - id: morphology_steps_per_iter
    type:
      - 'null'
      - int
    doc: Number of sub-iterations sampling cell morphology per overall iteration
    default: 1000
    inputBinding:
      position: 102
      prefix: --morphology-steps-per-iter
  - id: nbglayers
    type:
      - 'null'
      - int
    doc: Number of z-axis layers used to model background expression
    default: 4
    inputBinding:
      position: 102
      prefix: --nbglayers
  - id: ncomponents
    type:
      - 'null'
      - int
    doc: Number of components in the mixture model of cellular gene expression
    default: 10
    inputBinding:
      position: 102
      prefix: --ncomponents
  - id: nhidden
    type:
      - 'null'
      - int
    doc: Dimenionality of the latent space
    default: 100
    inputBinding:
      position: 102
      prefix: --nhidden
  - id: no_diffusion
    type:
      - 'null'
      - boolean
    doc: Disable transcript diffusion model
    inputBinding:
      position: 102
      prefix: --no-diffusion
  - id: no_factorization
    type:
      - 'null'
      - boolean
    doc: Disable factorization model and use genes directly
    inputBinding:
      position: 102
      prefix: --no-factorization
  - id: no_z_layer_doubling
    type:
      - 'null'
      - boolean
    doc: Whether to double the z-layers when doubling resolution
    inputBinding:
      position: 102
      prefix: --no-z-layer-doubling
  - id: nthreads
    type:
      - 'null'
      - int
    doc: Number of CPU threads (by default, all cores are used)
    inputBinding:
      position: 102
      prefix: --nthreads
  - id: nuclear_reassignment_prob
    type:
      - 'null'
      - float
    default: 0.2
    inputBinding:
      position: 102
      prefix: --nuclear-reassignment-prob
  - id: nunfactored
    type:
      - 'null'
      - int
    default: 300
    inputBinding:
      position: 102
      prefix: --nunfactored
  - id: output_cell_metadata_fmt
    type:
      - 'null'
      - string
    default: infer
    inputBinding:
      position: 102
      prefix: --output-cell-metadata-fmt
  - id: output_cell_voxels_fmt
    type:
      - 'null'
      - string
    default: infer
    inputBinding:
      position: 102
      prefix: --output-cell-voxels-fmt
  - id: output_component_params_fmt
    type:
      - 'null'
      - string
    default: infer
    inputBinding:
      position: 102
      prefix: --output-component-params-fmt
  - id: output_expected_counts_fmt
    type:
      - 'null'
      - string
    default: infer
    inputBinding:
      position: 102
      prefix: --output-expected-counts-fmt
  - id: output_gene_metadata_fmt
    type:
      - 'null'
      - string
    default: infer
    inputBinding:
      position: 102
      prefix: --output-gene-metadata-fmt
  - id: output_maxpost_counts_fmt
    type:
      - 'null'
      - string
    default: infer
    inputBinding:
      position: 102
      prefix: --output-maxpost-counts-fmt
  - id: output_metagene_loadings_fmt
    type:
      - 'null'
      - string
    default: infer
    inputBinding:
      position: 102
      prefix: --output-metagene-loadings-fmt
  - id: output_metagene_rates_fmt
    type:
      - 'null'
      - string
    default: infer
    inputBinding:
      position: 102
      prefix: --output-metagene-rates-fmt
  - id: output_path
    type:
      - 'null'
      - string
    doc: Prepend a path name to every  output file name
    inputBinding:
      position: 102
      prefix: --output-path
  - id: output_rates_fmt
    type:
      - 'null'
      - string
    default: infer
    inputBinding:
      position: 102
      prefix: --output-rates-fmt
  - id: output_transcript_metadata_fmt
    type:
      - 'null'
      - string
    default: infer
    inputBinding:
      position: 102
      prefix: --output-transcript-metadata-fmt
  - id: perimeter_bound
    type:
      - 'null'
      - float
    default: 1.3
    inputBinding:
      position: 102
      prefix: --perimeter-bound
  - id: prior_seg_reassignment_prob
    type:
      - 'null'
      - float
    default: 0.5
    inputBinding:
      position: 102
      prefix: --prior-seg-reassignment-prob
  - id: qv_column
    type:
      - 'null'
      - string
    doc: Name of column containing the quality value
    inputBinding:
      position: 102
      prefix: --qv-column
  - id: recorded_samples
    type:
      - 'null'
      - int
    doc: Number of samples at the end of the schedule used to compute 
      expectations and uncertainty
    default: 100
    inputBinding:
      position: 102
      prefix: --recorded-samples
  - id: schedule
    type:
      - 'null'
      - type: array
        items: int
    doc: Sampler schedule, indicating the number of iterations between doubling 
      resolution
    default:
      - 150
      - 150
      - 300
    inputBinding:
      position: 102
      prefix: --schedule
  - id: transcript_id_column
    type:
      - 'null'
      - string
    doc: Name of column containing the transcript ID
    inputBinding:
      position: 102
      prefix: --transcript-id-column
  - id: use_cell_initialization
    type:
      - 'null'
      - boolean
    doc: Initialize with cell assignments rather than nucleus assignments
    inputBinding:
      position: 102
      prefix: --use-cell-initialization
  - id: use_scaled_cells
    type:
      - 'null'
      - boolean
    doc: Disable cell scale factors
    inputBinding:
      position: 102
      prefix: --use-scaled-cells
  - id: variable_burnin_dispersion
    type:
      - 'null'
      - boolean
    doc: Allow dispersion parameter to vary during burn-in
    inputBinding:
      position: 102
      prefix: --variable-burnin-dispersion
  - id: visiumhd
    type:
      - 'null'
      - boolean
    doc: Preset for Visium HD
    inputBinding:
      position: 102
      prefix: --visiumhd
  - id: voxel_layers
    type:
      - 'null'
      - int
    doc: Number of layers of voxels in the z-axis used for segmentation
    default: 1
    inputBinding:
      position: 102
      prefix: --voxel-layers
  - id: x_column
    type:
      - 'null'
      - string
    doc: Name of column containing the x coordinate
    inputBinding:
      position: 102
      prefix: --x-column
  - id: xenium
    type:
      - 'null'
      - boolean
    doc: Preset for 10X Xenium data
    inputBinding:
      position: 102
      prefix: --xenium
  - id: y_column
    type:
      - 'null'
      - string
    doc: Name of column containing the y coordinate
    inputBinding:
      position: 102
      prefix: --y-column
  - id: z_column
    type:
      - 'null'
      - string
    doc: Name of column containing the z coordinate
    inputBinding:
      position: 102
      prefix: --z-column
outputs:
  - id: output_maxpost_counts
    type:
      - 'null'
      - File
    doc: Output a point estimate of transcript counts per cell
    outputBinding:
      glob: $(inputs.output_maxpost_counts)
  - id: output_expected_counts
    type:
      - 'null'
      - File
    doc: Output a matrix of expected transcript counts per cell
    outputBinding:
      glob: $(inputs.output_expected_counts)
  - id: output_rates
    type:
      - 'null'
      - File
    doc: Output a matrix of estimated Poisson expression rates per cell
    outputBinding:
      glob: $(inputs.output_rates)
  - id: output_cell_hulls
    type:
      - 'null'
      - File
    doc: Output cell convex hulls
    outputBinding:
      glob: $(inputs.output_cell_hulls)
  - id: output_cell_metadata
    type:
      - 'null'
      - File
    doc: Output cell metadata
    outputBinding:
      glob: $(inputs.output_cell_metadata)
  - id: output_transcript_metadata
    type:
      - 'null'
      - File
    doc: Output transcript metadata
    outputBinding:
      glob: $(inputs.output_transcript_metadata)
  - id: output_gene_metadata
    type:
      - 'null'
      - File
    doc: Output gene metadata
    outputBinding:
      glob: $(inputs.output_gene_metadata)
  - id: output_metagene_rates
    type:
      - 'null'
      - File
    doc: Output cell metagene rates
    outputBinding:
      glob: $(inputs.output_metagene_rates)
  - id: output_metagene_loadings
    type:
      - 'null'
      - File
    doc: Output metagene loadings
    outputBinding:
      glob: $(inputs.output_metagene_loadings)
  - id: output_cell_voxels
    type:
      - 'null'
      - File
    doc: Output a table of each voxel in each cell
    outputBinding:
      glob: $(inputs.output_cell_voxels)
  - id: output_cell_polygons
    type:
      - 'null'
      - File
    doc: Output consensus non-overlapping 2D polygons, formed by taking the 
      dominant cell at each x/y location
    outputBinding:
      glob: $(inputs.output_cell_polygons)
  - id: output_union_cell_polygons
    type:
      - 'null'
      - File
    doc: Output cell polygons flattened (unioned) to 2D
    outputBinding:
      glob: $(inputs.output_union_cell_polygons)
  - id: output_cell_polygon_layers
    type:
      - 'null'
      - File
    doc: Output separate cell polygons for each layer of voxels along the z-axis
    outputBinding:
      glob: $(inputs.output_cell_polygon_layers)
  - id: monitor_cell_polygons
    type:
      - 'null'
      - File
    doc: Output cell polygons repeatedly during sampling
    outputBinding:
      glob: $(inputs.monitor_cell_polygons)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust-proseg:2.0.6--h4349ce8_0
