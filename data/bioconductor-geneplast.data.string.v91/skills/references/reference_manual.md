geneplast.data.string.v91

February 11, 2026

gpdata_string_v91

Data package used in evolutionary root inference reconstruction con-
taining four objects derived from the STRING database, release 9.1

Description

Data package used in evolutionary root inference reconstruction containing four objects derived
from the STRING database, release 9.1

Usage

data(gpdata_string_v91)

Format

Dataset with cogids, cogdata, sspids, phyloTree.

• cogids. A data.frame with 143458 COG IDs.

• cogdata. A data.frame with COG to protein mapping.

– protein_id. Proteins listed in the COG data information.
– ssp_id. Species listed in the COG data information.
– cog_id. COG identifiers.
– gene_id. Gene identifiers mapped to the human species.

• sspids. A data.frame with species identifiers.

– ssp_id. Species identifier.
– ssp_name. Name of the species.
– domain. Species domain.

• phyloTree. An object of class ’phylo’.

– Phylogenetic tree with 121 tips and 120 internal nodes describing relations between all

Eukaryotes listed in the ’sspids’ object.

1

Index

∗ datasets

gpdata_string_v91, 1

cogdata (gpdata_string_v91), 1
cogids (gpdata_string_v91), 1

gpdata_string_v91, 1

phyloTree (gpdata_string_v91), 1

sspids (gpdata_string_v91), 1

2

