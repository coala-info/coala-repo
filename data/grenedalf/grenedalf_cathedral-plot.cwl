cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - grenedalf
  - cathedral-plot
label: grenedalf_cathedral-plot
doc: "Create a cathedral plot, using the pre-computated cathedral data.\n\nTool homepage:
  https://github.com/lczech/grenedalf"
inputs:
  - id: allow_file_overwriting
    type:
      - 'null'
      - boolean
    doc: Allow to overwrite existing output files instead of aborting the 
      command. By default, we abort if any output file already exists, to avoid 
      overwriting by mistake.
    inputBinding:
      position: 101
      prefix: --allow-file-overwriting
  - id: clip
    type:
      - 'null'
      - boolean
    doc: Clip (i.e., clamp) values to be inside `[ min, max ]`, by setting 
      values outside of that interval to the nearest boundary of it. This option
      is a shortcut to set `--clip-under` and `--clip-over` at once.
    inputBinding:
      position: 101
      prefix: --clip
  - id: clip_over
    type:
      - 'null'
      - boolean
    doc: Clip (i.e., clamp) values greater than max to be inside `[ min, max ]`,
      by setting values that are too high to the specified max value. If set, 
      `--over-color` is not used to indicate values out of range.
    inputBinding:
      position: 101
      prefix: --clip-over
  - id: clip_under
    type:
      - 'null'
      - boolean
    doc: Clip (i.e., clamp) values less than min to be inside `[ min, max ]`, by
      setting values that are too low to the specified min value. If set, 
      `--under-color` is not used to indicate values out of range.
    inputBinding:
      position: 101
      prefix: --clip-under
  - id: color_list
    type:
      - 'null'
      - string
    doc: List of colors to use for the palette. Can either be the name of a 
      color list, a file containing one color per line, or an actual 
      comma-separated list of colors. Colors can be specified in the format 
      `#rrggbb` using hex values, or by web color names.
    default: inferno
    inputBinding:
      position: 101
      prefix: --color-list
  - id: color_normalization
    type:
      - 'null'
      - string
    doc: To create the cathedral plot, the value of each pixel needs to be 
      translated into a color, by mapping from the range of values into the 
      range of the color map. This translation can be done as a simple linear 
      transform, or logarithmic, so that low values can be distinguished with 
      more detail.
    default: linear
    inputBinding:
      position: 101
      prefix: --color-normalization
  - id: csv_path
    type:
      - 'null'
      - type: array
        items: File
    doc: List of csv files or directories to process. For directories, only 
      files with the extension `.csv` are processed. To input more than one file
      or directory, either separate them with spaces, or provide this option 
      multiple times.
    inputBinding:
      position: 101
      prefix: --csv-path
  - id: file_prefix
    type:
      - 'null'
      - string
    doc: File prefix for output files. Most grenedalf commands use the command 
      name as the base name for file output. This option amends the base name, 
      to distinguish runs with different data.
    inputBinding:
      position: 101
      prefix: --file-prefix
  - id: file_suffix
    type:
      - 'null'
      - string
    doc: File suffix for output files. Most grenedalf commands use the command 
      name as the base name for file output. This option amends the base name, 
      to distinguish runs with different data.
    inputBinding:
      position: 101
      prefix: --file-suffix
  - id: json_path
    type:
      - 'null'
      - type: array
        items: File
    doc: List of json files or directories to process. For directories, only 
      files with the extension `.json` are processed. To input more than one 
      file or directory, either separate them with spaces, or provide this 
      option multiple times.
    inputBinding:
      position: 101
      prefix: --json-path
  - id: log_file
    type:
      - 'null'
      - string
    doc: Write all output to a log file, in addition to standard output to the 
      terminal.
    inputBinding:
      position: 101
      prefix: --log-file
  - id: max_value
    type:
      - 'null'
      - float
    doc: See `--min-value`; this is the equivalent upper limit of values.Any 
      value that is above the max specified here will then be mapped to the 
      `over` color, or be clipped to the highest value in the color map.
    default: nan
    inputBinding:
      position: 101
      prefix: --max-value
  - id: min_value
    type:
      - 'null'
      - float
    doc: As an alternative to determining the range of values automatically, the
      range limits can be set explicitly. This allows for instance to cap the 
      visualization in cases of outliers that would otherwise hide detail in the
      lower values. Any value that is below the min specified here will then be 
      mapped to the `under` color, or clipped to the lowest value in the color 
      map.
    default: nan
    inputBinding:
      position: 101
      prefix: --min-value
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Directory to write files to
    default: .
    inputBinding:
      position: 101
      prefix: --out-dir
  - id: over_color
    type:
      - 'null'
      - string
    doc: Color used to indicate values above the max value. Color can be 
      specified in the format `#rrggbb` using hex values, or by web color names.
    default: '#ff00ff'
    inputBinding:
      position: 101
      prefix: --over-color
  - id: reverse_color_list
    type:
      - 'null'
      - boolean
    doc: If set, the order of colors of the `--color-list` is reversed.
    inputBinding:
      position: 101
      prefix: --reverse-color-list
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for calculations. If not set, we guess a 
      reasonable number of threads, by looking at the environmental variables 
      (1) `OMP_NUM_THREADS` (OpenMP) and (2) `SLURM_CPUS_PER_TASK` (slurm), as 
      well as (3) the hardware concurrency (number of CPU cores), taking 
      hyperthreads into account, in the given order of precedence.
    default: 14
    inputBinding:
      position: 101
      prefix: --threads
  - id: under_color
    type:
      - 'null'
      - string
    doc: Color used to indicate values below the min value. Color can be 
      specified in the format `#rrggbb` using hex values, or by web color names.
    default: '#00ffff'
    inputBinding:
      position: 101
      prefix: --under-color
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Produce more verbose output.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grenedalf:0.6.3--hbefcdb2_0
stdout: grenedalf_cathedral-plot.out
