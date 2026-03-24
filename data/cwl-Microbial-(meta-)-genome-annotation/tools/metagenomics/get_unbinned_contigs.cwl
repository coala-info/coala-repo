#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

label: "Unbinned contigs"

doc: |
    Get unbinned contigs of the assembbly from a set of binned fasta files in fasta format.

requirements:
 - class: InlineJavascriptRequirement 

hints:
  SoftwareRequirement:
    packages:
      bash:
        version: ["5"]
  DockerRequirement:
    dockerPull: docker-registry.wur.nl/m-unlock/docker/scripts:d98a4a55

baseCommand: ["bash", "/scripts/metagenomics/get_unbinned_contigs.sh"]

inputs:
  identifier:
    type: string
    doc: Identifier for this dataset used in this workflow
    label: identifier used
    inputBinding:
      prefix: -i

  threads:
    type: int?
    label: Threads
    doc: Number of threads for compression (default; 4)
    default: 4
    inputBinding:
      prefix: -t
  
  assembly_fasta:
    type: File
    doc: fasta file that was used for the binning.
    label: assembly fasta file
    inputBinding:
      prefix: -a

  bin_dir:
    type: Directory
    doc: Folder containing bins in fasta format
    label: Bin folder
    inputBinding:
      prefix: -b
  bin_extension:
    type: string?
    doc: Extension of bin files (default; fa)
    label: Bin file extension
    default: "fa"
    inputBinding:
      prefix: -e
  compress:
    type: boolean?
    doc: Enable compression with pigz
    label: Enable compression
    inputBinding:
      prefix: -z

outputs:
  unbinned_fasta:
    type: File
    outputBinding:
      glob: $(inputs.identifier)_unbinned-contigs.*

s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9524-5964
    s:email: mailto:bart.nijsse@wur.nl
    s:name: Bart Nijsse

s:citation: https://m-unlock.nl
s:codeRepository: https://gitlab.com/m-unlock/cwl
s:dateModified: 2025-09-01
s:dateCreated: "2021-00-00"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/
