cwlVersion: v1.2
class: CommandLineTool
baseCommand: vireo
label: vireosnp_vireo
doc: "vireo\n\nTool homepage: https://github.com/huangyh09/vireoSNP"
inputs:
  - id: ase_mode
    type:
      - 'null'
      - boolean
    doc: If use, turn on SNP specific allelic ratio.
    inputBinding:
      position: 101
      prefix: --ASEmode
  - id: call_ambient_RNAs
    type:
      - 'null'
      - boolean
    doc: If use, detect ambient RNAs in each cell (under development)
    inputBinding:
      position: 101
      prefix: --callAmbientRNAs
  - id: cell_data
    type:
      - 'null'
      - string
    doc: The cell genotype file in VCF format or cellSNP folder with sparse 
      matrices.
    inputBinding:
      position: 101
      prefix: --cellData
  - id: cell_range
    type:
      - 'null'
      - string
    doc: Range of cells to process, eg. 0-10000
    default: all
    inputBinding:
      position: 101
      prefix: --cellRange
  - id: donor_file
    type:
      - 'null'
      - File
    doc: The donor genotype file in VCF format. Please filter the sample and 
      region with bcftools -s and -R first!
    inputBinding:
      position: 101
      prefix: --donorFile
  - id: extra_donor
    type:
      - 'null'
      - int
    doc: Number of extra donor in pre-cluster, when GT needs to learn
    default: 0
    inputBinding:
      position: 101
      prefix: --extraDonor
  - id: extra_donor_mode
    type:
      - 'null'
      - string
    doc: 'Method for searching from extra donors. size: n_cell per donor; distance:
      GT distance between donors'
    default: distance
    inputBinding:
      position: 101
      prefix: --extraDonorMode
  - id: force_learn_gt
    type:
      - 'null'
      - boolean
    doc: If use, treat donor GT as prior only.
    inputBinding:
      position: 101
      prefix: --forceLearnGT
  - id: geno_tag
    type:
      - 'null'
      - string
    doc: 'The tag for donor genotype: GT, GP, PL'
    default: PL
    inputBinding:
      position: 101
      prefix: --genoTag
  - id: n_donor
    type:
      - 'null'
      - int
    doc: Number of donors to demultiplex; can be larger than provided in 
      donor_file
    inputBinding:
      position: 101
      prefix: --nDonor
  - id: n_init
    type:
      - 'null'
      - int
    doc: Number of random initializations, when GT needs to learn
    default: 50
    inputBinding:
      position: 101
      prefix: --nInit
  - id: no_doublet
    type:
      - 'null'
      - boolean
    doc: If use, not checking doublets.
    inputBinding:
      position: 101
      prefix: --noDoublet
  - id: no_plot
    type:
      - 'null'
      - boolean
    doc: If use, turn off plotting GT distance.
    inputBinding:
      position: 101
      prefix: --noPlot
  - id: nproc
    type:
      - 'null'
      - int
    doc: Number of subprocesses for computing - this sacrifices memory for 
      speedups
    default: 1
    inputBinding:
      position: 101
      prefix: --nproc
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Dirtectory for output files
    default: $cellFilePath/vireo
    inputBinding:
      position: 101
      prefix: --outDir
  - id: rand_seed
    type:
      - 'null'
      - int
    doc: Seed for random initialization
    inputBinding:
      position: 101
      prefix: --randSeed
  - id: vartrix_data
    type:
      - 'null'
      - string
    doc: 'The cell genotype files in vartrix outputs (three/four files, comma separated):
      alt.mtx,ref.mtx,barcodes.tsv,SNPs.vcf.gz. This will suppress cellData argument.'
    inputBinding:
      position: 101
      prefix: --vartrixData
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vireosnp:0.5.9--pyh7e72e81_0
stdout: vireosnp_vireo.out
