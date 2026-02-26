cwlVersion: v1.2
class: CommandLineTool
baseCommand: outrigger validate
label: outrigger_validate
doc: "Validate splice site sequences against a genome.\n\nTool homepage: https://yeolab.github.io/outrigger"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: If given, print debugging logging information to standard out
    inputBinding:
      position: 101
      prefix: --debug
  - id: fasta
    type: File
    doc: Location of the genome fasta file for which to get the splice site 
      sequences from
    inputBinding:
      position: 101
      prefix: --fasta
  - id: genome
    type: string
    doc: Either the genome name (e.g. "mm10" or "hg19") or location of the 
      genome chromosome sizes file for "bedtools flank" to make sure we do not 
      accidentally ask for genome positions that are outside of the defined 
      range
    inputBinding:
      position: 101
      prefix: --genome
  - id: index
    type:
      - 'null'
      - Directory
    doc: Name of the folder where you saved the output from "outrigger index" 
      (default is ./outrigger_output/index, which is relative to the directory 
      where you called this program, assuming you have called "outrigger psi" in
      the same folder as you called "outrigger index").
    default: ./outrigger_output/index
    inputBinding:
      position: 101
      prefix: --index
  - id: low_memory
    type:
      - 'null'
      - boolean
    doc: If set, then use a smaller memory footprint. By default, this is off.
    inputBinding:
      position: 101
      prefix: --low-memory
  - id: valid_splice_sites
    type:
      - 'null'
      - string
    doc: The intron-definition based splice sites that are allowed in the data, 
      which is in the format 5'/3' of the intron, and separated by commas for 
      different types. Default is GT/AG,GC/AG,AT/AC, which are the major and 
      minor spliceosome splice sites in mammalian systems.
    default: GT/AG,GC/AG,AT/AC
    inputBinding:
      position: 101
      prefix: --valid-splice-sites
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Name of the folder where you saved the output from "outrigger index" 
      (default is ./outrigger_output, which is relative to the directory where 
      you called the program).
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/outrigger:1.1.1--py35_0
