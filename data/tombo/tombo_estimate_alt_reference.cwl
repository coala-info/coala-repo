cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tombo
  - estimate_alt_reference
label: tombo_estimate_alt_reference
doc: "Estimate alternative reference models from FAST5 data for non-standard base
  detection.\n\nTool homepage: https://github.com/nanoporetech/tombo"
inputs:
  - id: alternate_model_base
    type: string
    doc: Non-standard base is an alternative to this base (A, C, G, or T).
    inputBinding:
      position: 101
      prefix: --alternate-model-base
  - id: alternate_model_filename
    type: string
    doc: Output file name for the estimated alternative base tombo model.
    inputBinding:
      position: 101
      prefix: --alternate-model-filename
  - id: alternate_model_name
    type: string
    doc: A short name to associate with this alternate model (e.g. 5mC, 4mC, 
      6mA). This text will be included in output filenames when this model is 
      used for testing.
    inputBinding:
      position: 101
      prefix: --alternate-model-name
  - id: basecall_subgroups
    type:
      - 'null'
      - type: array
        items: string
    doc: FAST5 subgroup(s) (under Analyses/[corrected-group]) containing 
      basecalls.
    inputBinding:
      position: 101
      prefix: --basecall-subgroups
  - id: corrected_group
    type:
      - 'null'
      - string
    doc: FAST5 group created by resquiggle command.
    inputBinding:
      position: 101
      prefix: --corrected-group
  - id: fast5_basedirs
    type:
      type: array
      items: Directory
    doc: Directories containing fast5 files.
    inputBinding:
      position: 101
      prefix: --fast5-basedirs
      valueFrom: '$(self === null ? null : self.map(function(d) { return d.basename;
        }))'
  - id: min_alt_base_percentage
    type:
      - 'null'
      - float
    doc: Minimum estimated percent of non-standard base distribution for 
      inclusion of k-mer in non-standard model.
    inputBinding:
      position: 101
      prefix: --min-alt-base-percentage
  - id: minimum_kmer_observations
    type:
      - 'null'
      - int
    doc: Number of each k-mer observations required in order to produce a 
      reference (genomic locations for standard reference and per-read for 
      alternative reference).
    inputBinding:
      position: 101
      prefix: --minimum-kmer-observations
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Don't print status information.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: sd_threshold
    type:
      - 'null'
      - float
    doc: Minimum level standard deviation difference between estimated 
      non-standard distribution mean and standard model mean for inclusion of 
      k-mer in non-standard model.
    inputBinding:
      position: 101
      prefix: --sd-threshold
  - id: tombo_model_filename
    type:
      - 'null'
      - File
    doc: Tombo model for event-less resquiggle and significance testing. If no 
      model is provided the default DNA or RNA tombo model will be used.
    inputBinding:
      position: 101
      prefix: --tombo-model-filename
outputs:
  - id: alternate_model
    type: File
    doc: Estimated alternative base tombo model file
    outputBinding:
      glob: $(inputs.alternate_model_filename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.fast5_basedirs)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tombo:1.0--py27_0
