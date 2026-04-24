cwlVersion: v1.2
class: CommandLineTool
baseCommand: megalodon
label: megalodon
doc: "Megalodon is a tool for basecalling and variant calling from Oxford Nanopore
  sequencing data.\n\nTool homepage: https://github.com/nanoporetech/megalodon"
inputs:
  - id: fast5s_dir
    type: Directory
    doc: Directory containing raw fast5 (will be searched recursively).
    inputBinding:
      position: 1
  - id: devices
    type:
      - 'null'
      - type: array
        items: string
    doc: GPU devices for guppy or taiyaki basecalling backends.
    inputBinding:
      position: 102
      prefix: --devices
  - id: guppy_config
    type:
      - 'null'
      - string
    doc: Guppy config.
    inputBinding:
      position: 102
      prefix: --guppy-config
  - id: guppy_server_path
    type:
      - 'null'
      - string
    doc: Path to guppy server executable.
    inputBinding:
      position: 102
      prefix: --guppy-server-path
  - id: haploid
    type:
      - 'null'
      - boolean
    doc: 'Compute variant aggregation for haploid genotypes. Default: diploid'
    inputBinding:
      position: 102
      prefix: --haploid
  - id: help_long
    type:
      - 'null'
      - boolean
    doc: Show all options.
    inputBinding:
      position: 102
      prefix: --help-long
  - id: live_processing
    type:
      - 'null'
      - boolean
    doc: Process reads from a live sequencing run. The [fast5s_dir] must be the 
      base MinKNOW output directory. Megalodon will continue searching for FAST5
      files until the file starting with "final_summary" is found.
    inputBinding:
      position: 102
      prefix: --live-processing
  - id: mappings_format
    type:
      - 'null'
      - string
    doc: Mappings output format.
    inputBinding:
      position: 102
      prefix: --mappings-format
  - id: mod_motif
    type:
      - 'null'
      - type: array
        items: string
    doc: Restrict modified base calls to specified motif(s). Argument takes 3 
      values representing 1) the single letter modified base(s), 2) sequence 
      motif and 3) relative modified base position. Multiple --mod-motif 
      arguments may be provided to a single command. For example to restrict to 
      CpG sites use "--mod-motif m CG 0".
    inputBinding:
      position: 102
      prefix: --mod-motif
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Directory to store output results.
    inputBinding:
      position: 102
      prefix: --output-directory
  - id: outputs
    type:
      - 'null'
      - type: array
        items: string
    doc: "Desired output(s).\n                        Options:\n                 \
      \       \tbasecalls: Called bases (FASTA/Q)\n                        \tmod_basecalls:
      Basecall-anchored modified base scores (modBAM/CRAM/SAM)\n                 \
      \       \tmappings: Mapped reads (BAM/CRAM/SAM)\n                        \t\
      per_read_variants: Per-read, per-site sequence variant scores database\n   \
      \                     \tvariants: Reference site aggregated sequence variant
      calls (VCF)\n                        \tvariant_mappings: Per-read mappings annotated
      with variant calls\n                        \tper_read_mods: Per-read, per-site
      modified base scores database\n                        \tmods: Reference site
      aggregated modified base calls (bedmethyl/modVCF/wig)\n                    \
      \    \tmod_mappings: Per-read mappings annotated with modified base calls (BAM/CRAM/SAM)\n\
      \                        \tsignal_mappings: Signal mappings for taiyaki model
      training (HDF5)\n                        \tper_read_refs: Per-read reference
      sequence for model training (FASTA)\n                        Default: ['basecalls']\n\
      \                        Note that all outputs are unsorted unless noted in
      the output filename."
      - basecalls
    inputBinding:
      position: 102
      prefix: --outputs
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite output directory if it exists.
    inputBinding:
      position: 102
      prefix: --overwrite
  - id: processes
    type:
      - 'null'
      - int
    doc: Number of parallel processes.
    inputBinding:
      position: 102
      prefix: --processes
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference FASTA or minimap2 index file used for mapping called reads.
    inputBinding:
      position: 102
      prefix: --reference
  - id: remora_modified_bases
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify the Remora per-trained modified base detection model to load. 
      Copy a row from `remora model list_pretrained`.
    inputBinding:
      position: 102
      prefix: --remora-modified-bases
  - id: rna
    type:
      - 'null'
      - boolean
    doc: 'RNA input data. Requires RNA model. Default: DNA input data'
    inputBinding:
      position: 102
      prefix: --rna
  - id: variant_filename
    type:
      - 'null'
      - File
    doc: Sequence variants to call for each read in VCF/BCF format (required for
      variant output).
    inputBinding:
      position: 102
      prefix: --variant-filename
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/megalodon:2.5.0--py311haab0aaa_4
stdout: megalodon.out
