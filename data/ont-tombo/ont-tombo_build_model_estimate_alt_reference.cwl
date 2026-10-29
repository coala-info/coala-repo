cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tombo
  - build_model
  - estimate_alt_reference
label: ont-tombo_build_model_estimate_alt_reference
doc: "Estimate alternative tombo model from a sample containing canonical bases spiked with a single non-standard base.\n\nTool homepage: https://github.com/nanoporetech/tombo"
inputs:
  - id: alternate_model_filename
    type: string
    doc: "Tombo model for alternative likelihood ratio significance testing."
    inputBinding:
      position: 101
      prefix: "--alternate-model-filename"
  - id: alternate_model_name
    type: string
    doc: "A short name to associate with this alternate model (e.g. 5mC, 6mA, etc.). This text will be included in output filenames when this model is used for testing."
    inputBinding:
      position: 101
      prefix: "--alternate-model-name"
  - id: alternate_model_base
    type: string
    doc: "Non-standard base is an alternative to this base."
    inputBinding:
      position: 101
      prefix: "--alternate-model-base"
  - id: fast5_basedirs
    type:
      - 'null'
      - type: array
        items: Directory
    doc: "Directories containing fast5 files."
    inputBinding:
      position: 101
      prefix: "--fast5-basedirs"
      valueFrom: "$(self.map(function(d) { return d.basename; }))"
  - id: control_fast5_basedirs
    type:
      - 'null'
      - type: array
        items: Directory
    doc: "Set of directories containing fast5 files for control reads, containing only canonical nucleotides."
    inputBinding:
      position: 101
      prefix: "--control-fast5-basedirs"
      valueFrom: "$(self.map(function(d) { return d.basename; }))"
  - id: alternate_density_filename
    type:
      - 'null'
      - File
    doc: "File containing k-mer level kernel density estimates for the alternative sample saved using --save-density- basename."
    inputBinding:
      position: 101
      prefix: "--alternate-density-filename"
  - id: control_density_filename
    type:
      - 'null'
      - File
    doc: "File containing k-mer level kernel density estimates for the control sample saved using --save-density- basename."
    inputBinding:
      position: 101
      prefix: "--control-density-filename"
  - id: dna
    type:
      - 'null'
      - boolean
    doc: "Explicitly select canonical DNA model. Default: Automatically determine from FAST5s"
    inputBinding:
      position: 101
      prefix: "--dna"
  - id: rna
    type:
      - 'null'
      - boolean
    doc: "Explicitly select canonical RNA model. Default: Automatically determine from FAST5s"
    inputBinding:
      position: 101
      prefix: "--rna"
  - id: tombo_model_filename
    type:
      - 'null'
      - File
    doc: "Tombo model filename. If no file is provided, the default DNA or RNA Tombo model will be used."
    inputBinding:
      position: 101
      prefix: "--tombo-model-filename"
  - id: alt_fraction_percentile
    type:
      - 'null'
      - float
    doc: "When esitmating the alternative base incorporation rate, this percent of k-mers are assumed to have significantly shifted signal so the alternative distribution minimally overlaps the standard base distribution. Default: 5.000000"
    inputBinding:
      position: 101
      prefix: "--alt-fraction-percentile"
  - id: kernel_density_bandwidth
    type:
      - 'null'
      - float
    doc: "Bandwidth applied when performing Gaussian kernal density esitmation on standard and alternative base signal distributions. Default: 0.050000"
    inputBinding:
      position: 101
      prefix: "--kernel-density-bandwidth"
  - id: minimum_kmer_observations
    type:
      - 'null'
      - int
    doc: "Number of each k-mer observations required in order to produce a reference (genomic locations for standard reference and per-read for alternative reference). Default: 1000"
    inputBinding:
      position: 101
      prefix: "--minimum-kmer-observations"
  - id: save_density_basename
    type:
      - 'null'
      - string
    doc: "Basename to save alternative model estimation density estimation information. See scripts/debug_est_alt.R for info use example. Default: Don't save."
    inputBinding:
      position: 101
      prefix: "--save-density-basename"
  - id: processes
    type:
      - 'null'
      - int
    doc: "Number of processes. Default: 1"
    inputBinding:
      position: 101
      prefix: "--processes"
  - id: corrected_group
    type:
      - 'null'
      - string
    doc: "FAST5 group created by resquiggle command. Default: RawGenomeCorrected_000"
    inputBinding:
      position: 101
      prefix: "--corrected-group"
  - id: basecall_subgroups
    type:
      - 'null'
      - type: array
        items: string
    doc: "FAST5 subgroup(s) (under /Analyses/[--basecall- group]/) containing basecalls and created within [--corrected-group] containing re-squiggle results. Default: ['BaseCalled_template']"
    inputBinding:
      position: 101
      prefix: "--basecall-subgroups"
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Don't print status information."
    inputBinding:
      position: 101
      prefix: "--quiet"
outputs:
  - id: alternate_model
    type: File
    doc: "Estimated alternative Tombo model file"
    outputBinding:
      glob: "$(inputs.alternate_model_filename)"
  - id: density_files
    type:
      type: array
      items: File
    doc: "Density estimation files written with --save-density-basename"
    outputBinding:
      glob: "$(inputs.save_density_basename ? [inputs.save_density_basename + '*'] : [])"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.fast5_basedirs)
        writable: true
      - entry: $(inputs.control_fast5_basedirs)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
