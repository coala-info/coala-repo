cwlVersion: v1.2
class: CommandLineTool
baseCommand: chromograph
label: chromograph
doc: "Chromograph plots genomic data (coverage, autozygosity, homozygous SNP fraction,
  ideograms, UPD regions and sites) on chromosomes as PNG images. At least one operation
  input is needed.\n\nTool homepage: https://github.com/Clinical-Genomics/chromograph"
inputs:
  - id: autozyg
    type: ['null', File]
    doc: Plot regions of autozygosity from bed file [OPERATION]
    inputBinding:
      position: 1
      prefix: --autozyg
  - id: coverage
    type: ['null', File]
    doc: Plot coverage from fixed step wig file [OPERATION]
    inputBinding:
      position: 1
      prefix: --coverage
  - id: fracsnp
    type: ['null', File]
    doc: Plot fraction of homozygous SNPs from wig file [OPERATION]
    inputBinding:
      position: 1
      prefix: --fracsnp
  - id: ideogram
    type: ['null', File]
    doc: Plot ideograms from bed-file on format ['chrom', 'start', 'end', 'name', 
      'gStain'] [OPERATION]
    inputBinding:
      position: 1
      prefix: --ideogram
  - id: exom
    type: ['null', File]
    doc: Plot exom coverage from bed file [OPERATION]
    inputBinding:
      position: 1
      prefix: --exom
  - id: regions
    type: ['null', File]
    doc: Plot UPD regions from bed file [OPERATION]
    inputBinding:
      position: 1
      prefix: --regions
  - id: sites
    type: ['null', File]
    doc: Plot UPD sites from bed file [OPERATION]
    inputBinding:
      position: 1
      prefix: --sites
  - id: step
    type: ['null', int]
    doc: fixed step size (default 5000)
    inputBinding:
      position: 1
      prefix: --step
  - id: outd
    type: string
    doc: output dir (without it, plots are written beside the input file)
    default: chromograph_out
    inputBinding:
      position: 1
      prefix: --outd
  - id: euploid
    type: ['null', boolean]
    doc: Always output an euploid amount of files -even if some are empty
    inputBinding:
      position: 1
      prefix: --euploid
  - id: rgb
    type: ['null', string]
    doc: Set color (RGB hex, only with --coverage option)
    inputBinding:
      position: 1
      prefix: --rgb
  - id: norm
    type: ['null', boolean]
    doc: Normalize data (wig/coverage)
    inputBinding:
      position: 1
      prefix: --norm
  - id: chunk
    type: ['null', int]
    doc: Set Matplotlib.agg.path.chunksize (default 10000)
    inputBinding:
      position: 1
      prefix: --chunk
  - id: combine
    type: ['null', boolean]
    doc: Write all graphs to one file (default one plot per file)
    inputBinding:
      position: 1
      prefix: --combine
  - id: small
    type: ['null', boolean]
    doc: Small image resolution
    inputBinding:
      position: 1
      prefix: --small
  - id: medium
    type: ['null', boolean]
    doc: Medium image resolution
    inputBinding:
      position: 1
      prefix: --medium
  - id: large
    type: ['null', boolean]
    doc: Large image resolution
    inputBinding:
      position: 1
      prefix: --large
outputs:
  - id: outdir
    type: Directory
    doc: Output directory with the PNG plots
    outputBinding:
      glob: $(inputs.outd)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chromograph:1.3.1--pyhdfd78af_2
