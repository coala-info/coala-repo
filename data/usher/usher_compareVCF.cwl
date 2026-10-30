cwlVersion: v1.2
class: CommandLineTool
baseCommand: compareVCF
label: usher_compareVCF
doc: 'compareVCF: compares the genotypes of the samples in two VCF files (plain or
  gzip-compressed) and reports differences.


  Tool homepage: https://github.com/yatisht/usher'
inputs:
- id: vcf_1
  type: File
  doc: First VCF file (file1.vcf[.gz]).
  inputBinding:
    position: 1
- id: vcf_2
  type: File
  doc: Second VCF file (file2.vcf[.gz]).
  inputBinding:
    position: 2
outputs:
- id: missing_samples
  type: stdout
  doc: 'Standard output: samples missing in one of the files.'
- id: differences
  type: stderr
  doc: 'Standard error: differing genotypes (At <position> , sample <name> ...) and
    the finished message.'
stdout: compareVCF_stdout.txt
stderr: compareVCF_stderr.txt
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/usher:0.6.6--hdd55de9_4
