cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - akt
  - pca
label: akt_pca
doc: "Performs principal component analysis on a vcf/bcf\n\nTool homepage: https://github.com/Illumina/akt"
inputs:
  - id: input_file
    type: File
    doc: Input vcf/bcf file
    secondaryFiles:
      - pattern: .csi
        required: false
      - pattern: .tbi
        required: false
    inputBinding:
      position: 1
  - id: alg
    type:
      - 'null'
      - boolean
    doc: exact SVD (slow)
    inputBinding:
      position: 102
      prefix: --alg
  - id: assume_homref
    type:
      - 'null'
      - boolean
    doc: Assume missing genotypes/sites are homozygous reference (useful for 
      projecting a single sample)
    inputBinding:
      position: 102
      prefix: --assume-homref
  - id: covdef
    type:
      - 'null'
      - int
    doc: 'definition of SVD matrix: 0=(G-mu) 1=(G-mu)/sqrt(p(1-p)) 2=diag-G(2-G) default(1)'
    inputBinding:
      position: 102
      prefix: --covdef
  - id: extra
    type:
      - 'null'
      - int
    doc: extra vectors for Red SVD
    inputBinding:
      position: 102
      prefix: --extra
  - id: force
    type:
      - 'null'
      - boolean
    doc: run pca without -R/-T/-F
    inputBinding:
      position: 102
      prefix: --force
  - id: iterations
    type:
      - 'null'
      - int
    doc: number of power iterations (default 10 is sufficient)
    inputBinding:
      position: 102
      prefix: --iterations
  - id: npca
    type:
      - 'null'
      - int
    doc: first N principle components
    inputBinding:
      position: 102
      prefix: --npca
  - id: output_format
    type:
      - 'null'
      - string
    doc: output vcf format (htslib mode letter, e.g. z for compressed VCF, b for
      BCF)
    inputBinding:
      position: 102
      prefix: -O
  - id: regions
    type:
      - 'null'
      - string
    doc: chromosome region
    inputBinding:
      position: 102
      prefix: --regions
  - id: regions_file
    type:
      - 'null'
      - File
    doc: restrict to regions listed in a file
    inputBinding:
      position: 102
      prefix: --regions-file
  - id: samples
    type:
      - 'null'
      - string
    doc: list of samples
    inputBinding:
      position: 102
      prefix: --samples
  - id: samples_file
    type:
      - 'null'
      - File
    doc: list of samples, file
    inputBinding:
      position: 102
      prefix: --samples-file
  - id: svfile
    type:
      - 'null'
      - string
    doc: Output file name for the singular values
    inputBinding:
      position: 102
      prefix: -F
  - id: targets
    type:
      - 'null'
      - string
    doc: similar to -r but streams rather than index-jumps
    inputBinding:
      position: 102
      prefix: --targets
  - id: targets_file
    type:
      - 'null'
      - File
    doc: similar to -R but streams rather than index-jumps
    inputBinding:
      position: 102
      prefix: --targets-file
  - id: weight
    type:
      - 'null'
      - File
    doc: VCF with weights for PCA
    inputBinding:
      position: 102
      prefix: --weight
  - id: output_path
    type:
      - 'null'
      - string
    doc: output vcf (site weights / PCA coefficients)
    inputBinding:
      position: 103
      prefix: -o
outputs:
  - id: projections
    type: stdout
    doc: Principal component projections of each sample
  - id: singular_values
    type:
      - 'null'
      - File
    doc: Singular values
    outputBinding:
      glob: $(inputs.svfile)
  - id: output
    type:
      - 'null'
      - File
    doc: output vcf
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/akt:0.3.3--h5ca1c30_7
stdout: akt_pca.out
