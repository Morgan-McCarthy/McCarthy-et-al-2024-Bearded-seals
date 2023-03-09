#!/bin/bash
#SBATCH -J ngsrelate.angsd     ## you can give whatever name you want here to identify your job
#SBATCH -o ngsrelate.angsd.log.out ## name a file to save log of your job
#SBATCH -e ngsrelate.angsd.error       ## save error message if any
#SBATCH --mail-user=morgan@bio.ku.dk  ## your email account to receive notification of job status
#SBATCH --mail-type=ALL 
#SBATCH -t 05:00:00    
#SBATCH --ntasks=1                   # Run a single task
#SBATCH --cpus-per-task=20            # Number of CPU cores per task
#SBATCH --mem=10gb
############################################
module load angsd

bamlist=/projects/mjolnir1/people/nrb613/X204SC22021885-Z01-F004/combined.nuclear/redo/E.b.nauticus.bam.list.doc.1.txt
out=/projects/mjolnir1/people/nrb613/X204SC22021885-Z01-F004/combined.nuclear/redo/E.b.nauticus.genotype.likelihoods.doc.1.autosomes/E.b.nauticus.genotype.likelihoods.doc.1.autosomes.ngsrelate
chr=/projects/mjolnir1/people/nrb613/X204SC22021885-Z01-F004/reference.genome/Erignathus_barbatus_HiC_autosomes.txt

inds=28
angsd -GL 1 -rf ${chr} -out ${out}.${inds} -doMaf 1 -SNP_pval 1e-6 -nThreads 20 -minMaf 0.05 -doGlf 3 -doMajorMinor 1 -minInd ${inds} -bam ${bamlist} -uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 -skipTriallelic 1 -minMapQ 25 -minQ 30



#!/bin/bash
#SBATCH -J ngsrelate     ## you can give whatever name you want here to identify your job
#SBATCH -o ngsrelate.log.out ## name a file to save log of your job
#SBATCH -e ngsrelate.error       ## save error message if any
#SBATCH --mail-user=morgan@bio.ku.dk  ## your email account to receive notification of job status
#SBATCH --mail-type=ALL 
#SBATCH -t 24:00:00    
#SBATCH --ntasks=1                   # Run a single task
#SBATCH --cpus-per-task=10            # Number of CPU cores per task
#SBATCH --mem=10gb
############################################

ngsrelate=/projects/mjolnir1/people/nrb613/X204SC22021885-Z01-F004/combined.nuclear/redo/E.b.nauticus.genotype.likelihoods.doc.1.autosomes/ngsRelate/./ngsRelate
input=E.b.nauticus.genotype.likelihoods.doc.1.autosomes.ngsrelate.28.glf.gz
num_inds=37

${ngsrelate} -g ${input} -n ${num_inds} -f freq.28 -z ngsrelate.ids.txt -p 10 -O ngsrelate.out
