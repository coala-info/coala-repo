# rust-proseg CWL Generation Report

## rust-proseg_proseg

### Tool Description
High-speed cell segmentation of transcript-resolution spatial transcriptomics data.

### Metadata
- **Docker Image**: quay.io/biocontainers/rust-proseg:2.0.6--h4349ce8_0
- **Homepage**: https://github.com/dcjones/proseg
- **Package**: https://anaconda.org/channels/bioconda/packages/rust-proseg/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rust-proseg/overview
- **Total Downloads**: 1.2K
- **Last updated**: 2025-07-29
- **GitHub**: https://github.com/dcjones/proseg
- **Stars**: N/A
### Original Help Text
```text
High-speed cell segmentation of transcript-resolution spatial transcriptomics data.

Usage: proseg [OPTIONS] <TRANSCRIPT_CSV>

Arguments:
  <TRANSCRIPT_CSV>  CSV with transcript information. How this is interpreted is determined either by using a preset (`--xenium`, `--cosmx`, `--cosmx-micron`, `--merfish`) or by manually setting column names using (`--x-column`, `--transcript-column`, etc)

Options:
      --xenium
          Preset for 10X Xenium data
      --cosmx
          Preset for NanoString CosMx data that using pixel coordinates. Output will still be in microns
      --cosmx-micron
          Preset for NanoString CosMx data that has been pre-scaled to microns
      --merscope
          Preset for Vizgen MERFISH/MERSCOPE
      --merfish
          (Deprecated) Preset for Vizgen MERFISH/MERSCOPE
      --excluded-genes <EXCLUDED_GENES>
          Regex pattern matching names of genes/features to be excluded
      --use-cell-initialization
          Initialize with cell assignments rather than nucleus assignments
      --visiumhd
          Preset for Visium HD
      --gene-column <GENE_COLUMN>
          Name of column containing the feature/gene name
      --transcript-id-column <TRANSCRIPT_ID_COLUMN>
          Name of column containing the transcript ID
  -x, --x-column <X_COLUMN>
          Name of column containing the x coordinate
  -y, --y-column <Y_COLUMN>
          Name of column containing the y coordinate
  -z, --z-column <Z_COLUMN>
          Name of column containing the z coordinate
      --compartment-column <COMPARTMENT_COLUMN>
          Name of column containing the cellular compartment
      --compartment-nuclear <COMPARTMENT_NUCLEAR>
          Value in the cellular compartment column indicated the nucleus
      --fov-column <FOV_COLUMN>
          Name of column containing the field of view
      --cell-assignment-column <CELL_ASSIGNMENT_COLUMN>
          Column indicating whether a transcript is assigned to a cell
      --cell-assignment-unassigned <CELL_ASSIGNMENT_UNASSIGNED>
          Value in the cell assignment column indicating an unassigned transcript
      --cell-id-column <CELL_ID_COLUMN>
          Name of column containing the cell ID
      --cell-id-unassigned <CELL_ID_UNASSIGNED>
          Value in the cell ID column indicating an unassigned transcript
      --qv-column <QV_COLUMN>
          Name of column containing the quality value
      --ignore-z-coord
          Ignore the z coordinate if any, treating the data as 2D
      --min-qv <MIN_QV>
          Filter out transcripts with quality values below this threshold
      --cells-per-chunk <CELLS_PER_CHUNK>
          Target number of cells per chunk in the parallelization scheme Smaller number enabled more parallelization, but too small a number risks inconsistent updates [default: 100]
      --ncomponents <NCOMPONENTS>
          Number of components in the mixture model of cellular gene expression [default: 10]
      --nhidden <NHIDDEN>
          Dimenionality of the latent space [default: 100]
      --nbglayers <NBGLAYERS>
          Number of z-axis layers used to model background expression [default: 4]
      --detect-layers
          Detect the number of z-layers from the data when it's discrete
      --voxel-layers <VOXEL_LAYERS>
          Number of layers of voxels in the z-axis used for segmentation [default: 1]
      --schedule <SCHEDULE>...
          Sampler schedule, indicating the number of iterations between doubling resolution [default: 150 150 300]
      --no-z-layer-doubling
          Whether to double the z-layers when doubling resolution
      --recorded-samples <RECORDED_SAMPLES>
          Number of samples at the end of the schedule used to compute expectations and uncertainty [default: 100]
  -t, --nthreads <NTHREADS>
          Number of CPU threads (by default, all cores are used)
  -m, --morphology-steps-per-iter <MORPHOLOGY_STEPS_PER_ITER>
          Number of sub-iterations sampling cell morphology per overall iteration [default: 1000]
      --count-pr-cutoff <COUNT_PR_CUTOFF>
          [default: 0.1]
      --foreground-pr-cutoff <FOREGROUND_PR_CUTOFF>
          [default: 0.9]
      --perimeter-bound <PERIMETER_BOUND>
          [default: 1.3]
      --nuclear-reassignment-prob <NUCLEAR_REASSIGNMENT_PROB>
          [default: 0.2]
      --prior-seg-reassignment-prob <PRIOR_SEG_REASSIGNMENT_PROB>
          [default: 0.5]
      --coordinate-scale <COORDINATE_SCALE>
          Scale transcript coordinates by this factor to arrive at microns
      --initial-voxel-size <INITIAL_VOXEL_SIZE>
          Initial size x/y size of voxels
      --max-transcript-nucleus-distance <MAX_TRANSCRIPT_NUCLEUS_DISTANCE>
          Exclude transcripts that are more than this distance from any nucleus [default: 60]
      --no-diffusion
          Disable transcript diffusion model
      --diffusion-probability <DIFFUSION_PROBABILITY>
          Probability of transcript diffusion [default: 0.2]
      --diffusion-proposal-sigma <DIFFUSION_PROPOSAL_SIGMA>
          Stddev of the proposal distribution for transcript repositioning [default: 4]
      --diffusion-sigma-near <DIFFUSION_SIGMA_NEAR>
          Stddev parameter for repositioning of non-diffused transcripts [default: 0.5]
      --diffusion-sigma-far <DIFFUSION_SIGMA_FAR>
          Stddev parameter for repositioning of diffused transcripts [default: 4]
      --variable-burnin-dispersion
          Allow dispersion parameter to vary during burn-in
      --burnin-dispersion <BURNIN_DISPERSION>
          Fixed dispersion parameter value during burn-in [default: 1]
      --dispersion <DISPERSION>
          Fixed dispersion parameter throughout sampling
      --initial-perturbation-sd <INITIAL_PERTURBATION_SD>
          Perturb initial transcript positions with this standard deviation
      --check-consistency
          Run time consuming checks to make sure data structures are in a consistent state
      --output-path <OUTPUT_PATH>
          Prepend a path name to every  output file name
      --output-maxpost-counts <OUTPUT_MAXPOST_COUNTS>
          Output a point estimate of transcript counts per cell
      --output-maxpost-counts-fmt <OUTPUT_MAXPOST_COUNTS_FMT>
          [default: infer] [possible values: infer, csv, csv-gz, parquet]
      --output-expected-counts <OUTPUT_EXPECTED_COUNTS>
          Output a matrix of expected transcript counts per cell [default: expected-counts.csv.gz]
      --output-rates <OUTPUT_RATES>
          Output a matrix of estimated Poisson expression rates per cell
      --output-rates-fmt <OUTPUT_RATES_FMT>
          [default: infer] [possible values: infer, csv, csv-gz, parquet]
      --output-component-params-fmt <OUTPUT_COMPONENT_PARAMS_FMT>
          [default: infer] [possible values: infer, csv, csv-gz, parquet]
      --output-expected-counts-fmt <OUTPUT_EXPECTED_COUNTS_FMT>
          [default: infer] [possible values: infer, csv, csv-gz, parquet]
      --output-cell-hulls <OUTPUT_CELL_HULLS>
          Output cell convex hulls
      --output-cell-metadata <OUTPUT_CELL_METADATA>
          Output cell metadata [default: cell-metadata.csv.gz]
      --output-cell-metadata-fmt <OUTPUT_CELL_METADATA_FMT>
          [default: infer] [possible values: infer, csv, csv-gz, parquet]
      --output-transcript-metadata <OUTPUT_TRANSCRIPT_METADATA>
          Output transcript metadata [default: transcript-metadata.csv.gz]
      --output-transcript-metadata-fmt <OUTPUT_TRANSCRIPT_METADATA_FMT>
          [default: infer] [possible values: infer, csv, csv-gz, parquet]
      --output-gene-metadata <OUTPUT_GENE_METADATA>
          Output gene metadata
      --output-gene-metadata-fmt <OUTPUT_GENE_METADATA_FMT>
          [default: infer] [possible values: infer, csv, csv-gz, parquet]
      --output-metagene-rates <OUTPUT_METAGENE_RATES>
          Output cell metagene rates
      --output-metagene-rates-fmt <OUTPUT_METAGENE_RATES_FMT>
          [default: infer] [possible values: infer, csv, csv-gz, parquet]
      --output-metagene-loadings <OUTPUT_METAGENE_LOADINGS>
          Output metagene loadings
      --output-metagene-loadings-fmt <OUTPUT_METAGENE_LOADINGS_FMT>
          [default: infer] [possible values: infer, csv, csv-gz, parquet]
      --output-cell-voxels <OUTPUT_CELL_VOXELS>
          Output a table of each voxel in each cell
      --output-cell-voxels-fmt <OUTPUT_CELL_VOXELS_FMT>
          [default: infer] [possible values: infer, csv, csv-gz, parquet]
      --output-cell-polygons <OUTPUT_CELL_POLYGONS>
          Output consensus non-overlapping 2D polygons, formed by taking the dominant cell at each x/y location [default: cell-polygons.geojson.gz]
      --output-union-cell-polygons <OUTPUT_UNION_CELL_POLYGONS>
          Output cell polygons flattened (unioned) to 2D [default: union-cell-polygons.geojson.gz]
      --output-cell-polygon-layers <OUTPUT_CELL_POLYGON_LAYERS>
          Output separate cell polygons for each layer of voxels along the z-axis [default: cell-polygons-layers.geojson.gz]
      --monitor-cell-polygons <MONITOR_CELL_POLYGONS>
          Output cell polygons repeatedly during sampling
      --monitor-cell-polygons-freq <MONITOR_CELL_POLYGONS_FREQ>
          How frequently to output cell polygons during monitoring [default: 10]
      --enforce-connectivity
          Use connectivity checks to prevent cells from having any disconnected voxels
      --nunfactored <NUNFACTORED>
          [default: 300]
      --no-factorization
          Disable factorization model and use genes directly
      --use-scaled-cells
          Disable cell scale factors
      --hyperparam-e-phi <HYPERPARAM_E_PHI>
          [default: 1]
      --hyperparam-f-phi <HYPERPARAM_F_PHI>
          [default: 1]
      --hyperparam-neg-mu-phi <HYPERPARAM_NEG_MU_PHI>
          [default: 1]
      --hyperparam-tau-phi <HYPERPARAM_TAU_PHI>
          [default: 0.1]
  -h, --help
          Print help
  -V, --version
          Print version
```


## rust-proseg_proseg-to-baysor

### Tool Description
Convert proseg output to Baysor-compatible output.

### Metadata
- **Docker Image**: quay.io/biocontainers/rust-proseg:2.0.6--h4349ce8_0
- **Homepage**: https://github.com/dcjones/proseg
- **Package**: https://anaconda.org/channels/bioconda/packages/rust-proseg/overview
- **Validation**: PASS

### Original Help Text
```text
Convert proseg output to Baysor-compatible output.

Usage: proseg-to-baysor [OPTIONS] <TRANSCRIPT_METADATA> <CELL_POLYGONS>

Arguments:
  <TRANSCRIPT_METADATA>  
  <CELL_POLYGONS>        

Options:
      --output-transcript-metadata <OUTPUT_TRANSCRIPT_METADATA>
          [default: proseg-to-baysor-transcript-metadata.csv]
      --output-cell-polygons <OUTPUT_CELL_POLYGONS>
          [default: proseg-to-baysor-cell-polygons.geojson]
  -h, --help
          Print help
```

