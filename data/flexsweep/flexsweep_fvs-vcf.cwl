cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - flexsweep
  - fvs-vcf
label: flexsweep_fvs-vcf
doc: "Estimate summary statistics from VCF files and build feature vectors.\n\nTool
  homepage: https://github.com/jmurga/flexsweep"
inputs:
  - id: nthreads
    type: int
    doc: Number of threads for parallelization
    inputBinding:
      position: 101
      prefix: --nthreads
  - id: pop
    type:
      - 'null'
      - string
    doc: Population ID
    inputBinding:
      position: 101
      prefix: --pop
  - id: recombination_map
    type:
      - 'null'
      - File
    doc: 'Recombination map. Decode CSV format: Chr,Begin,End,cMperMb,cM'
    inputBinding:
      position: 101
      prefix: --recombination_map
  - id: vcf_path
    type: Directory
    doc: Directory containing vcfs folder with all the VCF files to analyze.
    inputBinding:
      position: 101
      prefix: --vcf_path
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flexsweep:1.3--pyhdfd78af_0
stdout: flexsweep_fvs-vcf.out
