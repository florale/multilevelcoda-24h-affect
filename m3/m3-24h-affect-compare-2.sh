#!/bin/bash
#SBATCH --job-name=m3-24h-affect-compare-2
#SBATCH --time=3-00:00:00
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=5GB
#SBATCH --cpus-per-task=20
#SBATCH --partition=comp

cd /fs04/ft29/multilevelcoda-24h-affect

module load R/4.2.2-mkl

Rscript m3-24h-affect-compare-2.R

echo 'Completed by' $USER