https://rdhpcs-common-docs.rdhpcs.noaa.gov/wikis/rdhpcs-common-docs/doku.php?id=a-quick-introduction-to-slurm

module load slurm

sacctmgr show qos            # tells me what are available ques; https://slurm.schedmd.com/sacctmgr.html
squeue                       # used to view job and job step information for jobs managed by Slurm; see https://slurm.schedmd.com/squeue.html for options
sinfo                        # used to view partition and node information for a system running Slurm; see https://slurm.schedmd.com/sinfo.html


sbatch script.sh             # submits a batch script to Slurm; 

the script itself should start with something like: 
#!/bin/bash -l               # -l (small L) option invokes ~/.cshrc settings
#SBATCH -A marine-cpu        # -A specifies the account
#SBATCH -n 1                 # -n specifies the number of tasks (cores) (-N would be for number of nodes) 
#SBATCH --exclusive          # exclusive use of node - hoggy but OK
#SBATCH -q debug             # -q specifies the queue; debug has a 30 min limit
##SBATCH -t 60               # -t specifies walltime in minutes; ## comments the line out



