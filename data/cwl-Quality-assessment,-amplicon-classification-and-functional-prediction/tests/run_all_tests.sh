DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

# Make sure you have the following tools installed:
# - cwltool
# - runcrate

# Activate the virtual environment
source ../venv/bin/activate 

# Create result folder
rm -rf results
mkdir -p results

# Runs the test.sh script for all workflows
# The test.sh script runs the workflow and converts the provenance to ROC format

# Runs ngtax test with relaxed path checks for the silva database
./test.sh --relax-path-checks ngtax/ngtax.yaml
runcrate convert -o ROC_ngtax PROV
mv PROV ./results/PROV_ngtax
mv ROC_ngtax ./results/ROC_ngtax
mv OUT ./results/OUT_ngtax

# # Runs illumina quality workflow test
./test.sh ../workflows/workflow_illumina_quality.cwl quality/illumina.yaml
runcrate convert -o ROC_illumina PROV
mv PROV ./results/PROV_illumina
mv ROC_illumina ./results/ROC_illumina
mv OUT ./results/OUT_illumina

# Long read test without kraken
./test.sh ../workflows/workflow_longread_quality.cwl quality/longread_no_kraken.yaml
runcrate convert -o ROC_longread_no_kraken PROV
mv PROV ./results/PROV_longread_no_kraken
mv ROC_longread_no_kraken ./results/ROC_longread_no_kraken
mv OUT ./results/OUT_longread_no_kraken

# Long read test with kraken (when kraken is available)
# ./test.sh quality/longread_full_run.yaml
# runcrate convert -o ROC_longread_full_run PROV
# mv PROV ./results/PROV_longread_full_run
# mv ROC_longread_full_run ./results/ROC_longread_full_run
# mv OUT ./results/OUT_longread_full_run

# Hybrid Assembly test
# ./test.sh ../workflows/workflow_metagenomics_assembly.cwl assembly/hybrid_small.yaml
# runcrate convert -o ROC_assembly PROV
# mv PROV ./results/PROV_assembly
# mv ROC_assembly ROC_assembly_small
# mv OUT ./results/OUT_assembly

# Proteomics
./test.sh ../tools/maxquant/maxquant.cwl proteomics/maxquant.yaml
runcrate convert -o ROC_proteomics PROV
mv PROV PROV_proteomics
mv ROC_proteomics ./results/ROC_proteomics
mv OUT ./results/OUT_proteomics
