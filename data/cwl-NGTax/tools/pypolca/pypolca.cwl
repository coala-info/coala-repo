cwlVersion: v1.2
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}

label: pypolca
doc: pypolca is a Standalone Python re-implementation of the POLCA genome polisher from the MaSuRCA genome assembly and analysis toolkit.

hints:
  SoftwareRequirement:
    packages:
      fastqc :
        version: ["0.3.1"]
        specs: ["https://anaconda.org/bioconda/pypolca", "doi.org/10.1099/mgen.0.001254"]
  DockerRequirement:
    dockerPull: quay.io/biocontainers/pypolca:0.3.1--pyhdfd78af_0

baseCommand: [ pypolca, run]

inputs:
  identifier:
    type: string
    doc: Identifier for output files.
    label: Identifier
    inputBinding:
      prefix: -p

  assembly:
    type: File
    doc: Path to assembly contigs or scaffolds.
    label: Assembly Contigs/Scaffolds
    inputBinding:
      prefix: --assembly

  forward_reads:
    type: File
    doc: Path to polishing forward reads. Can be FASTQ or FASTQ gzipped.
    label: Forward reads
    inputBinding:
      prefix: --reads1

  reverse_reads:
    type: File?
    doc: Path to polishing reverse reads. Can be FASTQ or FASTQ gzipped. Optional. Only use -1 if you have single end reads.
    label: Reverse reads
    inputBinding:
      prefix: --reads2

  threads:
    type: int?
    doc: Number of threads. Default 2
    label: Threads
    inputBinding:
      prefix: --threads
  min_alt:
    type: int
    doc: Minimum alt allele count to make a change. Default 2
    label: Minimum Alt Allele Count
    inputBinding:
      prefix: --min_alt
  min_ratio:
    type: float
    doc: Minimum alt allele to ref allele ratio to make a change.
    label: Minimum Alt Allele to Ref Allele Ratio
    inputBinding:
      prefix: --min_ratio
  careful:
    type: boolean
    doc: Equivalent to --min_alt 4 --min_ratio 3.
    label: Careful mode
    inputBinding:
      prefix: --careful
  no_polish:
    type: boolean
    doc: Do not polish, just create vcf file, evaluate the assembly and exit.
    label: Skip polishing
    inputBinding:
      prefix: -n
  memory_limit:
    type: string
    doc: Memory per thread to use in samtools sort, set to 2G or more for large genomes. default 2G
    label: Memory limit per thread
    inputBinding:
      prefix: -m

outputs:
  polished_genome:
    type: File
    outputBinding:
      glob: "output_pypolca/*.fasta"
  vcf:
    type: File
    outputBinding:
      glob: "output_pypolca/*.vcf"
  report:
    type: File
    outputBinding:
      glob: "output_pypolca/*.report"
  log:
    type: File
    outputBinding:
      glob: "output_pypolca/*.log"
  logs_dir:
    type: Directory
    outputBinding:
      glob: "output_pypolca/logs"

s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0009-0001-1350-5644
    s:email: mailto:changlin.ke@wur.nl
    s:name: Changlin Ke
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-8172-8981
    s:email: mailto:jasper.koehorst@wur.nl
    s:name: Jasper Koehorst
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9524-5964
    s:email: mailto:bart.nijsse@wur.nl
    s:name: Bart Nijsse

s:citation: https://m-unlock.nl
s:codeRepository: https://gitlab.com/m-unlock/cwl
s:dateModified: 2024-10-07
s:dateCreated: "2024-04-19"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/