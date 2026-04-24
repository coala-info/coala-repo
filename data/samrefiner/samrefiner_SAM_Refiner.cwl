cwlVersion: v1.2
class: CommandLineTool
baseCommand: SAM_Refiner
label: samrefiner_SAM_Refiner
doc: "process Sam files for variant information\n\nTool homepage: https://github.com/degregory/SAM_Refiner"
inputs:
  - id: AAcentered
    type:
      - 'null'
      - boolean
    doc: Enable/Disable (1/0) amino acid centered seq and covar outputs for .gb 
      processing (--AAcentered 0), requires AAreport enabled
    inputBinding:
      position: 101
      prefix: --AAcentered
  - id: AAcodonasMNP
    type:
      - 'null'
      - boolean
    doc: Enable/Disable (1/0) reporting multiple nt changes in a single codon as
      one polymorphism, default enabled (--AAcodonasMNP 1), requires AAreport 
      enabled
    inputBinding:
      position: 101
      prefix: --AAcodonasMNP
  - id: AAreport
    type:
      - 'null'
      - boolean
    doc: Enable/Disable (1/0) amino acid reporting, default enabled (--AAreport 
      1)
    inputBinding:
      position: 101
      prefix: --AAreport
  - id: alpha
    type:
      - 'null'
      - float
    doc: Modifier for chim_rm chimera checking, default 1.2. Higher = more 
      sensitive, more false chimeras removed; lower = less sensitive, fewer 
      chimeras removed
    inputBinding:
      position: 101
      prefix: --alpha
  - id: autopass
    type:
      - 'null'
      - float
    doc: 'threshold for a sequence to automatically pass the covar pass checking (default:
      0.3)'
    inputBinding:
      position: 101
      prefix: --autopass
  - id: beta
    type:
      - 'null'
      - float
    doc: Modifier for covar pass checking, default 1. Higher = more sensitive, 
      more failed checks; lower = less sensitive, fewer failed checks
    inputBinding:
      position: 101
      prefix: --beta
  - id: chim_in_abund
    type:
      - 'null'
      - float
    doc: 'Minimum abundance a unique sequence must have to be considered in chimera
      removal / deconvolution (default: .001)'
    inputBinding:
      position: 101
      prefix: --chim_in_abund
  - id: chim_rm
    type:
      - 'null'
      - boolean
    doc: Enable/Disable (1/0) chim_rm output, default enabled (--chim_rm 1)
    inputBinding:
      position: 101
      prefix: --chim_rm
  - id: colID
    type:
      - 'null'
      - string
    doc: ID to prepend collections
    inputBinding:
      position: 101
      prefix: --colID
  - id: collect
    type:
      - 'null'
      - boolean
    doc: Enable/Disable (1/0) collection step, default enabled (--collect 1)
    inputBinding:
      position: 101
      prefix: --collect
  - id: covar
    type:
      - 'null'
      - boolean
    doc: Enable/Disable (1/0) covar output, default enabled (--covar 1)
    inputBinding:
      position: 101
      prefix: --covar
  - id: covar_tile_coverage
    type:
      - 'null'
      - boolean
    doc: 'Enable/Disable (1/0) using tiles covering positions instead of minimum nt
      coverage to calculate abundance of covariants (--covar_tile_coverage), require
      --wgs 1 (default: 0)'
    inputBinding:
      position: 101
      prefix: --covar_tile_coverage
  - id: deconv
    type:
      - 'null'
      - boolean
    doc: Enable/Disable (1/0) covar deconv, default enabled (--deconv 1)
    inputBinding:
      position: 101
      prefix: --deconv
  - id: foldab
    type:
      - 'null'
      - float
    doc: Threshold for potential parent / chimera abundance ratio for chim_rm; 
      default is 1.8
    inputBinding:
      position: 101
      prefix: --foldab
  - id: indel
    type:
      - 'null'
      - boolean
    doc: Enable/Disable (1/0) indel output, default enabled (--indel 1)
    inputBinding:
      position: 101
      prefix: --indel
  - id: max_covar
    type:
      - 'null'
      - int
    doc: 'Maximum number of variances from the reference to be reported in covars
      (default: 8)'
    inputBinding:
      position: 101
      prefix: --max_covar
  - id: max_cycles
    type:
      - 'null'
      - int
    doc: Max number of times chimera removal will be performed for chim_rm; 
      default is 100
    inputBinding:
      position: 101
      prefix: --max_cycles
  - id: max_dist
    type:
      - 'null'
      - int
    doc: 'Maximum number of variances from the reference a sequence can have to be
      consider in covars processing (default: 40)'
    inputBinding:
      position: 101
      prefix: --max_dist
  - id: min_col_abund
    type:
      - 'null'
      - float
    doc: 'Minimum abundance required for variants to be included in collection reports;
      must be non-negative and < 1, % observed (.1 = 10%), (default: .01)'
    inputBinding:
      position: 101
      prefix: --min_col_abund
  - id: min_count
    type:
      - 'null'
      - float
    doc: 'Minimum observations required to be included in sample reports; >= 1 occurance
      count; < 1 % observed (.1 = 10%), (default: .001)'
    inputBinding:
      position: 101
      prefix: --min_count
  - id: min_samp_abund
    type:
      - 'null'
      - float
    doc: 'Minimum abundance required for inclusion in sample reports; % observed (.1
      = 10%), (default: .001)'
    inputBinding:
      position: 101
      prefix: --min_samp_abund
  - id: mp
    type:
      - 'null'
      - int
    doc: set number of processes SAM Refiner will run in parallel, default = 4 
      (--mp 4)
    inputBinding:
      position: 101
      prefix: --mp
  - id: nt_call
    type:
      - 'null'
      - boolean
    doc: Enable/Disable (1/0) nt_call output, default enabled (--nt_call 1)
    inputBinding:
      position: 101
      prefix: --nt_call
  - id: ntabund
    type:
      - 'null'
      - float
    doc: 'Minimum abundance relative to total reads required for a position to be
      reported in the nt call output; must be non-negative and < 1, % observed (.1
      = 10%), (default: .001)'
    inputBinding:
      position: 101
      prefix: --ntabund
  - id: ntcover
    type:
      - 'null'
      - int
    doc: 'Minimum coverage at a position to be reported in the nt call output. (default:
      5)'
    inputBinding:
      position: 101
      prefix: --ntcover
  - id: ntvar
    type:
      - 'null'
      - boolean
    doc: Enable/Disable (1/0) nt_call output, default enabled (--ntvar 1)
    inputBinding:
      position: 101
      prefix: --ntvar
  - id: pass_out
    type:
      - 'null'
      - boolean
    doc: Enable/Disable (1/0) covar_pass output, default disabled (--pass_out 0)
    inputBinding:
      position: 101
      prefix: --pass_out
  - id: read
    type:
      - 'null'
      - boolean
    doc: Enable/Disable (1/0) reads output, default disabled (--read 0)
    inputBinding:
      position: 101
      prefix: --read
  - id: redist
    type:
      - 'null'
      - boolean
    doc: Enable/Disable (1/0) redistribution of chimera counts for chim_rm, 
      default enabled (--redist 1)
    inputBinding:
      position: 101
      prefix: --redist
  - id: reference
    type:
      - 'null'
      - File
    doc: reference fasta or genbank file. Only chimera removal and collections 
      will be performed if omitted.
    inputBinding:
      position: 101
      prefix: -reference
  - id: sam_files
    type:
      - 'null'
      - type: array
        items: File
    doc: optional .sam files, can use multiple files i.e. "-S Sample1.sam -S 
      Sample2.sam" or "-S Sample1.sam Sample2.sam"
    inputBinding:
      position: 101
      prefix: --Sam_files
  - id: seq
    type:
      - 'null'
      - boolean
    doc: Enable/Disable (1/0) unique seq output, default enabled (--seq 1)
    inputBinding:
      position: 101
      prefix: --seq
  - id: use_count
    type:
      - 'null'
      - boolean
    doc: Enable/Disable (1/0) use of counts in sequence IDs, default enabled 
      (--use_count 1)
    inputBinding:
      position: 101
      prefix: --use_count
  - id: wgs
    type:
      - 'null'
      - boolean
    doc: Enable/Disable (1/0) covar deconv, default enabled (--wgs 1)
    inputBinding:
      position: 101
      prefix: --wgs
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samrefiner:1.4.2.1--pyhdfd78af_0
stdout: samrefiner_SAM_Refiner.out
