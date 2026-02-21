cwlVersion: v1.2
class: CommandLineTool
baseCommand: apt-probeset-summarize
label: apt-probeset-summarize
doc: "A program for summarizing expression probe data from cel files. Can use either
  a cdf file or pgf/clf files for defining probesets.\n\nTool homepage: https://downloads.thermofisher.com"
inputs:
  - id: cel_files_positional
    type:
      - 'null'
      - type: array
        items: File
    doc: Input CEL files to process
    inputBinding:
      position: 1
  - id: analysis
    type:
      - 'null'
      - type: array
        items: string
    doc: String representing analysis pathway desired (e.g., rma-sketch, plier-mm-sketch).
    inputBinding:
      position: 102
      prefix: --analysis
  - id: analysis_files_path
    type:
      - 'null'
      - Directory
    doc: Search path for analysis library files.
    inputBinding:
      position: 102
      prefix: --analysis-files-path
  - id: bgp_file
    type:
      - 'null'
      - File
    doc: File defining probes to be used for GC background.
    inputBinding:
      position: 102
      prefix: --bgp-file
  - id: cc_chp_output
    type:
      - 'null'
      - boolean
    doc: Output results in directory called 'cc-chp' under out-dir.
    default: false
    inputBinding:
      position: 102
      prefix: --cc-chp-output
  - id: cc_md_chp_output
    type:
      - 'null'
      - boolean
    doc: Output resulting calls in directory called 'cc-md-chp' under out-dir.
    default: false
    inputBinding:
      position: 102
      prefix: --cc-md-chp-output
  - id: cdf_file
    type:
      - 'null'
      - File
    doc: File defining probe sets (CDF format).
    inputBinding:
      position: 102
      prefix: --cdf-file
  - id: cel_files_list
    type:
      - 'null'
      - File
    doc: Text file specifying cel files to process, one per line.
    inputBinding:
      position: 102
      prefix: --cel-files
  - id: chip_type
    type:
      - 'null'
      - type: array
        items: string
    doc: Chip types to check library and CEL files against.
    inputBinding:
      position: 102
      prefix: --chip-type
  - id: clf_file
    type:
      - 'null'
      - File
    doc: File defining x,y <-> probe id conversion. Required when using PGF file.
    inputBinding:
      position: 102
      prefix: --clf-file
  - id: console_off
    type:
      - 'null'
      - boolean
    doc: Turn off the default messages to the console but not logging or sockets.
    default: false
    inputBinding:
      position: 102
      prefix: --console-off
  - id: disk_cache
    type:
      - 'null'
      - int
    doc: Size of intensity memory cache in millions of intensities.
    default: 50
    inputBinding:
      position: 102
      prefix: --disk-cache
  - id: explain
    type:
      - 'null'
      - string
    doc: Explain a particular operation (i.e. --explain rma-bg).
    inputBinding:
      position: 102
      prefix: --explain
  - id: feat_details
    type:
      - 'null'
      - boolean
    doc: Output probe by chip specific details (often residuals) when available.
    default: false
    inputBinding:
      position: 102
      prefix: --feat-details
  - id: feat_effects
    type:
      - 'null'
      - boolean
    doc: Output feature effects when available.
    default: false
    inputBinding:
      position: 102
      prefix: --feat-effects
  - id: force
    type:
      - 'null'
      - boolean
    doc: Disable various checks including chip types.
    default: false
    inputBinding:
      position: 102
      prefix: --force
  - id: kill_list
    type:
      - 'null'
      - File
    doc: Do not use the PM probes specified in file for computing results.
    inputBinding:
      position: 102
      prefix: --kill-list
  - id: meta_probesets
    type:
      - 'null'
      - File
    doc: File containing meta probeset definitions.
    inputBinding:
      position: 102
      prefix: --meta-probesets
  - id: pgf_file
    type:
      - 'null'
      - File
    doc: File defining probe sets (PGF format).
    inputBinding:
      position: 102
      prefix: --pgf-file
  - id: precision
    type:
      - 'null'
      - int
    doc: How many digits of precision to use after decimal.
    default: 5
    inputBinding:
      position: 102
      prefix: --precision
  - id: probe_class_file
    type:
      - 'null'
      - File
    doc: File containing probe_id of probes and a 'class' designation.
    inputBinding:
      position: 102
      prefix: --probe-class-file
  - id: probeset_ids
    type:
      - 'null'
      - File
    doc: File specifying probe sets to summarize.
    inputBinding:
      position: 102
      prefix: --probeset-ids
  - id: qc_probesets
    type:
      - 'null'
      - File
    doc: File specifying subsets of probesets to compute qc stats for.
    inputBinding:
      position: 102
      prefix: --qc-probesets
  - id: set_analysis_name
    type:
      - 'null'
      - string
    doc: Explicitly set the analysis name. Affects output file names.
    inputBinding:
      position: 102
      prefix: --set-analysis-name
  - id: spf_file
    type:
      - 'null'
      - File
    doc: File defining probe sets in spf (simple probe format).
    inputBinding:
      position: 102
      prefix: --spf-file
  - id: subsample_report
    type:
      - 'null'
      - boolean
    doc: Output subsamples of the data intensities, summaries and residuals.
    default: false
    inputBinding:
      position: 102
      prefix: --subsample-report
  - id: summaries
    type:
      - 'null'
      - boolean
    doc: Output expression summaries in text table format.
    default: true
    inputBinding:
      position: 102
      prefix: --summaries
  - id: target_sketch
    type:
      - 'null'
      - File
    doc: File specifying a target distribution to use for quantile normalization.
    inputBinding:
      position: 102
      prefix: --target-sketch
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: Directory for temporary files when working off disk.
    inputBinding:
      position: 102
      prefix: --temp-dir
  - id: throw_exception
    type:
      - 'null'
      - boolean
    doc: Throw an exception rather than calling exit() on error.
    default: false
    inputBinding:
      position: 102
      prefix: --throw-exception
  - id: use_disk
    type:
      - 'null'
      - boolean
    doc: Store CEL intensities to be analyzed on disk.
    default: true
    inputBinding:
      position: 102
      prefix: --use-disk
  - id: use_feat_eff
    type:
      - 'null'
      - File
    doc: File defining a plier feature effect for each probe.
    inputBinding:
      position: 102
      prefix: --use-feat-eff
  - id: use_pgf_names
    type:
      - 'null'
      - boolean
    doc: Use the probeset_names instead of probeset_id column in the PGF file for
      output.
    default: false
    inputBinding:
      position: 102
      prefix: --use-pgf-names
  - id: use_socket
    type:
      - 'null'
      - string
    doc: Host and port to print messages over in localhost:port format
    inputBinding:
      position: 102
      prefix: --use-socket
  - id: verbose
    type:
      - 'null'
      - int
    doc: How verbose to be with status messages 0 - quiet, 1 - usual messages, 2 -
      more messages.
    default: 1
    inputBinding:
      position: 102
      prefix: --verbose
  - id: write_sketch
    type:
      - 'null'
      - boolean
    doc: Write the quantile normalization distribution (or sketch) to a file.
    default: false
    inputBinding:
      position: 102
      prefix: --write-sketch
  - id: xda_chp_output
    type:
      - 'null'
      - boolean
    doc: Output resulting calls in directory called 'chp' under out-dir.
    default: false
    inputBinding:
      position: 102
      prefix: --xda-chp-output
  - id: xml_file
    type:
      - 'null'
      - File
    doc: Input parameters in XML format.
    inputBinding:
      position: 102
      prefix: --xml-file
outputs:
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Directory for output files.
    outputBinding:
      glob: $(inputs.out_dir)
  - id: log_file
    type:
      - 'null'
      - File
    doc: The name of the log file.
    outputBinding:
      glob: $(inputs.log_file)
  - id: cc_chp_out_dir
    type:
      - 'null'
      - Directory
    doc: Over-ride the default location for chp output.
    outputBinding:
      glob: $(inputs.cc_chp_out_dir)
  - id: xda_chp_out_dir
    type:
      - 'null'
      - Directory
    doc: Over-ride the default location for chp output.
    outputBinding:
      glob: $(inputs.xda_chp_out_dir)
  - id: cc_md_chp_out_dir
    type:
      - 'null'
      - Directory
    doc: Over-ride the default location for chp output.
    outputBinding:
      glob: $(inputs.cc_md_chp_out_dir)
  - id: report_file
    type:
      - 'null'
      - File
    doc: Over-ride the default report file name.
    outputBinding:
      glob: $(inputs.report_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/apt-probeset-summarize:2.10.0--h9948957_6
