cwlVersion: v1.2
class: CommandLineTool
baseCommand: ebisearch_get_domains
label: ebisearch_get_domains
doc: "Get domains from EBI Search\n\nTool homepage: https://github.com/ebi-wp/EBISearch-webservice-clients"
inputs:
  - id: domains
    type:
      - 'null'
      - type: array
        items: string
    doc: 'List of domains to retrieve. Available domains: allebi, alphafold, atlas-experiments,
      atlas-genes, atlas-genes-differential, bioimages, biomodels, biomodels_all,
      biomodels_autogen, biomodels_parameters, biosamples, biosamples-covid19, biostudies-arrayexpress,
      biostudies-literature, biostudies-other, biotools, cancer_models, cellcollective,
      cellosaurus, cessda-covid19, chebi, chembl, chembl-assay, chembl-document, chembl-molecule,
      chembl-target, chembl-target_component, coding, coding_con, coding_std, coding_tls,
      coding_tsa, coding_wgs_1, coding_wgs_2, coding_wgs_3, coding_wgs_all, cohorts,
      cohorts_earlycause, cohorts_recodid, complex-portal, covid-nl, datahubs, dbgap,
      dgva, diseases, earlycause-molecular-sequences, ebiweb, ebiweb_corporate, ebiweb_people,
      ebiweb_resources, ebiweb_teams, ebiweb_training, ebiweb_training_events, ebiweb_training_online,
      ecbd-covid19, ecrin-mdr, ecrin-mdr-covid, ecrin-mdr-crc, efo, ega, ega-bycovid,
      embl, embl-covid19, embl-pathogen, emblcon, emblstandard, emdb, empiar, ensembl,
      ensemblGenomes, ensemblGenomes-cv19, ensemblGenomes-cv19_gene, ensemblGenomes-cv19_genome,
      ensemblGenomes-cv19_seqRegion, ensemblGenomes-cv19_variant, ensemblGenomes_gene,
      ensemblGenomes_genome, ensemblGenomes_seqRegion, ensemblGenomes_variant, ensemblNext,
      ensemblRoot, ensembl_gene, enzymes, epo, eui-covid19, europepmc, eva, eva-variants-covid19,
      eva_studies, fairdomhub, g2p, geneDiseaseAssociations, geneExpression, genome_assembly,
      genome_variation, genomes, geo, geo_datasets, gnps, go, gpcrdb, gpmdb, gwas_catalog,
      hgnc, hpa-covid19, human_diseases, iddo-bycovid, identifiers_registry, idtk,
      images, imgt-hla, intact, intact-interactions, intenz, interpro7, interpro7_active-site,
      interpro7_binding-site, interpro7_coiled_coil, interpro7_conserved-site, interpro7_disordered,
      interpro7_domain, interpro7_family, interpro7_homologous_superfamily, interpro7_ptm,
      interpro7_region, interpro7_repeat, ipd-kir, ipd-mhc, ipd-nhkir, iprox, jpo,
      jpost, kipo, lincs, literature, lrg, macromolecularStructures, massive, merops,
      merops_clan, merops_family, merops_id, mesh, metabolights, metabolights_dataset,
      metabolomics_workbench, metagenomics, metagenomics_analyses, metagenomics_projects,
      molecularInteractions, national-portals-netherlands, national-portals-sweden,
      node, non-coding, nrnl1, nrnl2, nrpl1, nrpl2, nucleotideSequences, ols, omim,
      ontologies, opentargets, orcid_data_claims, other-data, panorama, patentFamilies,
      patentNucleotides, patentProteins, paxdb, pdbe, pdbechem, pdbekb, peptide_atlas,
      pfam, pfam_clans, pfam_entries, pfam_seqs, phiri, physiome, pride, priority_pathogens,
      project, proteinExpressionData, proteinFamilies, proteinSequences, proteomes,
      reactionsPathways, reactome, reactome-covid19, registries, related-resources-covid19,
      related-resources-pathogens, relatedResources, researchInfrastructures, rfam,
      rhea, rnacentral, rnacentral-litscan, sc-experiments, sc-genes, smallMolecules,
      socialSciences, sra, sra-analysis, sra-analysis-covid19, sra-analysis-mpox,
      sra-experiment, sra-run, sra-sample, sra-study, sra-submission, ssgcid_targets,
      taxonomy, tls_masters, treefam, tsa_masters, uniparc, uniprot, uniprot-covid19,
      uniprot-keywords, uniref, uniref100, uniref50, uniref90, uspto, varsite, wgs_masters,
      workflowhub-covid19, wormbaseParasite'
    inputBinding:
      position: 101
      prefix: --domains
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ebisearch:0.0.3--py27_1
stdout: ebisearch_get_domains.out
