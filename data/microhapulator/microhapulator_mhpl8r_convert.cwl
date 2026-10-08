cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mhpl8r
  - convert
label: microhapulator_mhpl8r_convert
doc: "Convert a typing result to a format compatible with probabilistic genotyping software applications\n\nTool homepage: https://github.com/bioforensics/MicroHapulator/"
inputs:
  - id: out
    type: string
    doc: "write output to 'FILE'; by default, output is written to the terminal (standard output)"
    default: "converted.csv"
    inputBinding:
      position: 1
      prefix: --out
  - id: no_counts
    type: ['null', boolean]
    doc: "do not include haplotype counts if you are interpreting your data with a semi-continuous probgen model such as LRMix Studio; by default, haplotype counts are included for interpretation with fully continuous probgen model such as EuroForMix"
    inputBinding:
      position: 1
      prefix: --no-counts
  - id: fix_homo
    type: ['null', boolean]
    doc: "duplicate a homozygous haplotype so that it is reported twice"
    inputBinding:
      position: 1
      prefix: --fix-homo
  - id: result
    type: File
    doc: "filtered MicroHapulator typing result in JSON format"
    inputBinding:
      position: 2
  - id: sample
    type: string
    doc: "sample name"
    inputBinding:
      position: 3
outputs:
  - id: output_file
    type: File
    doc: "Profile table in CSV format for probabilistic genotyping software"
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/microhapulator:0.8.4--pyhdfd78af_0
