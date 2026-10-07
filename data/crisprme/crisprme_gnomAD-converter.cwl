cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - crisprme.py
  - gnomAD-converter
label: crisprme_gnomAD-converter
doc: "Converts gnomAD VCFs (versions 3.1 and 4.0) into VCFs supported by CRISPRme,
  using a precomputed sample IDs file. Converted VCFs are written beside the inputs,
  so the VCF folder is staged writable in the working directory.\n\nTool homepage:
  https://github.com/samuelecancellieri/CRISPRme"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.gnomad_vcfdir)
        writable: true
inputs:
  - id: gnomad_vcfdir
    type: Directory
    doc: Directory containing gnomAD VCFs. Files must have the BGZ extension
    inputBinding:
      position: 1
      prefix: --gnomAD_VCFdir
      valueFrom: $(self.basename)
  - id: samples_id
    type: File
    doc: Precomputed sample IDs file necessary for incorporating 
      population-specific information into the output VCFs
    inputBinding:
      position: 1
      prefix: --samplesID
  - id: joint
    type:
      - 'null'
      - boolean
    doc: The input gnomAD VCFs contain joint allele frequencies
    inputBinding:
      position: 1
      prefix: --joint
  - id: keep
    type:
      - 'null'
      - boolean
    doc: Retain all variants, regardless of their filter flag. By default, 
      variants with a filter flag different from PASS are discarded
    inputBinding:
      position: 1
      prefix: --keep
  - id: multiallelic
    type:
      - 'null'
      - boolean
    doc: Merge variants mapped to the same position, creating multiallelic sites
      in the output VCFs. By default, each site remains biallelic
    inputBinding:
      position: 1
      prefix: --multiallelic
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads used in the conversion process [default 8]. The help
      spells it --thread, but crisprme.py reads --threads
    inputBinding:
      position: 1
      prefix: --threads
outputs:
  - id: converted_vcfs
    type:
      type: array
      items: File
    doc: CRISPRme-compatible VCFs
    outputBinding:
      glob: $(inputs.gnomad_vcfdir.basename)/*.vcf.gz
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crisprme:2.1.9--py38hdfd78af_0
