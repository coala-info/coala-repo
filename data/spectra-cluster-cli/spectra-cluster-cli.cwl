cwlVersion: v1.2
class: CommandLineTool
baseCommand: spectra-cluster-cli
label: spectra-cluster-cli
doc: "Clusters the spectra found in a MGF files or .clustering files and writes the results in a text-based file.\n\nTool homepage: https://github.com/spectra-cluster/spectra-cluster-cli"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: MGF files or .clustering files to cluster
    inputBinding:
      position: 200
  - id: add_scores
    type:
      - 'null'
      - boolean
    doc: "if set, the similarity scores of each spectrum to the cluster's consensus spectrum is added to the output file."
    inputBinding:
      position: 101
      prefix: -add_scores
  - id: fast_mode
    type:
      - 'null'
      - boolean
    doc: "if this option is set the 'fast mode' is enabled. In this mode, the radical peak filtering used for the comparison function is already applied during spectrum conversion. Thereby, the clustering and consensus spectrum quality is slightly decreased but speed increases 2-3 fold."
    inputBinding:
      position: 101
      prefix: -fast_mode
  - id: keep_binary_files
    type:
      - 'null'
      - boolean
    doc: "if this options is set, the binary files are not deleted after clustering."
    inputBinding:
      position: 101
      prefix: -keep_binary_files
  - id: only_identified
    type:
      - 'null'
      - boolean
    doc: "if set, only identified spectra are considered for clustering."
    inputBinding:
      position: 101
      prefix: -only_identified
  - id: only_unidentified
    type:
      - 'null'
      - boolean
    doc: "if set, only unidentified spectra are considered for clustering."
    inputBinding:
      position: 101
      prefix: -only_unidentified
  - id: reuse_binary_files
    type:
      - 'null'
      - boolean
    doc: "if this option is set, the binary files found in the binary file directory will be used for clustering."
    inputBinding:
      position: 101
      prefix: -reuse_binary_files
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "if set additional status information is printed."
    inputBinding:
      position: 101
      prefix: -verbose
  - id: x_convert_cgf
    type:
      - 'null'
      - boolean
    doc: "(Advanced option) It this option is set, the input file in CGF format will be converted to the .clustering file. No other processing will be performed."
    inputBinding:
      position: 101
      prefix: -x_convert_cgf
  - id: x_disable_mgf_comments
    type:
      - 'null'
      - boolean
    doc: "(Advanced option) If set, MGF comment strings are NOT supported. This will increase performance but only works for MGF files that do not contain any comments"
    inputBinding:
      position: 101
      prefix: -x_disable_mgf_comments
  - id: x_filter_peaks_mz
    type:
      - 'null'
      - boolean
    doc: "(Advanced option) If this option is set, the top 10 peaks per 100 m/z are retained instead of the top N peaks overall."
    inputBinding:
      position: 101
      prefix: -x_filter_peaks_mz
  - id: x_merge_binary_files
    type:
      - 'null'
      - boolean
    doc: "(Advanced option) If this option is set, the input files should be binary result files from the clustering process. In this mode, the spectra-cluster-cli only merges the binary files and creates the final output file."
    inputBinding:
      position: 101
      prefix: -x_merge_binary_files
  - id: filter
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -filter
    doc: "adds a filter to be applied to the input spectrum. Available values are ['immonium_ions', 'mz_150', 'mz_200']"
    inputBinding:
      position: 101
  - id: binary_directory
    type:
      - 'null'
      - string
    doc: "path to the directory to (temporarily) store the binary files. By default a temporary directory is being created"
    inputBinding:
      position: 101
      prefix: -binary_directory
  - id: fragment_tolerance
    type:
      - 'null'
      - float
    doc: "fragment ion tolerance in m/z to use for fragment peak matching"
    inputBinding:
      position: 101
      prefix: -fragment_tolerance
  - id: major_peak_jobs
    type:
      - 'null'
      - int
    doc: "number of threads to use for major peak clustering."
    inputBinding:
      position: 101
      prefix: -major_peak_jobs
  - id: output_path
    type:
      - 'null'
      - string
    doc: "path to the outputfile. Outputfile must not exist."
    inputBinding:
      position: 101
      prefix: -output_path
  - id: precursor_tolerance
    type:
      - 'null'
      - float
    doc: "precursor tolerance (clustering window size) in m/z (default) or ppm used during matching. The unit can be changed by setting the -precursor_tolerance_unit parameter"
    inputBinding:
      position: 101
      prefix: -precursor_tolerance
  - id: precursor_tolerance_unit
    type:
      - 'null'
      - string
    doc: "sets the precursor tolerance unit. Allowed values are \"mz\" and \"ppm\". Default is \"mz\"."
    inputBinding:
      position: 101
      prefix: -precursor_tolerance_unit
  - id: remove_reporters
    type:
      - 'null'
      - string
    doc: "remove reporter ion peaks in quantitation experiments. Possible QUANTIATION TYPES are 'ITRAQ', 'TMT' and 'ALL' ('TMT' and 'ITRAQ' peaks are removed."
    inputBinding:
      position: 101
      prefix: -remove_reporters
  - id: rounds
    type:
      - 'null'
      - int
    doc: "number of clustering rounds to use."
    inputBinding:
      position: 101
      prefix: -rounds
  - id: threshold_end
    type:
      - 'null'
      - float
    doc: "(lowest) final clustering threshold"
    inputBinding:
      position: 101
      prefix: -threshold_end
  - id: threshold_start
    type:
      - 'null'
      - float
    doc: "(highest) starting threshold"
    inputBinding:
      position: 101
      prefix: -threshold_start
  - id: x_learn_cdf
    type:
      - 'null'
      - string
    doc: "(Experimental option) Learn the used cumulative distribution function directly from the processed data. This is only recommended for high-resolution data. The result will be written to the defined file."
    inputBinding:
      position: 101
      prefix: -x_learn_cdf
  - id: x_load_cdf
    type:
      - 'null'
      - File
    doc: "(Experimental option) Loads the cumulative distribution function to use from the specified file. These files can be created using the x_learn_cdf parameter"
    inputBinding:
      position: 101
      prefix: -x_load_cdf
  - id: x_min_adapt_comparisons
    type:
      - 'null'
      - int
    doc: "(Experimental option) Uses an adaptive function for the minimum comparisons together with a minimum number always to return."
    inputBinding:
      position: 101
      prefix: -x_min_adapt_comparisons
  - id: x_min_comparisons
    type:
      - 'null'
      - int
    doc: "(Experimental option) Sets the minimum number of comparisons used to calculate the probability that incorrect spectra are clustered."
    inputBinding:
      position: 101
      prefix: -x_min_comparisons
  - id: x_min_consensus_peaks_to_keep
    type:
      - 'null'
      - int
    doc: "(Advanced option) Sets the minimum number of peaks to keep in a consensus spectrum. If the consensus spectrum contains fewer than these peaks, the noise filtering which retains N peaks per M m/z is not used but all peaks are kept"
    inputBinding:
      position: 101
      prefix: -x_min_consensus_peaks_to_keep
  - id: x_n_prefiltered_peaks
    type:
      - 'null'
      - int
    doc: "(Experimental option) Set the number of highest peaks that are kept per spectrum during loading."
    inputBinding:
      position: 101
      prefix: -x_n_prefiltered_peaks
outputs:
  - id: clustering_output
    type:
      - 'null'
      - File
    doc: Clustering result file written with -output_path
    outputBinding:
      glob: $(inputs.output_path)
  - id: cdf_output
    type:
      - 'null'
      - File
    doc: Cumulative distribution function file written with -x_learn_cdf
    outputBinding:
      glob: $(inputs.x_learn_cdf)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spectra-cluster-cli:1.1.2--0
stdout: spectra-cluster-cli.out
