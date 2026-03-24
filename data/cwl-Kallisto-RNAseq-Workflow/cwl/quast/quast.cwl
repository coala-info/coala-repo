#!/usr/bin/env cwltool

cwlVersion: v1.2
class: CommandLineTool

# hints:
#   SoftwareRequirement:
#     packages:
#       quast:
#         version: ["5.0.2"]
#         specs: ["https://anaconda.org/bioconda/quast"]

# baseCommand: [ source /unlock/infrastructure/venv/bin/activate && quast.py ]
baseCommand: ["bash", "script.sh"]


label: "QUAST: Quality Assessment Tool for Genome Assemblies"
doc: |
  Runs the Quality Assessment Tool for Genome Assemblies application

  When not using the QUAST 5.1.0rc1 pre release with python 3.8 and above do the following:
    There is a known issue present since Python 3.8.
    The work around (https://github.com/ablab/quast/issues/157) requires replace "cgi.escape" by "html.escape"
    and "import cgi" by "import html" in the file "jsontemplate.py" in the installation folder:
    "path/to/quast-5.0.2/quast_libs/site_packages/jsontemplate/jsontemplate.py"

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
    - entry: "$({class: 'Directory', listing: []})"
      entryname: "quast_results"
      writable: true
    - entryname: script.sh
      entry: |-
        #!/bin/bash
        source /unlock/infrastructure/venv/bin/activate
        quast.py $@

arguments:
  - valueFrom: "quast_results"
    prefix: --output-dir

inputs:
  assembly:
    type: File
    doc: The input assembly in fasta format
    label: assembly fasta file
    inputBinding:
      position: 999 # necessary or it complains

outputs:
  quast_outdir:
    type: Directory
    outputBinding:
      glob: quast_results
  basicStats:
    type: Directory
    outputBinding:
      glob: quast_results/basic_stats
  icarusDir:
    type: Directory
    outputBinding:
      glob: quast_results/icarus_viewers
  icarusHtml:
    type: File
    outputBinding:
      glob: quast_results/icarus.html
  quastReport:
    type: File[]
    outputBinding:
      glob: quast_results/report.*
  quastLog:
    type: File
    outputBinding:
      glob: quast_results/quast.log
  transposedReport:
    type: File[]
    outputBinding:
      glob: quast_results/transposed_report.*

s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0002-5516-8391
    s:email: mailto:german.royvalgarcia@wur.nl
    s:name: Germán Royval
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
s:dateCreated: "2021-11-25"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/
