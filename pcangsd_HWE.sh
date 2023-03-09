#!/bin/bash
#SBATCH -J pcangsd.hwe      ## you can give whatever name you want here to identify your job
#SBATCH -o pcangsd.hwe.log.out ## name a file to save log of your job
#SBATCH -e pcangsd.hwe.error       ## save error message if any
#SBATCH --mail-user=morgan@bio.ku.dk  ## your email account to receive notification of job status
#SBATCH --mail-type=ALL 
#SBATCH -t 00:30:00    
#SBATCH --ntasks=1                   # Run a single task
#SBATCH --cpus-per-task=5            # Number of CPU cores per task
#SBATCH --mem=2gb
############################################
module load miniconda
conda activate /projects/mjolnir1/apps/conda/pcangsd-0.98.2

#For the initial global dataset
beagle_file=EB.genotype.likelihoods.doc.1.map30.autosomes.final.54.beagle.gz
output=EB.genotype.likelihoods.doc.1.map30.autosomes.final.54
e=3

#3805163 sites before removing
pcangsd -beagle $beagle_file -inbreedSites -e $e -o ${output}.hwe_postQC_loci_e$e -sites_save
