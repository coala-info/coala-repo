---
name: coot-headless
description: The `coot-headless` skill enables the programmatic manipulation of protein and nucleic acid structures.
homepage: https://www2.mrc-lmb.cam.ac.uk/personal/pemsley/coot
---

# coot-headless

## Overview

The `coot-headless` skill enables the programmatic manipulation of protein and nucleic acid structures. Unlike the standard Coot GUI, this tool provides the "Chapi" (Coot Headless API) Python interface, allowing for automated real-space refinement, ligand fitting, and model validation. It is the preferred choice for high-throughput structural bioinformatics where manual intervention is not feasible.

## Core Usage Patterns

### Python Scripting with Chapi
The primary way to interact with `coot-headless` is through the `chapi` module.

```python
import chapi

# Initialize the molecules container
mc = chapi.molecules_container_t()

# Load a model and a map
imol_model = mc.read_pdb("model.pdb")
imol_map = mc.read_mtz("data.mtz", "FWT", "PHWT", "", 0, 0)

# Perform automated tasks
mc.auto_fit_rotamer(imol_model, "A", 10, "", "")
mc.stepped_refine_protein_for_rama_validation(imol_model)

# Save results
mc.write_coordinates(imol_model, "refined_model.pdb")
```

### Common CLI Operations
While most logic resides in Python scripts, the environment is typically managed via Conda:

- **Installation**: `conda install -c bioconda coot-headless`
- **Execution**: `python your_script.py` (Ensure the environment is active so `chapi` is in the PYTHONPATH).

## Expert Tips and Best Practices

- **Memory Management**: When processing large numbers of molecules in a single script, use `mc.close_molecule(imol)` to free memory, as the `molecules_container_t` persists data until explicitly cleared.
- **Map Handling**: For Cryo-EM data, use `mc.read_ccp4_map("map.mrc", False)` instead of `read_mtz`.
- **Selection Strings**: Use standard Coot/MMDB selection syntax (CIDs) for targeted operations, e.g., `//A/10-20/CA` for alpha carbons in chain A residues 10 through 20.
- **Validation**: Leverage the `get_r_factor_stats()` and `print_secondary_structure_info()` methods to programmatically assess model quality after refinement steps.
- **Thread Control**: Use `mc.set_max_number_of_threads(n)` to optimize performance on multi-core systems, especially during map contouring or global refinement.

## Reference documentation

- [Anaconda Bioconda coot-headless Overview](./references/anaconda_org_channels_bioconda_packages_coot-headless_overview.md)
- [Coot Headless API (libcootapi) Documentation](./references/www2_mrc-lmb_cam_ac_uk_personal_pemsley_coot_docs_api_html.md)
- [Coot FAQ](./references/www2_mrc-lmb_cam_ac_uk_personal_pemsley_coot_docs_coot-faq.html.md)