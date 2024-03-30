#!/bin/bash
#SBATCH --job-name=m3-affect-24h-brmcoda-1
#SBATCH --time=0-05:00:00
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=5GB
#SBATCH --cpus-per-task=8
#SBATCH --partition=comp

cd /fs04/ft29/multilevelcoda-24h-affect

module load R/4.2.2-mkl

Rscript m3-affect-24h-brmcoda-1.R

echo 'Completed by' $USER