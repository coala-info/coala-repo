cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - unicorn
  - taxstats
label: enhjoerning_unicorn_taxstats
doc: "Compute per taxid statistics.\n\nTool homepage: https://github.com/GeoGenetics/unicorn"
inputs:
  - id: bam
    type: File
    doc: "Input BAM or SAM file"
    inputBinding:
      position: 101
      prefix: -b
  - id: outbam
    type:
      - 'null'
      - string
    doc: "Output BAM file with filtered alignments. Used as a prefix when --filelist is provided."
    inputBinding:
      position: 101
      prefix: -o
  - id: acc2tax
    type:
      - 'null'
      - File
    doc: "Accession to taxid mapping file or .khash file. Providing a .khash file is much faster."
    inputBinding:
      position: 101
      prefix: --acc2tax
  - id: names
    type:
      - 'null'
      - File
    doc: "Taxonomy names file."
    inputBinding:
      position: 101
      prefix: --names
  - id: nodes
    type:
      - 'null'
      - File
    doc: "Taxonomy nodes file"
    inputBinding:
      position: 101
      prefix: --nodes
  - id: outstat
    type:
      - 'null'
      - string
    doc: "Output statistics file [/dev/stdout]. Used as a prefix when --filelist is provided."
    inputBinding:
      position: 101
      prefix: --outstat
  - id: minrefl
    type:
      - 'null'
      - int
    doc: "Minimum reference length. [0]"
    inputBinding:
      position: 101
      prefix: --minrefl
  - id: minreads
    type:
      - 'null'
      - int
    doc: "Minimum number of reads per taxid. [1]"
    inputBinding:
      position: 101
      prefix: --minreads
  - id: minmani
    type:
      - 'null'
      - float
    doc: "Minimum mean ANI per taxid. [0]"
    inputBinding:
      position: 101
      prefix: --minmani
  - id: minalnas
    type:
      - 'null'
      - int
    doc: "Minimum alignment score [-Inf]"
    inputBinding:
      position: 101
      prefix: --minalnas
  - id: maxdust
    type:
      - 'null'
      - int
    doc: "Maximum alignment dust score [100]"
    inputBinding:
      position: 101
      prefix: --maxdust
  - id: filelist
    type:
      - 'null'
      - File
    doc: "File containing input file paths. One per line."
    inputBinding:
      position: 101
      prefix: --filelist
  - id: rank
    type:
      - 'null'
      - string
    doc: "Taxonomic rank to summarize by. [species]"
    inputBinding:
      position: 101
      prefix: --rank
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Print libunicorn's messages."
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: "Per taxid statistics (when --outstat is not given)"
  - id: out_bam
    type:
      - 'null'
      - File
    doc: "Output BAM file with filtered alignments"
    outputBinding:
      glob: $(inputs.outbam)
  - id: out_stat
    type:
      - 'null'
      - File
    doc: Output statistics file
    outputBinding:
      glob: $(inputs.outstat)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/enhjoerning:2.4.0--h577a1d6_0
stdout: enhjoerning_unicorn_taxstats.out
