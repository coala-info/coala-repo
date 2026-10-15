cwlVersion: v1.2
class: CommandLineTool
baseCommand: primerForge
label: primerforge_primerForge
doc: "Finds pairs of primers suitable for a group of input genomes\n\nTool homepage: https://github.com/dr-joe-wirth/primerForge"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - '$(inputs.ingroup.map(function(f){ return {"entry": f, "entryname": "ingroup/" + f.basename}; }))'
      - '$(inputs.outgroup ? inputs.outgroup.map(function(f){ return {"entry": f, "entryname": "outgroup/" + f.basename}; }) : [])'
inputs:
  - id: ingroup
    type:
      type: array
      items: File
    doc: "ingroup genome files (staged in one folder and passed to primerForge as a file pattern)"
    inputBinding:
      position: 1
      prefix: --ingroup
      valueFrom: ingroup/*
  - id: outgroup
    type:
      - 'null'
      - type: array
        items: File
    doc: "outgroup genome files (staged in one folder and passed to primerForge as a file pattern)"
    inputBinding:
      position: 1
      prefix: --outgroup
      valueFrom: outgroup/*
  - id: bad_sizes
    type:
      - 'null'
      - type: array
        items: int
    doc: "a range of PCR product lengths that the outgroup cannot produce (min,max)"
    inputBinding:
      position: 1
      prefix: --bad_sizes
      itemSeparator: ','
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "run in debug mode"
    inputBinding:
      position: 1
      prefix: --debug
  - id: format
    type:
      - 'null'
      - string
    doc: "file format of the ingroup and outgroup [genbank|fasta]"
    inputBinding:
      position: 1
      prefix: --format
  - id: gc_range
    type:
      - 'null'
      - type: array
        items: float
    doc: "a min and max percent GC specified as a comma separated list"
    inputBinding:
      position: 1
      prefix: --gc_range
      itemSeparator: ','
  - id: keep
    type:
      - 'null'
      - boolean
    doc: "keep intermediate files"
    inputBinding:
      position: 1
      prefix: --keep
  - id: num_threads
    type:
      - 'null'
      - int
    doc: "the number of threads for parallel processing"
    inputBinding:
      position: 1
      prefix: --num_threads
  - id: pcr_prod
    type:
      - 'null'
      - type: array
        items: int
    doc: "a single PCR product length or a range specified as 'min,max'"
    inputBinding:
      position: 1
      prefix: --pcr_prod
      itemSeparator: ','
  - id: primer_len
    type:
      - 'null'
      - type: array
        items: int
    doc: "a single primer length or a range specified as 'min,max'; (minimum 10)"
    inputBinding:
      position: 1
      prefix: --primer_len
      itemSeparator: ','
  - id: tm_diff
    type:
      - 'null'
      - float
    doc: "the maximum allowable Tm difference (deg C) between a pair of primers"
    inputBinding:
      position: 1
      prefix: --tm_diff
  - id: tm_range
    type:
      - 'null'
      - type: array
        items: float
    doc: "a min and max melting temp (deg C) specified as a comma separated list"
    inputBinding:
      position: 1
      prefix: --tm_range
      itemSeparator: ','
  - id: primer3_mv_conc
    type:
      - 'null'
      - float
    doc: "monovalent cation concentration (mM)"
    inputBinding:
      position: 1
      prefix: --primer3_mv_conc
  - id: primer3_dv_conc
    type:
      - 'null'
      - float
    doc: "divalent cation concentration (mM)"
    inputBinding:
      position: 1
      prefix: --primer3_dv_conc
  - id: primer3_dntp_conc
    type:
      - 'null'
      - float
    doc: "dNTP concentration (mM)"
    inputBinding:
      position: 1
      prefix: --primer3_dntp_conc
  - id: primer3_dna_conc
    type:
      - 'null'
      - float
    doc: "template DNA concentration (nM)"
    inputBinding:
      position: 1
      prefix: --primer3_dna_conc
  - id: primer3_temp_c
    type:
      - 'null'
      - float
    doc: "simulation temp (deg C) for delta G"
    inputBinding:
      position: 1
      prefix: --primer3_temp_c
  - id: primer3_max_loop
    type:
      - 'null'
      - int
    doc: "maximum size (bp) of loops in primer secondary structures"
    inputBinding:
      position: 1
      prefix: --primer3_max_loop
  - id: is_pcr_min_good
    type:
      - 'null'
      - int
    doc: "minimum size (bp) where there must be 2 matches for each mismatch"
    inputBinding:
      position: 1
      prefix: --isPcr_minGood
  - id: is_pcr_min_perfect
    type:
      - 'null'
      - int
    doc: "minimum size (bp) of perfect match at 3' end of primer"
    inputBinding:
      position: 1
      prefix: --isPcr_minPerfect
  - id: is_pcr_tile_size
    type:
      - 'null'
      - int
    doc: "the size of match that triggers an alignment"
    inputBinding:
      position: 1
      prefix: --isPcr_tileSize
  - id: temp_tolerance
    type:
      - 'null'
      - float
    doc: "minimum number of degrees below primer Tm allowed for secondary structure Tm"
    inputBinding:
      position: 1
      prefix: --temp_tolerance
  - id: max_repeats
    type:
      - 'null'
      - int
    doc: "maximum allowed length (bp) of homopolymers (repeats) in primer sequences"
    inputBinding:
      position: 1
      prefix: --max_repeats
  - id: bin_size
    type:
      - 'null'
      - int
    doc: "maximum allowed length (bp) of contiguous regions of overlapping primers (bins)"
    inputBinding:
      position: 1
      prefix: --bin_size
  - id: out_path
    type: string
    default: results.tsv
    doc: "output filename for primer pair data"
    inputBinding:
      position: 1
      prefix: --out
  - id: bed_file_path
    type: string
    default: primers.bed
    doc: "output filename for primer data in BED file format"
    inputBinding:
      position: 1
      prefix: --bed_file
outputs:
  - id: out
    type: File
    doc: output filename for primer pair data
    outputBinding:
      glob: $(inputs.out_path)
  - id: bed_file
    type: File
    doc: output filename for primer data in BED file format
    outputBinding:
      glob: $(inputs.bed_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/primerforge:1.5.3--pyhdfd78af_0
