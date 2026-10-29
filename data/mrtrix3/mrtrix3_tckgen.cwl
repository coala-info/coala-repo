cwlVersion: v1.2
class: CommandLineTool
baseCommand: tckgen
label: mrtrix3_tckgen
doc: "Perform streamlines tractography\n\nTool homepage: https://www.mrtrix.org"
inputs:
  - id: source
    type: File
    doc: "The image containing the source data. The type of image data required depends on the algorithm used (see Description section)."
    inputBinding:
      position: 1
  - id: tracks
    type: string
    doc: "the output file containing the tracks generated."
    inputBinding:
      position: 2
  - id: algorithm
    type: ['null', string]
    doc: "specify the tractography algorithm to use. Valid choices are: FACT, iFOD1, iFOD2, Nulldist1, Nulldist2, SD_Stream, Seedtest, Tensor_Det, Tensor_Prob (default: iFOD2)."
    inputBinding:
      position: 10
      prefix: -algorithm
  - id: select
    type: ['null', int]
    doc: "set the desired number of streamlines to be selected by tckgen, after all selection criteria have been applied (i.e. inclusion/exclusion ROIs, min/max length, etc). tckgen will keep seeding streamlines until this number of streamlines have been selected, or the maximum allowed number of seeds has been exceeded (see -seeds option). By default, 5000 streamlines are to be selected. Set to zero to disable, which will result in streamlines being seeded until the number specified by -seeds has been reached."
    inputBinding:
      position: 10
      prefix: -select
  - id: step
    type: ['null', float]
    doc: "set the step size of the algorithm in mm (defaults: for first-order algorithms, 0.1 x voxelsize; if using RK4, 0.25 x voxelsize; for iFOD2: 0.5 x voxelsize)."
    inputBinding:
      position: 10
      prefix: -step
  - id: angle
    type: ['null', float]
    doc: "set the maximum angle in degrees between successive steps (defaults: 60 for deterministic algorithms; 15 for iFOD1 / nulldist1; 45 for iFOD2 / nulldist2)"
    inputBinding:
      position: 10
      prefix: -angle
  - id: minlength
    type: ['null', float]
    doc: "set the minimum length of any track in mm (defaults: without ACT, 5 x voxelsize; with ACT, 2 x voxelsize)."
    inputBinding:
      position: 10
      prefix: -minlength
  - id: maxlength
    type: ['null', float]
    doc: "set the maximum length of any track in mm (default: 100 x voxelsize)."
    inputBinding:
      position: 10
      prefix: -maxlength
  - id: cutoff
    type: ['null', float]
    doc: "set the FOD amplitude / fixel size / tensor FA cutoff for terminating tracks (defaults: 0.1 for FOD-based algorithms; 0.1 for fixel-based algorithms; 0.1 for tensor-based algorithms; threshold multiplied by 0.5 when using ACT)."
    inputBinding:
      position: 10
      prefix: -cutoff
  - id: trials
    type: ['null', int]
    doc: "set the maximum number of sampling trials at each point (only used for iFOD1 / iFOD2) (default: 1000)."
    inputBinding:
      position: 10
      prefix: -trials
  - id: noprecomputed
    type: ['null', boolean]
    doc: "do NOT pre-compute legendre polynomial values. Warning: this will slow down the algorithm by a factor of approximately 4."
    inputBinding:
      position: 10
      prefix: -noprecomputed
  - id: rk4
    type: ['null', boolean]
    doc: "use 4th-order Runge-Kutta integration (slower, but eliminates curvature overshoot in 1st-order deterministic methods)"
    inputBinding:
      position: 10
      prefix: -rk4
  - id: stop
    type: ['null', boolean]
    doc: "stop propagating a streamline once it has traversed all include regions"
    inputBinding:
      position: 10
      prefix: -stop
  - id: downsample
    type: ['null', int]
    doc: "downsample the generated streamlines to reduce output file size (default is (samples-1) for iFOD2, no downsampling for all other algorithms)"
    inputBinding:
      position: 10
      prefix: -downsample
  - id: seed_image
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: -seed_image
    doc: "seed streamlines entirely at random within a mask image"
    inputBinding:
      position: 10
  - id: seed_sphere
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -seed_sphere
    doc: "spherical seed as four comma-separated values (XYZ position and radius)"
    inputBinding:
      position: 10
  - id: seed_random_per_voxel
    type:
      - 'null'
      - type: array
        items: seed_random_per_voxel_record
        inputBinding:
          prefix: -seed_random_per_voxel
    doc: "seed a fixed number of streamlines per voxel in a mask image; random placement of seeds in each voxel"
    inputBinding:
      position: 10
  - id: seed_grid_per_voxel
    type:
      - 'null'
      - type: array
        items: seed_grid_per_voxel_record
        inputBinding:
          prefix: -seed_grid_per_voxel
    doc: "seed a fixed number of streamlines per voxel in a mask image; place seeds on a 3D mesh grid (grid_size argument is per axis; so a grid_size of 3 results in 27 seeds per voxel)"
    inputBinding:
      position: 10
  - id: seed_rejection
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: -seed_rejection
    doc: "seed from an image using rejection sampling (higher values = more probable to seed from)"
    inputBinding:
      position: 10
  - id: seed_gmwmi
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: -seed_gmwmi
    doc: "seed from the grey matter - white matter interface (only valid if using ACT framework). Input image should be a 3D seeding volume; seeds drawn within this image will be optimised to the interface using the 5TT image provided using the -act option."
    inputBinding:
      position: 10
  - id: seed_dynamic
    type: ['null', File]
    doc: "determine seed points dynamically using the SIFT model (must not provide any other seeding mechanism). Note that while this seeding mechanism improves the distribution of reconstructed streamlines density, it should NOT be used as a substitute for the SIFT method itself."
    inputBinding:
      position: 10
      prefix: -seed_dynamic
  - id: seeds
    type: ['null', int]
    doc: "set the number of seeds that tckgen will attempt to track from. If this option is NOT provided, the default number of seeds is set to 1000\u00d7 the number of selected streamlines. If -select is NOT also specified, tckgen will continue tracking until this number of seeds has been attempted. However, if -select is also specified, tckgen will stop when the number of seeds attempted reaches the number specified here, OR when the number of streamlines selected reaches the number requested with the -select option. This can be used to prevent the program from running indefinitely when no or very few streamlines can be found that match the selection criteria. Setting this to zero will cause tckgen to keep attempting seeds until the number specified by -select has been reached."
    inputBinding:
      position: 10
      prefix: -seeds
  - id: max_attempts_per_seed
    type: ['null', int]
    doc: "set the maximum number of times that the tracking algorithm should attempt to find an appropriate tracking direction from a given seed point. This should be set high enough to ensure that an actual plausible seed point is not discarded prematurely as being unable to initiate tracking from. Higher settings may affect performance if many seeds are genuinely impossible to track from, as many attempts will still be made in vain for such seeds. (default: 1000)"
    inputBinding:
      position: 10
      prefix: -max_attempts_per_seed
  - id: seed_cutoff
    type: ['null', float]
    doc: "set the minimum FA or FOD amplitude for seeding tracks (default is the same as the normal -cutoff)."
    inputBinding:
      position: 10
      prefix: -seed_cutoff
  - id: seed_unidirectional
    type: ['null', boolean]
    doc: "track from the seed point in one direction only (default is to track in both directions)."
    inputBinding:
      position: 10
      prefix: -seed_unidirectional
  - id: seed_direction
    type: ['null', string]
    doc: "specify a seeding direction for the tracking (this should be supplied as a vector of 3 comma-separated values."
    inputBinding:
      position: 10
      prefix: -seed_direction
  - id: output_seeds
    type: ['null', string]
    doc: "output the seed location of all successful streamlines to a file"
    inputBinding:
      position: 10
      prefix: -output_seeds
  - id: include
    type:
      - 'null'
      - type: array
        items: [File, string]
        inputBinding:
          prefix: -include
    doc: "specify an inclusion region of interest, as either a binary mask image, or as a sphere using 4 comma-separared values (x,y,z,radius). Streamlines must traverse ALL inclusion regions to be accepted."
    inputBinding:
      position: 10
  - id: include_ordered
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: -include_ordered
    doc: "specify an inclusion region of interest, as either a binary mask image, or as a sphere using 4 comma-separared values (x,y,z,radius). Streamlines must traverse ALL inclusion_ordered regions in the order they are specified in order to be accepted."
    inputBinding:
      position: 10
  - id: exclude
    type:
      - 'null'
      - type: array
        items: [File, string]
        inputBinding:
          prefix: -exclude
    doc: "specify an exclusion region of interest, as either a binary mask image, or as a sphere using 4 comma-separared values (x,y,z,radius). Streamlines that enter ANY exclude region will be discarded."
    inputBinding:
      position: 10
  - id: mask
    type:
      - 'null'
      - type: array
        items: [File, string]
        inputBinding:
          prefix: -mask
    doc: "specify a masking region of interest, as either a binary mask image, or as a sphere using 4 comma-separared values (x,y,z,radius). If defined, streamlines exiting the mask will be truncated."
    inputBinding:
      position: 10
  - id: act
    type: ['null', File]
    doc: "use the Anatomically-Constrained Tractography framework during tracking; provided image must be in the 5TT (five-tissue-type) format"
    inputBinding:
      position: 10
      prefix: -act
  - id: backtrack
    type: ['null', boolean]
    doc: "allow tracks to be truncated and re-tracked if a poor structural termination is encountered"
    inputBinding:
      position: 10
      prefix: -backtrack
  - id: crop_at_gmwmi
    type: ['null', boolean]
    doc: "crop streamline endpoints more precisely as they cross the GM-WM interface"
    inputBinding:
      position: 10
      prefix: -crop_at_gmwmi
  - id: power
    type: ['null', float]
    doc: "raise the FOD to the power specified (defaults are: 1.0 for iFOD1; 1.0/nsamples for iFOD2)."
    inputBinding:
      position: 10
      prefix: -power
  - id: samples
    type: ['null', int]
    doc: "set the number of FOD samples to take per step (Default: 4)."
    inputBinding:
      position: 10
      prefix: -samples
  - id: grad
    type: ['null', File]
    doc: "Provide the diffusion-weighted gradient scheme used in the acquisition in a text file. This should be supplied as a 4xN text file with each line is in the format [ X Y Z b ], where [ X Y Z ] describe the direction of the applied gradient, and b gives the b-value in units of s/mm^2. If a diffusion gradient scheme is present in the input image header, the data provided with this option will be instead used."
    inputBinding:
      position: 10
      prefix: -grad
  - id: fslgrad
    type: ['null', fslgrad_record]
    doc: "Provide the diffusion-weighted gradient scheme used in the acquisition in FSL bvecs/bvals format files. If a diffusion gradient scheme is present in the input image header, the data provided with this option will be instead used."
    inputBinding:
      position: 10
      prefix: -fslgrad
  - id: info
    type: ['null', boolean]
    doc: "display information messages."
    inputBinding:
      position: 11
      prefix: -info
  - id: quiet
    type: ['null', boolean]
    doc: "do not display information messages or progress status; alternatively, this can be achieved by setting the MRTRIX_QUIET environment variable to a non-empty string."
    inputBinding:
      position: 11
      prefix: -quiet
  - id: debug
    type: ['null', boolean]
    doc: "display debugging messages."
    inputBinding:
      position: 11
      prefix: -debug
  - id: force
    type: ['null', boolean]
    doc: "force overwrite of output files (caution: using the same file as input and output might cause unexpected behaviour)."
    inputBinding:
      position: 11
      prefix: -force
  - id: nthreads
    type: ['null', int]
    doc: "use this number of threads in multi-threaded applications (set to 0 to disable multi-threading)."
    inputBinding:
      position: 11
      prefix: -nthreads
  - id: config
    type: ['null', {type: array, items: string}]
    doc: "temporarily set the value of an MRtrix config file entry. Provide the key and the value as two items."
    inputBinding:
      position: 11
      prefix: -config
outputs:
  - id: tracks_file
    type: File
    doc: Output file given by tracks.
    outputBinding:
      glob: $(inputs.tracks)
  - id: output_seeds_file
    type: ['null', File]
    doc: Output file given by -output_seeds.
    outputBinding:
      glob: $(inputs.output_seeds)
requirements:
  - class: SchemaDefRequirement
    types:
      - name: seed_random_per_voxel_record
        type: record
        fields:
          - name: image
            type: File
            inputBinding:
              position: 1
          - name: num_per_voxel
            type: int
            inputBinding:
              position: 2
      - name: seed_grid_per_voxel_record
        type: record
        fields:
          - name: image
            type: File
            inputBinding:
              position: 1
          - name: grid_size
            type: int
            inputBinding:
              position: 2
      - name: fslgrad_record
        type: record
        fields:
          - name: bvecs
            type: File
            inputBinding:
              position: 1
          - name: bvals
            type: File
            inputBinding:
              position: 2
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
