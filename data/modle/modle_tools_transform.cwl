cwlVersion: v1.2
class: CommandLineTool
baseCommand: [modle_tools, transform]
label: modle_tools_transform
doc: "Transform contact matrices in cooler format using one of the supported transformation methods.\n\nTool homepage: https://github.com/paulsengroup/MoDLE"
inputs:
  - id: input_cooler
    type: File
    doc: Path or URI to a Cooler file to use as input.
    inputBinding:
      position: 101
      prefix: --input-cooler
  - id: output_cooler
    type: string
    doc: Path or URI to the output Cooler.
    inputBinding:
      position: 101
      prefix: --output-cooler
  - id: method
    type: string
    doc: 'Transformation method to apply to the input contact matrix. Supported
      methods: difference_of_gaussians, discretize, gaussian_blur, normalize.'
    inputBinding:
      position: 101
      prefix: --method
  - id: diagonal_width
    type: int
    doc: Width of the subdiagonal window to transform. Pixels outside the window
      are set to 0.
    inputBinding:
      position: 101
      prefix: --diagonal-width
  - id: normalization_range
    type:
      - 'null'
      - string
    doc: Lower and upper bound for the normalization range as a comma-separate
      pair of values.
    inputBinding:
      position: 101
      prefix: --normalization-range
  - id: saturation_range
    type:
      - 'null'
      - string
    doc: Lower and upper bound for the saturation range as a comma-separate pair
      of values.
    inputBinding:
      position: 101
      prefix: --saturation-range
  - id: gaussian_blur_sigma
    type:
      - 'null'
      - float
    doc: Gaussian kernel sigma. Controls the level of blurriness applied to
      contact matrices when using the difference of Gaussians as transformation
      method.
    inputBinding:
      position: 101
      prefix: --gaussian-blur-sigma
  - id: gaussian_blur_multiplier
    type:
      - 'null'
      - float
    doc: Gaussian blur multiplier. Multiplier used to compute the sigma of the
      Gaussian kernel used to generate the more blurry contact matrix.
    inputBinding:
      position: 101
      prefix: --gaussian-blur-multiplier
  - id: binary_discretization_value
    type:
      - 'null'
      - float
    doc: Threshold for the step function used to discretize pixels. Pixels above
      the threshold are mapped to 1, while all the others are mapped to 0.
    inputBinding:
      position: 101
      prefix: --binary-discretization-value
  - id: discretization_ranges_tsv
    type:
      - 'null'
      - File
    doc: Path to a TSV with the discretization ranges. The TSV should have three
      columns with the first and last values of a discretization interval and the
      discretization value.
    inputBinding:
      position: 101
      prefix: --discretization-ranges-tsv
  - id: float_contacts
    type:
      - 'null'
      - boolean
    doc: Use floating point numbers to represent contacts.
    inputBinding:
      position: 101
      prefix: --float-contacts
  - id: integer_contacts
    type:
      - 'null'
      - boolean
    doc: Use integer numbers to represent contacts.
    inputBinding:
      position: 101
      prefix: --integer-contacts
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing files (if any).
    inputBinding:
      position: 101
      prefix: --force
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of worker threads.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_cooler_file
    type: File
    doc: Transformed contact matrix in cooler format.
    outputBinding:
      glob: $(inputs.output_cooler)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/modle:1.1.0--h63853f4_0
stdout: modle_tools_transform.out
