cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tombo
  - text_output
  - browser_files
label: ont-tombo_text_output_browser_files
doc: "Write text outputs for genome browser visualization and bioinformatic processing (wiggle or bedGraph file format).\n\nTool homepage: https://github.com/nanoporetech/tombo"
inputs:
  - id: fast5_basedirs
    type: Directory[]
    doc: "Directories containing fast5 files."
    inputBinding:
      position: 101
      prefix: "--fast5-basedirs"
      valueFrom: "$(self.map(function(d) { return d.basename; }))"
  - id: control_fast5_basedirs
    type:
      - 'null'
      - Directory[]
    doc: "Set of directories containing fast5 files for control reads, containing only canonical nucleotides."
    inputBinding:
      position: 101
      prefix: "--control-fast5-basedirs"
      valueFrom: "$(self.map(function(d) { return d.basename; }))"
  - id: statistics_filename
    type:
      - 'null'
      - File
    doc: "File to save/load genomic base anchored statistics."
    inputBinding:
      position: 101
      prefix: "--statistics-filename"
  - id: genome_fasta
    type:
      - 'null'
      - File
    doc: "FASTA file used to re-squiggle. For faster sequence access."
    inputBinding:
      position: 101
      prefix: "--genome-fasta"
      valueFrom: "$(self.basename)"
  - id: motif_descriptions
    type:
      - 'null'
      - string[]
    doc: "Ground truth, motif centered, modified base descriptions for output filtering. Format descriptions as: \"motif:mod_pos:name\". The mod_pos indicates the modified base within the motif (1-based index). Example: CCWGG:2:dcm_5mC GATC:2:dam_6mA would filter output for identification of E. coli dam and dcm methylation."
    inputBinding:
      position: 101
      prefix: "--motif-descriptions"
  - id: browser_file_basename
    type: string
    doc: "Basename for output browser files. Two files (plus and minus strand) will be produced for each --file-types supplied. Filenames formatted as \"[browser-file- basename].[file- type].[sample|control]?.[plus|minus].[wig|bedgraph]\". Default: tombo_results"
    inputBinding:
      position: 101
      prefix: "--browser-file-basename"
  - id: file_types
    type: string[]
    doc: "Data types of genome browser files to produce. Produced coverage files are in bedGraph format, while all other file types will be in wiggle format (https://genome.ucsc.edu/goldenpath/help/wiggle.html). Default: \"coverage\""
    inputBinding:
      position: 101
      prefix: "--file-types"
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
  - id: browser_files
    type: File[]
    doc: "Wiggle / bedGraph files written with the basename"
    outputBinding:
      glob: "$(inputs.browser_file_basename + '*')"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.fast5_basedirs)
        writable: true
      - entry: $(inputs.control_fast5_basedirs)
        writable: true
      - entry: $(inputs.genome_fasta)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
