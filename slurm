https://rdhpcs-common-docs.rdhpcs.noaa.gov/wikis/rdhpcs-common-docs/doku.php?id=a-quick-introduction-to-slurm
https://docs.google.com/presentation/d/1OhGP1j7Irx61iqDq0jagTWCMRXIGgnUiwNrGfk9NMmM/edit#slide=id.g51f1a10247_0_407
https://rdhpcs-common-docs.rdhpcs.noaa.gov/wikis/rdhpcs-common-docs/doku.php?id=slurm#mapping_of_commands_and_options_from_pbs_to_slurm


module load slurm                             # no longer needed as of May 8, 2019

sshare -U $USER                               # tells me what accounts are available to me
sinfo                                         # see partition and node information ; see https://slurm.schedmd.com/sinfo.html

squeue -u $USER                               # how's my job going
scontrol show -d job 410805                   # info on job id 41805 (including work dir)
scancel <jobid>                               # cancel <jobid>
saccount_params                               # tells you about proportion use

sacctmgr show qos                             # tells me what are available ques; https://slurm.schedmd.com/sacctmgr.html
sacctmgr list qos format=Name,MaxWall         # tells you the max time limit for the all queue
sacctmgr list qos debug format=Name,MaxWall   # tells you the max time limit for the debug queue
sacctmgr show cos format=name,priority        # tells you the priority of different queues (1 is lowest 100 is highest)
                                              # priority of urgent>debug>batch>>windfall
 windfall          1 
maximum-q+        100 
     batch         20 
     debug         30 
    urgent         40 
     novel         50 

sbatch script.sh             # submits a batch script to Slurm; 

# The script itself should start with something like: 
#!/bin/bash -l               
                             # -l (small L) option invokes ~/.cshrc settings (but #comments aren't allowed on that line)
#SBATCH -A marine-cpu        # -A specifies the account
#SBATCH -n 1                 # -n specifies the number of tasks (cores) (-N would be for number of nodes) 
#SBATCH --exclusive          # exclusive use of node - hoggy but OK
#SBATCH -q debug             # -q specifies the queue; debug has a 30 min limit, but the default walltime is only 5min, to change, see below:
#SBATCH -t 30                # -t specifies walltime in minutes; if in debug, cannot be more than 30

or
#SBATCH -q batch
#SBATCH -t 120      # or whatever else is appropriate
