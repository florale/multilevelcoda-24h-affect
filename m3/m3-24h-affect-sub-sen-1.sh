#!/bin/bash
#SBATCH --job-name=m3-24h-affect-sub-sen-1
#SBATCH --time=0-12:00:00
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=100GB
#SBATCH --cpus-per-task=2
#SBATCH --partition=comp

cd /fs04/ft29/multilevelcoda-24h-affect

module load R/4.4.0-mkl

Rscript m3-24h-affect-sub-sen-1.R

echo 'Completed by' $USER