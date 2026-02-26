cwlVersion: v1.2
class: CommandLineTool
baseCommand: chewBBACA.py
label: chewbbaca_chewBBACA.py
doc: "Select one of the following modules:\n\nTool homepage: https://github.com/B-UMMI/chewBBACA"
inputs:
  - id: module
    type: string
    doc: "Select one of the following modules:\nCreateSchema: Create a gene-by-gene
      schema based on a set of genome assemblies or coding sequences.\nAlleleCall:
      Determine the allelic profiles of a set of bacterial genomes based on a schema.\n\
      SchemaEvaluator: Build an interactive report for schema evaluation.\nAlleleCallEvaluator:
      Build an interactive report for allele calling results evaluation.\nExtractCgMLST:
      Determines the set of loci that constitute the core genome based on loci presence
      thresholds.\nRemoveGenes: Remove a list of loci from your allele call output.\n\
      PrepExternalSchema: Adapt an external schema to be used with chewBBACA.\nJoinProfiles:
      Join allele calling results from different runs.\nGetAlleles: Create FASTA files
      containing the alleles identified by the AlleleCall module.\nUniprotFinder:
      Retrieve annotations for loci in a schema.\nComputeMSA: Compute a Multiple Sequence
      Alignment based on allele calling results.\nDownloadSchema: Download a schema
      from Chewie-NS.\nLoadSchema: Upload a schema to Chewie-NS.\nSyncSchema: Synchronize
      a schema with its remote version in Chewie-NS.\nNSStats: Retrieve basic information
      about the species and schemas in Chewie-NS."
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chewbbaca:3.5.1--pyhdfd78af_0
stdout: chewbbaca_chewBBACA.py.out
