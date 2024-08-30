#!/bin/bash
#SBATCH --job-name=24h-affect-brmcoda-lag-adj-2
#SBATCH --time=0-03:00:00
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=5GB
#SBATCH --cpus-per-task=8
#SBATCH --partition=comp

cd /fs04/ft29/multilevelcoda-24h-affect

module load R/4.2.2-mkl

Rscript 24h-affect-brmcoda-lag-adj-2.R

echo 'Completed by' $USER