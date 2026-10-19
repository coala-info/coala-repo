# relion-bin-plusmpi-plusgui CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| relion-bin-plusmpi-plusgui_relion_preprocess | Failed | tool bug: the normalised stack is written as <o>.mrcs.mrcs while the output STAR file names <o>.mrcs, so the STAR file points to a missing stack |
| relion-bin-plusmpi-plusgui_relion_refine_mpi | PASS | synthetic data: noisy projections of the EMD-2788 apoferritin map; run through mpirun with 3 processes; map correlation to the source map rose to 0.61 in 2 iterations |

## Metadata
- **Skill**: generated
