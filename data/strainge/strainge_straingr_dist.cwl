cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- straingr
- dist
label: strainge_straingr_dist
doc: 'Calculate the pairwise genetic distance between strains close to the same reference genome across samples, output as a matrix.


  Tool homepage: https://github.com/broadinstitute/strainge'
inputs:
- id: samples
  type: File[]
  doc: StrainGR call data HDF5 file for each sample.
  inputBinding:
    position: 100
- id: reference
  type:
  - 'null'
  - File
  doc: Analyze strains across samples close to this reference genome
  inputBinding:
    position: 1
    prefix: --reference
- id: dist_correction
  type:
  - 'null'
  - string
  doc: Genetic distance correction method, either Jukes Cantor (jc) or Kimura's two parameter model (kimura). If none given, then the SNP rate is used as distance.
  inputBinding:
    position: 1
    prefix: --dist-correction
- id: min_callable
  type:
  - 'null'
  - float
  doc: Minimum percentage of callable genome to consider a strain for comparison. Default 0.5%.
  inputBinding:
    position: 1
    prefix: --min-callable
- id: min_abundance
  type:
  - 'null'
  - float
  doc: Minimum abundance fraction of this strain in a sample. Default 0.01.
  inputBinding:
    position: 1
    prefix: --min-abundance
- id: processes
  type:
  - 'null'
  - int
  doc: Number of parallel processes to start. Default 2.
  inputBinding:
    position: 1
    prefix: --processes
- id: output
  type:
  - 'null'
  - string
  doc: Output filename. Defaults to stdout.
  inputBinding:
    position: 1
    prefix: --output
outputs:
- id: output_result
  type:
  - 'null'
  - File
  doc: Output filename. Defaults to stdout.
  outputBinding:
    glob: $(inputs.output)
- id: stdout
  type: stdout
  doc: Standard output
stdout: strainge_straingr_dist.stdout.txt
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
