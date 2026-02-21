---
name: dnaweaver
description: DNA Weaver is a specialized optimization engine for synthetic biology that functions like a "route planner" for genetic engineering.
homepage: https://github.com/Edinburgh-Genome-Foundry/DnaWeaver/
---

# dnaweaver

## Overview
DNA Weaver is a specialized optimization engine for synthetic biology that functions like a "route planner" for genetic engineering. It treats DNA assembly as a pathfinding problem where the goal is to find the most efficient way to construct a target sequence using a network of available sources—such as commercial vendors, PCR from genomic templates, or existing part repositories. It is particularly powerful for "domesticating" sequences (removing forbidden restriction sites via site-directed mutagenesis) and for minimizing the cost of large-scale synthesis by intelligently splitting sequences across multiple providers with different pricing tiers and biological constraints.

## Installation
Install via the bioconda channel:
```bash
conda install bioconda::dnaweaver
```

## Core Workflow Patterns

### 1. Defining Commercial Providers
Set up vendors with specific constraints (e.g., maximum length or forbidden sequences) to allow the engine to automatically choose the cheapest valid option for any given segment.

```python
import dnaweaver as dw

# Define a provider with specific constraints
cheap_dna = dw.CommercialDnaOffer(
    name="CheapDNA",
    sequence_constraints=[
        dw.NoPatternConstraint(enzyme="BsaI"),
        dw.SequenceLengthConstraint(max_length=4000)
    ],
    pricing=dw.PerBasepairPricing(0.10),
    lead_time=40
)
```

### 2. Setting Up Assembly Stations
Assembly stations define the laboratory methods used to join fragments. You can specify parameters for overhangs and segment lengths.

```python
assembly_station = dw.DnaAssemblyStation(
    name="Gibson Station",
    assembly_method=dw.GibsonAssemblyMethod(
        overhang_selector=dw.TmSegmentSelector(min_tm=55, max_tm=70),
        min_segment_length=500,
        max_segment_length=4000
    ),
    supplier=[cheap_dna, deluxe_dna] # Links to the providers defined above
)
```

### 3. Generating and Exporting Plans
Once the supply network is defined, you can request a quote for a specific sequence and generate a comprehensive report including fragment designs and order lists.

```python
# Get the optimal plan
quote = assembly_station.get_quote(sequence, with_assembly_plan=True)

# Print a summary of the steps
print(quote.assembly_step_summary())

# Export a full report (PDFs, Genbank files, and CSVs)
report = quote.to_assembly_plan_report()
report.write_full_report("assembly_plan.zip")
```

## Expert Tips
- **Optimization Speed**: For very long sequences (e.g., >50kb), increase the `coarse_grain` parameter in your `DnaAssemblyStation`. A higher value (e.g., 20-100) reduces the granularity of the search space for fragment boundaries, significantly speeding up computation with minimal impact on the final cost.
- **Automated Domestication**: To remove forbidden restriction sites (like BsaI for Golden Gate standards), connect a `PcrExtractionStation` (configured with a genomic BLAST database) to an assembly station. DNA Weaver will design primers that introduce synonymous mutations at the forbidden sites during the PCR step.
- **Part Reuse**: Use the `PartsLibrary` class to include existing lab stocks or standard parts (like the EMMA toolkit) in your supply network. The engine will prioritize using these existing sequences if they reduce the overall cost or assembly time.
- **Multi-Stage Assembly**: You can nest assembly stations by setting one station as the `supplier` for another. This allows you to model complex hierarchies, such as building 1kb fragments from oligos, then 10kb chunks from those fragments, and finally a 100kb construct.

## Reference documentation
- [DnaWeaver GitHub README](./references/github_com_Edinburgh-Genome-Foundry_DnaWeaver.md)
- [Bioconda DnaWeaver Overview](./references/anaconda_org_channels_bioconda_packages_dnaweaver_overview.md)