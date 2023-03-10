#!/bin/bash
#SBATCH -J ngsrelate     ## you can give whatever name you want here to identify your job
#SBATCH -o ngsrelate.log.out ## name a file to save log of your job
#SBATCH -e ngsrelate.error       ## save error message if any
#SBATCH --mail-user=morgan@bio.ku.dk  ## your email account to receive notification of job status
#SBATCH --mail-type=ALL 
#SBATCH -t 24:00:00    
#SBATCH --ntasks=1                   # Run a single task
#SBATCH --cpus-per-task=20            # Number of CPU cores per task
#SBATCH --mem=10gb
############################################
module load angsd

bamlist=/projects/mjolnir1/people/nrb613/X204SC22021885-Z01-F004/combined.nuclear/redo/E.b.bam.list.doc.1.final.txt
out=/projects/mjolnir1/people/nrb613/X204SC22021885-Z01-F004/combined.nuclear/redo/EB.genotype.likelihoods.doc.1.autosomes/EB.genotype.likelihoods.doc.1.map30.autosomes.final.ngsrelate
chr=/projects/mjolnir1/people/nrb613/X204SC22021885-Z01-F004/reference.genome/Erignathus_barbatus_HiC_autosomes.txt

#Get genotype likelihoods in the correct format for ngsrelate
inds=54
angsd -GL 1 -rf ${chr} -out ${out}.${inds} -doMaf 1 -SNP_pval 1e-6 -nThreads 20 -minMaf 0.05 -doGlf 3 -doMajorMinor 1 -minInd ${inds} -bam ${bamlist} -uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 -skipTriallelic 1 -minMapQ 25 -minQ 30


#Run ngsrelate

ngsrelate=/projects/mjolnir1/people/nrb613/X204SC22021885-Z01-F004/combined.nuclear/redo/E.b.nauticus.genotype.likelihoods.doc.1.autosomes/ngsRelate/./ngsRelate
input=/projects/mjolnir1/people/nrb613/X204SC22021885-Z01-F004/combined.nuclear/redo/EB.genotype.likelihoods.doc.1.autosomes/EB.genotype.likelihoods.doc.1.map30.autosomes.final.ngsrelate/EB.genotype.likelihoods.doc.1.map30.autosomes.final.ngsrelate.54.glf.gz
freqs=/projects/mjolnir1/people/nrb613/X204SC22021885-Z01-F004/combined.nuclear/redo/EB.genotype.likelihoods.doc.1.autosomes/EB.genotype.likelihoods.doc.1.map30.autosomes.final.ngsrelate/EB.genotype.likelihoods.doc.1.map30.autosomes.final.ngsrelate.54.mafs.gz
num_inds=72

cat E.b.bam.list.doc.1.final.txt | cut -f1 -d "_" > global.ids.txt

zcat ${freqs} | cut -f5 | sed 1d > freq.${inds}

${ngsrelate} -g ${input} -n ${num_inds} -f freq.${inds} -z global.ids.txt -p 20 -O EB.genotype.likelihoods.doc.1.autosomes/ngsrelate.out
