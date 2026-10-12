cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tombo
  - text_output
  - signif_sequence_context
label: ont-tombo_text_output_signif_sequence_context
doc: "Write genomic/transcriptomic sequence centered on most modified genomic locations.\n\nTool homepage: https://github.com/nanoporetech/tombo"
inputs:
  - id: statistics_filename
    type: File
    doc: "File to save/load genomic base anchored statistics."
    inputBinding:
      position: 101
      prefix: "--statistics-filename"
  - id: genome_fasta
    type: File
    doc: "FASTA file used to re-squiggle. For faster sequence access."
    inputBinding:
      position: 101
      prefix: "--genome-fasta"
      valueFrom: "$(self.basename)"
  - id: fast5_basedirs
    type: Directory[]
    doc: "Directories containing fast5 files."
    inputBinding:
      position: 101
      prefix: "--fast5-basedirs"
      valueFrom: "$(self.map(function(d) { return d.basename; }))"
  - id: num_regions
    type:
      - 'null'
      - int
    doc: "Number of regions to plot. Default: 100"
    inputBinding:
      position: 101
      prefix: "--num-regions"
  - id: num_bases
    type:
      - 'null'
      - int
    doc: "Number of bases to plot/output. Default: 15"
    inputBinding:
      position: 101
      prefix: "--num-bases"
  - id: sequences_filename
    type:
      - 'null'
      - string
    doc: "File for sequences from selected regions. Sequences will be stored in FASTA format. Default: tombo_results.significant_regions.fasta."
    default: "tombo_results.significant_regions.fasta"
    inputBinding:
      position: 101
      prefix: "--sequences-filename"
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
      - string[]
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
  - id: sequences_file
    type: File
    doc: "FASTA of sequences around the most significant locations"
    outputBinding:
      glob: "$(inputs.sequences_filename)"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.genome_fasta)
        writable: true
      - entry: $(inputs.fast5_basedirs)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
