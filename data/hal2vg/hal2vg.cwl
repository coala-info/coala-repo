cwlVersion: v1.2
class: CommandLineTool
baseCommand: hal2vg
label: hal2vg
doc: "hal2vg v2.2: Convert HAL alignment to handle graph\n\nTool homepage: https://github.com/ComparativeGenomicsToolkit/hal2vg"
inputs:
  - id: hal_path
    type: File
    doc: input hal file
    inputBinding:
      position: 1
  - id: chop
    type:
      - 'null'
      - int
    doc: chop up nodes in output graph so they are not longer than given length [default = 0]
    inputBinding:
      position: 102
      prefix: --chop
  - id: format
    type:
      - 'null'
      - string
    doc: choose the back-end storage format. [default = hdf5]
    inputBinding:
      position: 102
      prefix: --format
  - id: hdf5_cache_bytes
    type:
      - 'null'
      - int
    doc: maximum size in bytes of regular hdf5 cache [default = 1048576]
    inputBinding:
      position: 102
      prefix: --hdf5CacheBytes
  - id: hdf5_cache_mdc
    type:
      - 'null'
      - int
    doc: number of metadata slots in hdf5 cache [default = 113]
    inputBinding:
      position: 102
      prefix: --hdf5CacheMDC
  - id: hdf5_cache_rdc
    type:
      - 'null'
      - int
    doc: number of regular slots in hdf5 cache. should be a prime number ~= 10 * DefaultCacheRDCBytes / chunk [default = 521]
    inputBinding:
      position: 102
      prefix: --hdf5CacheRDC
  - id: hdf5_cache_w0
    type:
      - 'null'
      - float
    doc: w0 parameter for hdf5 cache [default = 0.75]
    inputBinding:
      position: 102
      prefix: --hdf5CacheW0
  - id: hdf5_in_memory
    type:
      - 'null'
      - boolean
    doc: load all data in memory (and disable hdf5 cache) [default = 0]
    inputBinding:
      position: 102
      prefix: --hdf5InMemory
  - id: ignore_genomes
    type:
      - 'null'
      - type: array
        items: string
    doc: comma-separated (no spaces) list of genomes to ignore [default = ""]
    inputBinding:
      position: 102
      prefix: --ignoreGenomes
      itemSeparator: ','
  - id: no_ancestors
    type:
      - 'null'
      - boolean
    doc: don't write ancestral paths, nor sequence exclusive to ancestral genomes [default = 0]
    inputBinding:
      position: 102
      prefix: --noAncestors
  - id: output_format
    type:
      - 'null'
      - string
    doc: output graph format in {pg, hg} [default=pg]
    inputBinding:
      position: 102
      prefix: --outputFormat
  - id: progress
    type:
      - 'null'
      - boolean
    doc: show progress [default = 0]
    inputBinding:
      position: 102
      prefix: --progress
  - id: ref_genomes
    type:
      - 'null'
      - type: array
        items: string
    doc: comma-separated (no spaces) genomes to treat as reference paths with all others as haplotype paths (default=all genomes) [default = ""]
    inputBinding:
      position: 102
      prefix: --refGenomes
      itemSeparator: ','
  - id: root_genome
    type:
      - 'null'
      - string
    doc: process only genomes in clade with specified root (HAL root if empty) [default = ""]
    inputBinding:
      position: 102
      prefix: --rootGenome
  - id: target_genomes
    type:
      - 'null'
      - type: array
        items: string
    doc: comma-separated (no spaces) list of target genomes (others are excluded) (all leaves if empty) [default = ""]
    inputBinding:
      position: 102
      prefix: --targetGenomes
      itemSeparator: ','
outputs:
  - id: stdout
    type: stdout
    doc: Output handle graph (written to standard output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hal2vg:1.1.8--hee927d3_0
stdout: hal2vg.out
