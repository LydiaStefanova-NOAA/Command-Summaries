https://rdhpcs-common-docs.rdhpcs.noaa.gov/wikis/rdhpcs-common-docs/doku.php?id=a-quick-introduction-to-slurm

module load slurm

sacctmgr show qos            # tells me what are available ques; https://slurm.schedmd.com/sacctmgr.html
sshare -U $USER              # tells me what accounts are available to me
sinfo                        # used to view partition and node information for a system running Slurm; see https://slurm.schedmd.com/sinfo.html

squeue -u $USER              # how's my job going
scancel <jobid>              # cancel <jobid>
sacctmgr list qos debug format=Name,MaxWall

sbatch script.sh             # submits a batch script to Slurm; 

the script itself should start with something like: 
#!/bin/bash -l               # -l (small L) option invokes ~/.cshrc settings
#SBATCH -A marine-cpu        # -A specifies the account
#SBATCH -n 1                 # -n specifies the number of tasks (cores) (-N would be for number of nodes) 
#SBATCH --exclusive          # exclusive use of node - hoggy but OK
#SBATCH -q debug             # -q specifies the queue; debug has a 30 min limit, but the default walltime is only 5min, to change, see below:
#SBATCH -t 30                # -t specifies walltime in minutes; if in debug, cannot be more than 30

or
#SBATCH -q batch
#SBATCH -t 120      # or whatever else is appropriate
