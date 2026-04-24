cwlVersion: v1.2
class: CommandLineTool
baseCommand: augur frequencies
label: augur_frequencies
doc: "infer frequencies of mutations or clades\n\nTool homepage: https://github.com/nextstrain/augur"
inputs:
  - id: alignments
    type:
      - 'null'
      - type: array
        items: File
    doc: alignments to estimate mutations frequencies for
    inputBinding:
      position: 101
      prefix: --alignments
  - id: censored
    type:
      - 'null'
      - boolean
    doc: calculate censored frequencies at each pivot
    inputBinding:
      position: 101
      prefix: --censored
  - id: gene_names
    type:
      - 'null'
      - type: array
        items: string
    doc: names of the sequences in the alignment, same order assumed
    inputBinding:
      position: 101
      prefix: --gene-names
  - id: ignore_char
    type:
      - 'null'
      - string
    doc: character to be ignored in frequency calculations
    inputBinding:
      position: 101
      prefix: --ignore-char
  - id: include_internal_nodes
    type:
      - 'null'
      - boolean
    doc: calculate frequencies for internal nodes as well as tips
    inputBinding:
      position: 101
      prefix: --include-internal-nodes
  - id: inertia
    type:
      - 'null'
      - float
    doc: determines how frequencies continue in absense of data (inertia=0 -> go
      flat, inertia=1.0 -> continue current trend)
    inputBinding:
      position: 101
      prefix: --inertia
  - id: max_date
    type:
      - 'null'
      - string
    doc: "date to end frequencies calculations; may be specified as: 1. an Augur-style
      numeric date with the year as the integer part (e.g. 2020.42) or 2. a date in
      ISO 8601 date format (i.e. YYYY-MM-DD) (e.g. '2020-06-04') or 3. a backwards-looking
      relative date in ISO 8601 duration format with optional P prefix (e.g. '1W',
      'P1W')"
    inputBinding:
      position: 101
      prefix: --max-date
  - id: metadata
    type: File
    doc: metadata including dates for given samples
    inputBinding:
      position: 101
      prefix: --metadata
  - id: metadata_delimiters
    type:
      - 'null'
      - type: array
        items: string
    doc: delimiters to accept when reading a metadata file. Only one delimiter 
      will be inferred.
      - ','
      - "\t"
    inputBinding:
      position: 101
      prefix: --metadata-delimiters
  - id: metadata_id_columns
    type:
      - 'null'
      - type: array
        items: string
    doc: names of possible metadata columns containing identifier information, 
      ordered by priority. Only one ID column will be inferred.
      - strain
      - name
    inputBinding:
      position: 101
      prefix: --metadata-id-columns
  - id: method
    type: string
    doc: method by which frequencies should be estimated
    inputBinding:
      position: 101
      prefix: --method
  - id: min_date
    type:
      - 'null'
      - string
    doc: "date to begin frequencies calculations; may be specified as: 1. an Augur-style
      numeric date with the year as the integer part (e.g. 2020.42) or 2. a date in
      ISO 8601 date format (i.e. YYYY-MM-DD) (e.g. '2020-06-04') or 3. a backwards-looking
      relative date in ISO 8601 duration format with optional P prefix (e.g. '1W',
      'P1W')"
    inputBinding:
      position: 101
      prefix: --min-date
  - id: minimal_clade_size
    type:
      - 'null'
      - int
    doc: minimal number of tips a clade must have for its diffusion frequencies 
      to be reported
    inputBinding:
      position: 101
      prefix: --minimal-clade-size
  - id: minimal_clade_size_to_estimate
    type:
      - 'null'
      - int
    doc: minimal number of tips a clade must have for its diffusion frequencies 
      to be estimated by the diffusion likelihood; all smaller clades will 
      inherit frequencies from their parents
    inputBinding:
      position: 101
      prefix: --minimal-clade-size-to-estimate
  - id: minimal_frequency
    type:
      - 'null'
      - float
    doc: minimal all-time frequencies for a trajectory to be estimates
    inputBinding:
      position: 101
      prefix: --minimal-frequency
  - id: narrow_bandwidth
    type:
      - 'null'
      - float
    doc: the bandwidth for the narrow KDE
    inputBinding:
      position: 101
      prefix: --narrow-bandwidth
  - id: output_format
    type:
      - 'null'
      - string
    doc: format to export frequencies JSON depending on the viewing interface
    inputBinding:
      position: 101
      prefix: --output-format
  - id: pivot_interval
    type:
      - 'null'
      - int
    doc: number of units between pivots
    inputBinding:
      position: 101
      prefix: --pivot-interval
  - id: pivot_interval_units
    type:
      - 'null'
      - string
    doc: space pivots by months (default) or by weeks
    inputBinding:
      position: 101
      prefix: --pivot-interval-units
  - id: proportion_wide
    type:
      - 'null'
      - float
    doc: the proportion of the wide bandwidth to use in the KDE mixture model
    inputBinding:
      position: 101
      prefix: --proportion-wide
  - id: regions
    type:
      - 'null'
      - type: array
        items: string
    doc: region to filter to. Regions should match values in the 'region' column
      of the metadata file if specifying values other than the default 'global' 
      region.
      - global
    inputBinding:
      position: 101
      prefix: --regions
  - id: stiffness
    type:
      - 'null'
      - float
    doc: parameter penalizing curvature of the frequency trajectory
    inputBinding:
      position: 101
      prefix: --stiffness
  - id: tree
    type:
      - 'null'
      - File
    doc: tree to estimate clade frequencies for
    inputBinding:
      position: 101
      prefix: --tree
  - id: weights
    type:
      - 'null'
      - string
    doc: a dictionary of key/value mappings in JSON format used to weight KDE 
      tip frequencies
    inputBinding:
      position: 101
      prefix: --weights
  - id: weights_attribute
    type:
      - 'null'
      - string
    doc: name of the attribute on each tip whose values map to the given weights
      dictionary
    inputBinding:
      position: 101
      prefix: --weights-attribute
  - id: wide_bandwidth
    type:
      - 'null'
      - float
    doc: the bandwidth for the wide KDE
    inputBinding:
      position: 101
      prefix: --wide-bandwidth
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: JSON file to save estimated frequencies to
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
