---
name: promod3
description: ProMod3 is a modular protein homology modeling engine used to automate the construction and refinement of protein structures. Use when user asks to build protein models from alignments, reconstruct or optimize sidechains, perform loop sampling, or score protein backbones.
homepage: https://openstructure.org/promod3/
metadata:
  docker_image: "quay.io/biocontainers/promod3:3.6.0--py311he264feb_0"
---

# promod3

## Overview
ProMod3 is a modular modelling engine built on the OpenStructure framework. It is designed to automate the protein homology modelling pipeline—from raw model building to final energy minimization. This skill enables the execution of predefined "actions" for common tasks and provides guidance for writing custom Python scripts to handle complex structural biology workflows like loop sampling and sidechain optimization.

## Command Line Actions
The `pm` executable is the primary interface for ProMod3.

### Homology Modelling
Build a protein model using a target-template alignment and a template structure.
```bash
# Basic usage with FASTA alignment and PDB template
pm build-model -f aln.fasta -p tpl.pdb -o model.pdb

# Build full target sequence (including terminal parts without template coverage)
pm build-model -f aln.fasta -p tpl.pdb -t -o full_model.pdb

# Include sequence profiles (.hhm or .pssm) for improved loop scoring
pm build-model -f aln.fasta -p tpl.pdb -s profile.hhm
```
*   **Input Formats**: Alignments can be FASTA (`-f`), CLUSTAL (`-c`), or JSON (`-j`). Structures can be PDB (`-p`) or MMCIF (`-e`).
*   **Template Naming**: If the template file has multiple chains, name the sequence in your alignment file as `<FILE>.<CHAIN>` (e.g., `2jlp.A`) to ensure correct mapping.

### Sidechain Reconstruction
Reconstruct or optimize sidechains for an existing backbone.
```bash
# Reconstruct all sidechains using the default flexible rotamer model
pm build-sidechains -p input.pdb -o optimized.pdb

# Keep existing sidechains and only model missing ones
pm build-sidechains -p input.pdb -k -o filled.pdb

# Use a specific energy function (e.g., SCWRL4)
pm build-sidechains -p input.pdb -f SCWRL4
```

## Python Scripting Patterns
For custom pipelines, run Python scripts via `pm <script.py>`.

### Basic Modelling Pipeline
```python
from ost import io
from promod3 import modelling

# 1. Load template and alignment
tpl = io.LoadPDB('template.pdb')
aln = io.LoadAlignment('aln.fasta')
aln.AttachView(1, tpl.CreateFullView())

# 2. Build raw model (copies conserved parts)
mhandle = modelling.BuildRawModel(aln)

# 3. Build final model (closes gaps, builds sidechains, minimizes energy)
final_model = modelling.BuildFromRawModel(mhandle)
io.SavePDB(final_model, 'model.pdb')
```

### Loop Handling and Scoring
Use the `loop` and `scoring` modules to evaluate specific regions.
```python
from promod3 import loop, scoring

# Load a fragment database for loop searching
frag_db = loop.LoadFragDB()
# Search for fragments of length 9 between two stems
fragments = frag_db.SearchDB(n_stem_residue, c_stem_residue, 9)

# Setup scoring environment
score_env = scoring.BackboneScoreEnv(target_sequence)
score_env.SetInitialEnvironment(template_entity)

# Attach a specific scorer (e.g., Clashes)
clash_scorer = scoring.ClashScorer()
clash_scorer.AttachEnvironment(score_env)
score = clash_scorer.CalculateScore(start_res_num, loop_length)
```

## Expert Tips
*   **Performance**: For energy minimization, ProMod3 uses OpenMM. Set the environment variable `PM3_OPENMM_CPU_THREADS` to control multi-threading (defaults to 1).
*   **Compound Library**: If you encounter issues with non-standard residues, ensure the OpenStructure chemical components dictionary is loaded using `promod3.SetCompoundsChemlib(path)`.
*   **Fragment Sampling**: Use the `-r` flag in `build-model` to enforce structural fragment usage, which can improve loop accuracy at the cost of runtime.

## Reference documentation
- [ProMod3 Actions](./references/openstructure_org_promod3_3.5_actions.md)
- [Getting Started](./references/openstructure_org_promod3_3.5_gettingstarted.md)
- [Protein Modelling](./references/openstructure_org_promod3_3.5_modelling.md)
- [Loop Handling](./references/openstructure_org_promod3_3.5_loop.md)
- [Sidechain Modelling](./references/openstructure_org_promod3_3.5_sidechain.md)