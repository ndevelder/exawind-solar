#!/bin/bash 

#SBATCH -A FY190020
#SBATCH -t 48:00:00
#SBATCH --qos=normal
#SBATCH --partition=batch
#SBATCH -o hybrid-panels_log_%j.out
#SBATCH -J hybrid-panels
#SBATCH --mail-type=ALL
#SBATCH --mail-user=ndeveld@sandia.gov
#SBATCH -N 16

# load the modules with exawind executable/setup the run env
# MACHINE_NAME will get populated via aprepro
source /pscratch/ndeveld/hybrid-power/solar-bl-master/load-env.sh

nodes=$SLURM_JOB_NUM_NODES
rpn=36
ranks=$(( $rpn*$nodes ))

nalu_ranks=$(( ($ranks*50)/100 ))
amr_ranks=$(( $ranks-$nalu_ranks ))


srun -N $nodes -n $ranks exawind --nwind $nalu_ranks --awind $amr_ranks exawind.yaml &> runlog.out



chown $USER:wg-sierra-users .
chmod g+s .

