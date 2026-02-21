---
name: dnacauldron
description: dnacauldron is a cloning simulation framework designed to bridge the gap between digital DNA design and laboratory execution.
homepage: https://github.com/Edinburgh-Genome-Foundry/DnaCauldron
---

# dnacauldron

## Overview
dnacauldron is a cloning simulation framework designed to bridge the gap between digital DNA design and laboratory execution. It allows for the in silico verification of assembly strategies by modeling the behavior of restriction enzymes and homology-based recombination. Use this skill when you need to validate that a set of genetic parts will assemble into the expected circular or linear construct and to generate comprehensive reports on potential assembly failures.

## Sequence Repository Management
All simulations require a `SequenceRepository` to manage the source parts.
- **Importing:** Use `repository.import_sequences(folder="path/")` to batch load Genbank or FASTA files.
- **Topology Matters:** Ensure `record.annotations['topology']` is set correctly. You can force this during import using `topology='linear'` or `topology='circular'`.
- **Naming:** Use `use_file_names_as_ids=True` to keep track of parts based on their source filenames.

## Simulating Assemblies
Choose the assembly class that matches your laboratory protocol:

- **Golden Gate / Type-2s:** Use `Type2sRestrictionAssembly`. It automatically detects common enzymes like BsaI, BsmBI, and BbsI, but you can specify one via `enzyme='BsmBI'`.
- **Gibson/Homology:** Use `GibsonAssembly` for homology-based overlaps.
- **Standardized Parts:** Use `BioBrickStandardAssembly` for iGEM-style assemblies.

```python
import dnacauldron as dc

# Define the assembly
assembly = dc.Type2sRestrictionAssembly(parts=["part_A", "part_B", "vector"])

# Run simulation
simulation = assembly.simulate(sequence_repository=repository)

# Check results
for record in simulation.construct_records:
    print(f"Construct: {record.id}, Length: {len(record)}")
```

## Batch and Hierarchical Plans
For large-scale projects, define an `AssemblyPlan` using spreadsheets (CSV/XLSX).
- **Spreadsheet Format:** Columns typically include `assembly_name` and `parts` (comma-separated list of IDs).
- **Hierarchical Assembly:** dnacauldron automatically resolves dependencies. If Assembly 2 uses the output of Assembly 1 as a part, the engine will simulate them in the correct order.
- **Importing Plans:** Use `dc.AssemblyPlan.from_spreadsheet(path="plan.csv", assembly_class=dc.Type2sRestrictionAssembly)`.

## Expert Tips and Flaw Detection
- **Unwanted Sites:** The simulation will flag "internal" restriction sites that would result in the digestion of your final construct.
- **Connector Selection:** If an assembly is missing a required link, dnacauldron can be configured to select appropriate connector parts from the repository.
- **Report Generation:** Always use `simulation.write_report("output.zip")` or `plan_simulation.write_report()` to get a full diagnostic package, including sequence files and PDF/PNG figures of the fragments.
- **Combinatorial Assembly:** If a part list contains multiple variants for a single slot, the tool will generate all possible valid combinations.

## Reference documentation
- [DnaCauldron GitHub Repository](./references/github_com_Edinburgh-Genome-Foundry_DnaCauldron.md)
- [DnaCauldron Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_dnacauldron_overview.md)