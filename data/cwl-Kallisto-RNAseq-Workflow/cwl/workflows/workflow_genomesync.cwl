#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

label: "Genome synchronisation with EBI"

doc: |
    Runs the genome synchronisation application which downloads genomes from the EBI into the corresponding taxonomic path

requirements:
 - class: InlineJavascriptRequirement

inputs:
  bin:
    type: int?
    doc: Maximum number of genomes per bin
    label: bin size
    inputBinding:
      prefix: -bin
    default: 10
  clazz:
    type: string?
    doc: Filtering by taxonomic class name
    label: class name
    inputBinding:
      prefix: -class
  embl:
    type: boolean?
    doc: Retrieves genome files in embl format
    label: embl format
    inputBinding:
      prefix: -embl
  family:
    type: string?
    doc: Filtering by taxonomic family name
    label: family name
    inputBinding:
      prefix: -family
  fasta:
    type: boolean?
    doc: Retrieves genome files in fasta format
    label: fasta format
    inputBinding:
      prefix: -fasta
  genus:
    type: string?
    doc: Filtering by taxonomic genus name
    label: genus name
    inputBinding:
      prefix: -genus
  summary:
    type: string
    doc: input of the assembly_summary_genbank file
    label: assembly_summary_genbank file
    inputBinding:
      prefix: -summary
    default: assembly_summary_genbank.txt
  irods:
    type: boolean?
    doc: ensures obtained data is stored in irods
    label: irods connection
    inputBinding:
      prefix: -irods
  keep:
    type: boolean?
    doc: Keep the downloaded files from ENA after successful completion
    label: downloaded files are stored permanently
    inputBinding:
      prefix: -keep
  order:
    type: string?
    doc: Filtering by taxonomic order name
    label: order name
    inputBinding:
      prefix: -order
  output:
    type: string
    doc: output folder to store the results in
    label: output folder
    inputBinding:
      prefix: -output
  phylum:
    type: string?
    doc: Filtering by taxonomic phylum name
    label: phylum name
    inputBinding:
      prefix: -phylum
  skip:
    type: string?
    doc: Skips the conversion of the strains to rdf
    label: skip rdf conversion
    inputBinding:
      prefix: -skip
  species:
    type: string?
    doc: Filtering by taxonomic species name
    label: species name
    inputBinding:
      prefix: -species
  strict:
    type: string?
    doc: Enable strict mode, stops completelty when a conversion fails
    label: strict mode
    inputBinding:
      prefix: -strict
  superkingdom:
    type: string?
    doc: Filtering by taxonomic superkingdom name
    label: superkingdom name
    inputBinding:
      prefix: -superkingdom
  update:
    type: boolean?
    doc: Force update of the assembly_summary_genbank lookup list
    label: force lookup list update
    inputBinding:
      prefix: -update
  enaBrowserTools:
    type: string
    doc: Path of the local enaBrowserTools git repository
    label: enaBrowserTools location
    inputBinding:
      prefix: -enaBrowserTools
    default: /unlock/infrastructure/binaries/enaBrowserTools
  taxonomy:
    type: string
    doc: Path of the taxonomy.hdt lookup file
    label: Taxnomy RDF (HDT) file
    inputBinding:
      prefix: -taxonomy
    default: /tempZone/References/Databases/UniProt/taxonomy.hdt

  destination:
    type: string?
    label: Output Destination
    doc: Optional Output destination used for cwl-prov reporting.

arguments: ["java", "-Xmx3g", "-jar", "/unlock/infrastructure/binaries/GenomeSync.jar"]

outputs:
  test:
    type: Directory
    outputBinding:
      glob: bla

s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-8172-8981
    s:email: mailto:jasper.koehorst@wur.nl
    s:name: Jasper Koehorst

s:citation: https://m-unlock.nl
s:codeRepository: https://gitlab.com/m-unlock/cwl
s:dateCreated: "2020-00-00"
s:dateModified: "2022-05-00"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/
