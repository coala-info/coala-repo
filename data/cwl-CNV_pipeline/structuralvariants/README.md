# StructuralVariants Workflow

## CWL version

The CWL workflow can be run using the next command line:

```bash
cwltool --outdir={outputs folder} --tmpdir-prefix={intermediate folder} --tmp-outdir-prefix={intermediate folder} cwl/workflow.cwl {YAML describing inputs}
```

## Nextflow version

The Nextflow can be run using the next command line:

```bash
nextflow run nextflow/main.nf -profile <docker/singularity>
```

See [nextflow.config](https://gitlab.bsc.es/lrodrig1/structuralvariants_poc/-/blob/master/structuralvariants/nextflow/nextflow.config) configuration file.
