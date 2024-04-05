#!/bin/bash
#SBATCH --job-name=m3-24h-affect-sub-1
#SBATCH --time=0-12:00:00
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=30GB
#SBATCH --cpus-per-task=3
#SBATCH --partition=comp

cd /fs04/ft29/multilevelcoda-24h-affect

module load R/4.2.2-mkl

Rscript m3-24h-affect-sub-1.R

echo 'Completed by' $USER