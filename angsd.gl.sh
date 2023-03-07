#!/bin/bash
#SBATCH -J EB.initial.doc.1.map30.genotype.likelihoods.final      ## you can give whatever name you want here to identify your job
#SBATCH -o EB.initial.doc.1.map30.genotype.likelihoods.final.log.out ## name a file to save log of your job
#SBATCH -e EB.initial.doc.1.map30.genotype.likelihoods.final.test.error       ## save error message if any
#SBATCH --mail-user=morgan@bio.ku.dk  ## your email account to receive notification of job status
#SBATCH --mail-type=ALL 
#SBATCH --time=12:00:00    
#SBATCH --ntasks=1                   # Run a single task
#SBATCH --cpus-per-task=20            # Number of CPU cores per task
#SBATCH --mem=10gb
############################################

bamlist=/projects/mjolnir1/people/nrb613/X204SC22021885-Z01-F004/combined.nuclear/redo/E.b.bam.list.doc.1.final.txt
out=/projects/mjolnir1/people/nrb613/X204SC22021885-Z01-F004/combined.nuclear/redo/EB.genotype.likelihoods.doc.1.autosomes/EB.genotype.likelihoods.doc.1.map30.autosomes.final.54
chr=/projects/mjolnir1/people/nrb613/X204SC22021885-Z01-F004/reference.genome/Erignathus_barbatus_HiC_autosomes.txt

module load angsd
#54 represents 75% of all individuals with a depth of coverage greater than 1x (total 72).
inds=54
angsd -GL 1 -rf ${chr} -out ${out}.${inds} -doMaf 1 -SNP_pval 1e-6 -nThreads 20 -minMaf 0.05 -doGlf 2 -doMajorMinor 1 -minInd ${inds} -bam ${bamlist} -uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 -skipTriallelic 1 -minMapQ 30 -minQ 30
