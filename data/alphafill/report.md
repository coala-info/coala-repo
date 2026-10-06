# alphafill CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| alphafill_create-index | PASS | Upstream mini PDB-REDO test set (1cbs, 2cbs, 3cbs) gives 3 entity sequences; CWL fixed: --pdb-fasta is an output name, config made required. |
| alphafill_process | PASS | Upstream test model AF-P29373: first hit 1CBS chain A with retinoic acid (REA) transplanted, as the upstream test expects; CWL fixed: output name and outputs added, config made required. |

## Metadata
- **Skill**: generated
