cwlVersion: v1.2

class: ExpressionTool

doc: Determines the final outputs of the reference file.

requirements:
 - class: InlineJavascriptRequirement

inputs:
  merged_genbank: File?
  merged_fasta: File?
  fetched_reference: File?
  original_reference: File?
  extracted_fasta: File?

outputs:
  genbank:
    type: File
  fasta:
    type: File?

expression: |
  ${
    return {
      genbank: inputs.merged_genbank || inputs.fetched_reference || inputs.original_reference,
      fasta: inputs.merged_fasta || inputs.extracted_fasta || null
    };
  }

$namespaces:
  s: https://schema.org/
s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0009-0005-0017-0928
    s:email: mailto:martijn.melissen@wur.nl
    s:name: Martijn Melissen
s:citation: https://m-unlock.nl
s:codeRepository: https://gitlab.com/m-unlock/cwl
s:dateCreated: "2025-04-17"
s:dateModified: "2025-04-17"
s:license: https://spdx.org/licenses/Apache-2.0
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"