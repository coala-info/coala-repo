cwlVersion: v1.2
class: CommandLineTool
baseCommand: xpclr
label: xpclr
doc: "Tool to calculate XP-CLR as per Chen, Patterson, Reich 2010\n\nTool homepage:
  https://github.com/hardingnj/xpclr"
inputs:
  - id: chr
    type: string
    doc: Which contig analysis is based on
    inputBinding:
      position: 101
      prefix: --chr
  - id: format
    type:
      - 'null'
      - string
    doc: input expected. One of "vcf" (default), "hdf5", "zarr" or "txt"
    default: vcf
    inputBinding:
      position: 101
      prefix: --format
  - id: gdistkey
    type:
      - 'null'
      - string
    doc: key for genetic position in variants table of hdf5/VCF
    inputBinding:
      position: 101
      prefix: --gdistkey
  - id: input
    type:
      - 'null'
      - File
    doc: input file vcf or hdf5
    inputBinding:
      position: 101
      prefix: --input
  - id: ld
    type:
      - 'null'
      - float
    doc: LD cutoff to apply for weighting
    inputBinding:
      position: 101
      prefix: --ld
  - id: map
    type:
      - 'null'
      - File
    doc: If using XPCLR-style text format. Input map file as per XPCLR specs 
      (tab separated)
    inputBinding:
      position: 101
      prefix: --map
  - id: maxsnps
    type:
      - 'null'
      - int
    doc: max SNPs in a window
    inputBinding:
      position: 101
      prefix: --maxsnps
  - id: minsnps
    type:
      - 'null'
      - int
    doc: min SNPs in a window
    inputBinding:
      position: 101
      prefix: --minsnps
  - id: phased
    type:
      - 'null'
      - boolean
    doc: whether data is phased for more precise r2 calculation
    inputBinding:
      position: 101
      prefix: --phased
  - id: popa
    type:
      - 'null'
      - File
    doc: If using XPCLR-style text format. Filepath to population A genotypes 
      (space separated)
    inputBinding:
      position: 101
      prefix: --popA
  - id: popb
    type:
      - 'null'
      - File
    doc: If using XPCLR-style text format. Filepath to population B genotypes 
      (space separated)
    inputBinding:
      position: 101
      prefix: --popB
  - id: rrate
    type:
      - 'null'
      - float
    doc: recombination rate per base
    inputBinding:
      position: 101
      prefix: --rrate
  - id: samplesa
    type:
      - 'null'
      - string
    doc: Samples comprising population A. Comma separated list or path to file 
      with each ID on a line
    inputBinding:
      position: 101
      prefix: --samplesA
  - id: samplesb
    type:
      - 'null'
      - string
    doc: Samples comprising population B. Comma separated list or path to file 
      with each ID on a line
    inputBinding:
      position: 101
      prefix: --samplesB
  - id: size
    type:
      - 'null'
      - int
    doc: window size in base pairs
    inputBinding:
      position: 101
      prefix: --size
  - id: start
    type:
      - 'null'
      - int
    doc: start base position for windows
    inputBinding:
      position: 101
      prefix: --start
  - id: step
    type:
      - 'null'
      - int
    doc: step size for sliding windows
    inputBinding:
      position: 101
      prefix: --step
  - id: stop
    type:
      - 'null'
      - int
    doc: stop base position for windows
    inputBinding:
      position: 101
      prefix: --stop
  - id: verbose
    type:
      - 'null'
      - int
    doc: How verbose to be in logging. 10=DEBUG, 20=INFO, 30=WARN, 40=ERROR, 
      50=CRITICAL
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: out
    type: File
    doc: output file
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xpclr:1.1.2--py_0
