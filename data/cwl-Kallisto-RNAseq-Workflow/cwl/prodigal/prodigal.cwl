#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool

label: "Gene prediction using Prodigal"

requirements:
  ResourceRequirement:
    ramMin: 5000
    coresMin: 4

baseCommand: [ /unlock/infrastructure/binaries/Prodigal-2.6.3/prodigal ]

arguments:
  - valueFrom: "sco" # What is the sco format?
    prefix: "-f"
  - valueFrom: $(inputs.input_fasta.basename).prodigal
    prefix: "-o"
  - valueFrom: $(inputs.input_fasta.basename).prodigal.ffn
    prefix: "-d"
  - valueFrom: $(inputs.input_fasta.basename).prodigal.faa
    prefix: "-a"

inputs:
  input_fasta:
    type: File
    inputBinding:
      separate: true
      prefix: "-i"
  meta:
    type: boolean?
    doc: Input is a meta-genome
    inputBinding:
      prefix: -p meta
  single:
    type: boolean?
    doc: Input is an isolate genome
    inputBinding:
      prefix: -p single

stdout: stdout.txt
stderr: stderr.txt

outputs:
  stdout: stdout
  stderr: stderr

  predicted_proteins_out:
    type: File
    outputBinding:
      glob: $(inputs.input_fasta.basename).prodigal
  predicted_proteins_ffn:
    type: File
    outputBinding:
      glob: $(inputs.input_fasta.basename).prodigal.ffn
  predicted_proteins_faa:
    type: File
    outputBinding:
      glob: $(inputs.input_fasta.basename).prodigal.faa


$namespaces:
 s: http://schema.org/
$schemas:
 - https://schema.org/version/latest/schemaorg-current-http.rdf

's:author': 'Ekaterina Sakharova'
's:copyrightHolder': EMBL - European Bioinformatics Institute
's:license': "https://www.apache.org/licenses/LICENSE-2.0"